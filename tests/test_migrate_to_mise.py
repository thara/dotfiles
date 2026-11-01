"""Integration checks using mise and isolated repositories/homes."""
import hashlib
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

REPO = Path(__file__).resolve().parents[1]
MISE = shutil.which('mise')


@unittest.skipUnless(MISE, 'mise is required')
class MigrationTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='test-mise-migration-')
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name).resolve()
        self.repo = self.root / 'repo'
        self.home = self.root / 'home'
        self.repo.mkdir()
        self.home.mkdir()
        (self.repo / 'scripts').mkdir()
        shutil.copy2(REPO / 'scripts/migrate-to-mise.py', self.repo / 'scripts/migrate-to-mise.py')
        (self.repo / 'mise.toml').write_text('''min_version = "2026.10.18"
[settings.dotfiles]
root = "."
[dotfile_groups.vim]
root = "vim"
target = "~"
mode = "symlink-each"
exclude = [".vim/plugged/**"]
[dotfile_groups.git]
root = "git"
target = "~"
mode = "symlink-each"
''')
        for name in ['vim/.vimrc', 'vim/.vim/pack/github/plugin.vim',
                     'vim/.vim/ftplugin/example.vim', 'vim/.vim/plugged/runtime.vim',
                     'git/.gitconfig', 'git/.gitmessage.txt']:
            p = self.repo / name
            p.parent.mkdir(parents=True, exist_ok=True)
            p.write_text('fixture\n')
        for target, source in [('.vim', 'vim/.vim'), ('.vimrc', 'vim/.vimrc'), ('.gitconfig', 'git/.gitconfig')]:
            (self.home / target).symlink_to(os.path.relpath(self.repo / source, self.home))
        self.env = dict(os.environ, HOME=str(self.home), MISE_STATE_DIR=str(self.root / 'state'))
        self.before = self.hashes()

    def hashes(self):
        return {str(p.relative_to(self.repo)): hashlib.sha256(p.read_bytes()).hexdigest()
                for p in self.repo.rglob('*') if p.is_file()}

    def run_script(self, *args):
        return subprocess.run(['python3', str(self.repo / 'scripts/migrate-to-mise.py'), *args],
                              cwd=self.root, env=self.env, text=True, capture_output=True)

    def test_preview_apply_and_repeat_preserve_sources_and_exclusions(self):
        original = os.readlink(self.home / '.vim')
        result = self.run_script()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(os.readlink(self.home / '.vim'), original)
        for _ in range(2):
            result = self.run_script('--apply')
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(self.hashes(), self.before)
        self.assertFalse((self.home / '.vim').is_symlink())
        self.assertFalse((self.home / '.vim/pack/github').is_symlink())
        self.assertTrue((self.home / '.vim/pack/github/plugin.vim').is_symlink())
        self.assertTrue((self.home / '.vim/plugged').is_symlink())
        self.assertEqual((self.home / '.vim/plugged/runtime.vim').read_text(), 'fixture\n')

    def test_conflict_stops_before_changes(self):
        target = self.home / '.gitconfig'
        target.unlink()
        target.write_text('personal settings\n')
        result = self.run_script('--apply')
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('Conflicting paths', result.stderr)
        self.assertTrue((self.home / '.vim').is_symlink())
        self.assertEqual(target.read_text(), 'personal settings\n')
        self.assertEqual(self.hashes(), self.before)

    def test_failed_apply_restores_original_links(self):
        bindir = self.root / 'bin'
        bindir.mkdir()
        wrapper = bindir / 'mise'
        wrapper.write_text('#!/usr/bin/env python3\nimport os,sys,subprocess\n'
                           f'if os.environ.get("HOME") == {str(self.home)!r} and "bootstrap" in sys.argv and "--yes" in sys.argv:\n'
                           f' subprocess.run([{MISE!r}, *sys.argv[1:]], check=True)\n sys.exit(77)\n'
                           f'os.execv({MISE!r}, [{MISE!r}, *sys.argv[1:]])\n')
        wrapper.chmod(0o755)
        self.env['PATH'] = str(bindir) + os.pathsep + os.environ['PATH']
        before = {p.name: os.readlink(p) for p in self.home.iterdir()}
        result = self.run_script('--apply')
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual({p.name: os.readlink(p) for p in self.home.iterdir()}, before)
        self.assertEqual(self.hashes(), self.before)


if __name__ == '__main__':
    unittest.main()
