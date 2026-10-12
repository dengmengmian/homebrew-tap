import copy
from pathlib import Path
import unittest

from update_leveler import update_formula


TARGETS = ("aarch64-apple-darwin", "x86_64-apple-darwin", "x86_64-unknown-linux-gnu")


class UpdateLevelerTests(unittest.TestCase):
    def setUp(self):
        self.formula = (Path(__file__).resolve().parents[1] / "Formula/leveler.rb").read_text()
        self.release = {
            "tag_name": "v99.0.0", "draft": False, "prerelease": False,
            "assets": [
                {"name": f"leveler-v99.0.0-{target}.tar.gz", "digest": "sha256:" + str(index) * 64}
                for index, target in enumerate(TARGETS, 1)
            ],
        }

    def test_updates_version_and_each_platform_checksum(self):
        updated = update_formula(self.formula, self.release)
        self.assertIn('version "99.0.0"', updated)
        for index, target in enumerate(TARGETS, 1):
            self.assertIn(f'{target}.tar.gz"\n      sha256 "' + str(index) * 64 + '"', updated)
        self.assertIn('bin.install "leveler"', updated)
        self.assertEqual(update_formula(updated, self.release), updated)

    def test_rejects_incomplete_or_untrusted_release(self):
        cases = []
        for field in ("draft", "prerelease"):
            release = copy.deepcopy(self.release)
            release[field] = True
            cases.append(release)
        release = copy.deepcopy(self.release)
        release["tag_name"] = 'v99.0.0\"; system("bad")'
        cases.append(release)
        release = copy.deepcopy(self.release)
        release["assets"].pop()
        cases.append(release)
        release = copy.deepcopy(self.release)
        release["assets"][0]["digest"] = None
        cases.append(release)
        release = copy.deepcopy(self.release)
        release["assets"].append(release["assets"][0])
        cases.append(release)
        release = copy.deepcopy(self.release)
        release["tag_name"] = "v0.0.1"
        cases.append(release)
        for release in cases:
            with self.subTest(release=release):
                with self.assertRaises(ValueError):
                    update_formula(self.formula, release)

    def test_rejects_unrecognized_formula_layout(self):
        with self.assertRaises(ValueError):
            update_formula(self.formula.replace('sha256 "', 'checksum "', 1), self.release)


if __name__ == "__main__":
    unittest.main()
