# [build-go-docker](../.github/workflows/build-go-docker.yml)

![Workflow type: build](https://img.shields.io/badge/workflow-build-blue)
![Type: go-docker](https://img.shields.io/badge/type-go-docker-green)

This workflow builds Go projects to Docker images.

## Workflow setup

Recommended `.github/workflows/build.yml`:

```yaml
name: build

on:
  pull_request: {}
  push:
    branches:
      - master
      - dev # If you have a "develop" branch
    tags-ignore:
      - "**"

jobs:
  build:
    uses: vtavernier/github-workflows/.github/workflows/build-go-docker.yml@WORKFLOW_VERSION
    with:
      develop_branch_name: dev # If you have a `develop` branch
    secrets:
      docker_password: ${{ secrets.GITHUB_TOKEN }}
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
        "assets": ["CHANGELOG.md"],
        "message": "chore(release): ${nextRelease.version} [skip ci]\n\n${nextRelease.notes}"
      }
    ],
    "@semantic-release/github"
  ]
}
```
