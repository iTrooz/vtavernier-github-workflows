# [check-rust](../.github/workflows/check-rust.yml)

![Workflow type: check](https://img.shields.io/badge/workflow-check-blue)
![Type: rust](https://img.shields.io/badge/type-rust-green)

This workflow checks Rust projects.

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
      - dev # If you have a "develop" branch
    tags-ignore:
      - "**"

jobs:
  check:
    uses: vtavernier/github-workflows/.github/workflows/check-rust.yml@WORKFLOW_VERSION
```
