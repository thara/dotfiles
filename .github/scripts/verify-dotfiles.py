"""Check that bootstrap applied exactly the groups for this runner's OS."""

import json
import sys
from pathlib import Path

expected = {"shell", "vim", "git", "config", "bin", "mise"}
if sys.platform == "darwin":
    expected.update({"macos", "agents"})
elif sys.platform != "linux":
    raise SystemExit(f"Unsupported platform: {sys.platform}")

status = json.load(sys.stdin)
entries = status["files"]
actual = {Path(entry["origin"]["source"]).name for entry in entries}
if actual != expected or len(entries) != len(expected):
    raise SystemExit(f"Expected groups {sorted(expected)}, got {sorted(actual)}")
for entry in entries:
    if entry["state"] != "applied":
        raise SystemExit(f"Dotfiles not applied: {entry}")

target = Path.home() / ".config/mise/mise.toml"
source = Path(__file__).resolve().parents[2] / "mise/.config/mise/mise.toml"
if not target.is_symlink() or target.resolve() != source:
    raise SystemExit(f"Global mise configuration does not link to {source}")

print(f"Verified {len(expected)} groups and the global mise configuration link.")
