"""Update the formula using GitHub's published release asset SHA256 digests."""

import json
from pathlib import Path
import re
import sys


TARGETS = ("aarch64-apple-darwin", "x86_64-apple-darwin", "x86_64-unknown-linux-gnu")
VERSION = r"(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)"


def update_formula(formula, release):
    if release.get("draft") is not False or release.get("prerelease") is not False:
        raise ValueError("Only published stable releases may update Homebrew")
    tag = release.get("tag_name", "")
    match = re.fullmatch("v" + VERSION, tag)
    if not match:
        raise ValueError("Invalid stable release tag")
    version = tag[1:]
    current = re.findall(r'^  version "(' + VERSION + r')"$', formula, re.MULTILINE)
    if len(current) != 1:
        raise ValueError("Expected exactly one formula version")
    if tuple(map(int, version.split("."))) < tuple(map(int, current[0][0].split("."))):
        raise ValueError("Refusing to downgrade the formula")

    updated = re.sub(r'^  version "' + VERSION + r'"$', lambda _: f'  version "{version}"', formula, flags=re.MULTILINE)
    for target in TARGETS:
        name = f"leveler-{tag}-{target}.tar.gz"
        assets = [asset for asset in release["assets"] if asset["name"] == name]
        if len(assets) != 1:
            raise ValueError(f"Expected exactly one release asset: {name}")
        digest = assets[0].get("digest")
        if not isinstance(digest, str) or not re.fullmatch(r"sha256:[0-9a-f]{64}", digest):
            raise ValueError(f"Missing or invalid GitHub SHA256 digest: {name}")
        url = f'https://github.com/dengmengmian/CodeLeveler/releases/download/v#{{version}}/leveler-v#{{version}}-{target}.tar.gz'
        pattern = r'(url "' + re.escape(url) + r'"\n\s+sha256 ")[0-9a-f]{64}(\")'
        updated, count = re.subn(pattern, lambda m: m[1] + digest[7:] + m[2], updated)
        if count != 1:
            raise ValueError(f"Unrecognized formula layout for {target}")
    return updated


if __name__ == "__main__":
    path = Path(__file__).resolve().parents[1] / "Formula/leveler.rb"
    formula = path.read_text()
    updated = update_formula(formula, json.load(sys.stdin))
    if updated != formula:
        path.write_text(updated)
        print("Updated Formula/leveler.rb")
    else:
        print("Formula/leveler.rb is already up to date")
