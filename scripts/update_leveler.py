"""Update the formula using GitHub's published release asset SHA256 digests."""

import json
from pathlib import Path
import re
import sys


TARGETS = ("aarch64-apple-darwin", "x86_64-apple-darwin", "x86_64-unknown-linux-gnu")
VERSION = r"(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)"
DOWNLOAD = "https://github.com/dengmengmian/CodeLeveler/releases/download"


def formula_version(formula):
    """The version the formula pins today, from the one URL it downloads from.

    Homebrew scans the version from an asset URL, so the formula states it
    there and nowhere else; a second `version` stanza is rejected by
    `brew audit --strict` as redundant.
    """
    found = {
        ".".join(parts)
        for parts in re.findall(r"releases/download/v" + VERSION + r"/", formula)
    }
    if len(found) != 1:
        raise ValueError("Expected exactly one formula version")
    return found.pop()


def update_formula(formula, release):
    if release.get("draft") is not False or release.get("prerelease") is not False:
        raise ValueError("Only published stable releases may update Homebrew")
    tag = release.get("tag_name", "")
    match = re.fullmatch("v" + VERSION, tag)
    if not match:
        raise ValueError("Invalid stable release tag")
    version = tag[1:]
    current = formula_version(formula)
    if tuple(map(int, version.split("."))) < tuple(map(int, current.split("."))):
        raise ValueError("Refusing to downgrade the formula")

    updated = formula.replace(
        f"{DOWNLOAD}/v{current}/", f"{DOWNLOAD}/v{version}/"
    ).replace(f"leveler-v{current}-", f"leveler-v{version}-")
    for target in TARGETS:
        name = f"leveler-{tag}-{target}.tar.gz"
        assets = [asset for asset in release["assets"] if asset["name"] == name]
        if len(assets) != 1:
            raise ValueError(f"Expected exactly one release asset: {name}")
        digest = assets[0].get("digest")
        if not isinstance(digest, str) or not re.fullmatch(r"sha256:[0-9a-f]{64}", digest):
            raise ValueError(f"Missing or invalid GitHub SHA256 digest: {name}")
        url = f'{DOWNLOAD}/v{version}/leveler-v{version}-{target}.tar.gz'
        pattern = r'(url "' + re.escape(url) + r'"\n\s+sha256 ")[0-9a-f]{64}(")'
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
