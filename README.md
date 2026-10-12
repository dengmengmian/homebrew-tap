# dengmengmian/homebrew-tap

Homebrew tap for [AgentGate](https://github.com/dengmengmian/agentgate-ai) — a local AI gateway that routes, converts, fails over, and traces model requests.

## Install

```bash
brew tap dengmengmian/tap
brew install --cask agentgate
```

Or in one line:

```bash
brew install --cask dengmengmian/tap/agentgate
```

## Upgrade

```bash
brew upgrade --cask agentgate
```

AgentGate also ships a built-in updater, so the app can update itself between cask bumps.

## Formulae

[ReviewGate](https://github.com/dengmengmian/ReviewGate) — pre-merge quality gate for AI-generated code:

```bash
brew install dengmengmian/tap/reviewgate
```

[CodeLeveler](https://github.com/dengmengmian/CodeLeveler) — local-first coding agent CLI (`leveler`):

```bash
brew install dengmengmian/tap/leveler
```

Upgrade with `brew update && brew upgrade leveler`.

The `Update CodeLeveler formula` workflow checks the latest published stable
CodeLeveler release every hour (GitHub may delay scheduled runs). It updates
the version and all three platform SHA256 values from GitHub's release asset
digests, and commits only when the formula changes. It can also be run manually
on `main` with `workflow_dispatch`. No cross-repository token is required;
the workflow uses this tap's `GITHUB_TOKEN` with `contents: write`.
Repository rules must permit that token to push the formula update to `main`.

To update locally using the same release metadata:

```bash
gh api repos/dengmengmian/CodeLeveler/releases/latest > /tmp/leveler-release.json
python3 scripts/update_leveler.py < /tmp/leveler-release.json
python3 -m unittest discover -s scripts -p 'test_update_leveler.py'
```
