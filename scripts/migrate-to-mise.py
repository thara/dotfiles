#!/usr/bin/env python3
"""Migrate this checkout's Stow links to mise (preview unless --apply)."""

import argparse
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile

REPO = Path(__file__).resolve().parents[1]


def run(command, env):
    result = subprocess.run(command, cwd=REPO, env=env, text=True, capture_output=True)
    if result.returncode:
        raise RuntimeError(result.stdout + result.stderr)
    return result.stdout


def exists(path):
    return os.path.lexists(path)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--apply', action='store_true', help='perform the migration')
    args = parser.parse_args()
    if not shutil.which('mise'):
        parser.error('Install mise 2026.10.18 or newer first.')
    home = Path.home().resolve()
    # A separate home lets mise itself expand groups and excludes; no glob rules
    # or OS selection logic are duplicated here.
    with tempfile.TemporaryDirectory(prefix='mise-migration-plan-') as temporary:
        scratch = Path(temporary).resolve()
        preview_home = scratch / 'home'
        preview_home.mkdir()
        env = dict(os.environ)
        for key in list(env):
            if key.startswith('MISE_'):
                del env[key]
        env.update(HOME=str(preview_home), MISE_CONFIG_DIR=str(scratch / 'config'),
                   MISE_STATE_DIR=str(scratch / 'state'), MISE_DATA_DIR=str(scratch / 'data'),
                   MISE_CACHE_DIR=str(scratch / 'cache'), MISE_YES='1')
        run(['mise', 'trust'], env)
        status = json.loads(run(['mise', 'dot', 'status', '--json'], env))
        if not status['files'] or status.get('edits'):
            raise RuntimeError('Expected whole-file dotfile groups, without edit entries.')
        for entry in status['files']:
            if entry['target'] not in ('~', str(preview_home)) or entry['mode'] != 'symlink-each':
                raise RuntimeError('Only symlink-each groups targeting ~ are supported.')
            source = Path(entry['origin']['source']).resolve()
            if REPO not in source.parents:
                raise RuntimeError('All group sources must be inside this checkout.')
        run(['mise', 'bootstrap', '--only', 'dotfiles', '--yes'], env)
        planned = {}
        for path in preview_home.rglob('*'):
            if path.is_symlink():
                source = path.resolve()
                if REPO not in source.parents:
                    raise RuntimeError('A planned source points outside this checkout.')
                planned[home / path.relative_to(preview_home)] = source
        if not planned:
            raise RuntimeError('No file links were planned.')

        conversions = {}
        old_links = {}
        conflicts = []
        for target, source in planned.items():
            parent = target.parent
            source_parent = source.parent
            under_conversion = False
            while parent != home:
                if parent.resolve() != parent:
                    if parent.resolve() != source_parent:
                        conflicts.append(str(parent))
                    else:
                        conversions[parent] = os.readlink(parent) if parent.is_symlink() else str(source_parent)
                        under_conversion = True
                elif exists(parent) and not parent.is_dir():
                    conflicts.append(str(parent))
                parent = parent.parent
                source_parent = source_parent.parent
            if not under_conversion and exists(target):
                if not target.is_symlink() or target.resolve() != source:
                    conflicts.append(str(target))
                else:
                    old_links[target] = os.readlink(target)
        if conflicts:
            raise RuntimeError('Conflicting paths; nothing changed:\n' + '\n'.join(sorted(set(conflicts))))
        groups = [Path(e['origin']['source']).name for e in status['files']]
        print('Groups: ' + ', '.join(groups))
        print(f'{len(planned)} file links; {len(conversions)} directory links to expand.')
        for path in sorted(conversions):
            print(f'  Expand directory link: {path}')
        if not args.apply:
            print('Preview only. Keep a terminal open, then rerun with --apply.')
            return

        backup = Path(tempfile.mkdtemp(prefix='mise-migration-backup-'))
        journal = {'repository': str(REPO), 'home': str(home),
                   'original_file_links': {str(p): v for p, v in old_links.items()},
                   'directory_links': {str(p): v for p, v in conversions.items()},
                   'planned_links': {str(p): str(s) for p, s in planned.items()}}
        (backup / 'links.json').write_text(json.dumps(journal, indent=2) + '\n')
        print(f'Link recovery record: {backup / "links.json"}', flush=True)
        expanded = []
        removed = {}
        deploying = False
        try:
            # Work from the outermost directory inward. Preserve every child,
            # including runtime files excluded from mise, as a link first.
            for path in sorted(conversions, key=lambda p: len(p.parts)):
                source = path.resolve()
                original = os.readlink(path)
                children = list(source.iterdir())
                path.unlink()
                path.mkdir()
                expanded.append((path, original, source))
                for child in children:
                    (path / child.name).symlink_to(child)
            for target, source in planned.items():
                if exists(target):
                    if not target.is_symlink() or target.resolve() != source:
                        raise RuntimeError(f'Path changed during migration: {target}')
                    removed[target] = os.readlink(target)
                    target.unlink()
            live_env = dict(env, HOME=str(home))
            # Keep config isolated from unrelated global hooks, but record
            # deployment ownership in the user's normal mise state directory.
            live_env['MISE_STATE_DIR'] = os.environ.get(
                'MISE_STATE_DIR', str(Path(os.environ.get('XDG_STATE_HOME', home / '.local/state')) / 'mise'))
            run(['mise', 'trust'], live_env)
            print(run(['mise', 'bootstrap', '--dry-run', '--only', 'dotfiles'], live_env))
            deploying = True
            print(run(['mise', 'bootstrap', '--only', 'dotfiles', '--yes'], live_env))
            after = json.loads(run(['mise', 'dot', 'status', '--json'], live_env))
            if len(after['files']) != len(status['files']) or any(e['state'] != 'applied' for e in after['files']):
                raise RuntimeError('Some groups are not applied.')
            for target, source in planned.items():
                if not target.is_symlink() or target.resolve() != source:
                    raise RuntimeError(f'Unexpected deployed link: {target}')
        except BaseException:
            # Never replace a regular file or a link changed by another process.
            for target, source in planned.items():
                if not deploying and target not in removed:
                    continue
                if target.is_symlink() and target.resolve() == source:
                    target.unlink()
                if target in removed and not exists(target):
                    target.symlink_to(removed[target])
            for path, original, source in reversed(expanded):
                if path.is_dir() and not path.is_symlink():
                    children = list(path.iterdir())
                    if all(p.is_symlink() and p.resolve() == (source / p.name).resolve() for p in children):
                        for child in children:
                            child.unlink()
                        path.rmdir()
                        path.symlink_to(original)
            print(f'Migration failed. Original links restored where safe; inspect {backup}.')
            raise
        print(f'Migration complete: {len(groups)} groups, {len(planned)} file links verified.')
        print('Excluded runtime paths remain linked. Check a new terminal and application settings saves.')


if __name__ == '__main__':
    try:
        main()
    except (RuntimeError, OSError, ValueError) as error:
        raise SystemExit(str(error))
