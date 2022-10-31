# [build-rust-docker](../.github/workflows/build-rust-docker.yml)

![Workflow type: build](https://img.shields.io/badge/workflow-build-blue)
![Type: rust-docker](https://img.shields.io/badge/type-rust-docker-green)

This workflow builds Rust projects to Docker images using [cargo-make](https://github.com/sagiegurari/cargo-make).

#

## Workflow setup

#

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
    uses: vtavernier/github-workflows/.github/workflows/build-rust-docker.yml@WORKFLOW_VERSION
    secrets:
      docker_password: ${{ secrets.GITHUB_TOKEN }}
      # Used by semantic-release for pushing to master
      GH_TOKEN: ${{ secrets.GH_TOKEN }}
```

#

## semantic-release

#

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
    "@semantic-release/github"
  ]
}
```
