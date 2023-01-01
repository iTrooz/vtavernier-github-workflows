# [build-rust-bin](../.github/workflows/build-rust-bin.yml)

![Workflow type: build](https://img.shields.io/badge/workflow-build-blue)
![Type: rust-bin](https://img.shields.io/badge/type-rust-bin-green)

This workflow builds Rust binaries using [cargo-make](https://github.com/sagiegurari/cargo-make).

## Rust setup

Setup your toolchain requirements in `rust-toolchain.toml`:

```toml
[toolchain]
channel = "1.63.0"
components = [
  "rustfmt",
  "clippy",
]
profile = "minimal"
```

## Workflow setup

Recommended `.github/workflows/build.yml`:

```yaml
name: build

on:
  pull_request: {}
  push:
    branches:
      - master
      - dev
    tags-ignore:
      - "**"

jobs:
  build:
    uses: vtavernier/github-workflows/.github/workflows/build-rust-bin.yml@WORKFLOW_VERSION
    secrets:
      # Used by semantic-release for pushing to master
      GH_TOKEN: ${{ secrets.GH_TOKEN || secrets.GITHUB_TOKEN }}
```

## semantic-release

Recommended `.releaserc.json`:

```json
{
  "plugins": [
    "@semantic-release/commit-analyzer",
    "@semantic-release/release-notes-generator",
    "@semantic-release/changelog",
    [
      "@semantic-release/git",
      {
        "assets": ["CHANGELOG.md", "Cargo.lock", "Cargo.toml"],
        "message": "chore(release): ${nextRelease.version} [skip ci]\n\n${nextRelease.notes}"
      }
    ],
    [
      "@semantic-release/github",
      {
        "assets": "dist/*"
      }
    ]
  ]
}
```
