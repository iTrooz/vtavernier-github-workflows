# [1.0.0-alpha.9](https://github.com/vtavernier/github-workflows/compare/v1.0.0-alpha.8...v1.0.0-alpha.9) (2023-01-02)


### Features

* add build-rust-bin workflow ([4ecb426](https://github.com/vtavernier/github-workflows/commit/4ecb426524b14ac90440cd3f69cc96fb7cd86ec1))
* add pullrequest-semantic workflow ([ec2ac84](https://github.com/vtavernier/github-workflows/commit/ec2ac84732c7c0c0570e632f98affd83a72a6ca4))
* **build-rust-bin:** add coverage support ([7a7f14d](https://github.com/vtavernier/github-workflows/commit/7a7f14d1245d9fe8c1878548b6d8326dfcca6d93))
* **release-semantic:** add support for CARGO_REGISTRY_TOKEN ([7d65819](https://github.com/vtavernier/github-workflows/commit/7d658199e9a6a0f39fec66c349c8e8c2b33260b6))

# [1.0.0-alpha.8](https://github.com/vtavernier/github-workflows/compare/v1.0.0-alpha.7...v1.0.0-alpha.8) (2022-11-16)


### Bug Fixes

* **rust-docker:** fix workflow outputs ([f8f2e23](https://github.com/vtavernier/github-workflows/commit/f8f2e233143360ea047b84aff354bd8c62347d1a))
* **rust-docker:** update develop branch back on release ([6ca146c](https://github.com/vtavernier/github-workflows/commit/6ca146c8127ca63dbe30530bc7fe2cf81e6bffb7))

# [1.0.0-alpha.7](https://github.com/vtavernier/github-workflows/compare/v1.0.0-alpha.6...v1.0.0-alpha.7) (2022-11-13)


### Features

* **rust-docker:** add develop_branch_name input ([513fb9c](https://github.com/vtavernier/github-workflows/commit/513fb9c08b321231bbf4cdaadcd0b62ce1240ae5))
* **rust:** add check workflow ([99b2793](https://github.com/vtavernier/github-workflows/commit/99b2793eed31c5103b0c5a314f1d1ec7eb0f4855))

# [1.0.0-alpha.6](https://github.com/vtavernier/github-workflows/compare/v1.0.0-alpha.5...v1.0.0-alpha.6) (2022-11-10)


### Features

* **rust-docker:** add docker image metadata ([241b20c](https://github.com/vtavernier/github-workflows/commit/241b20c0f7c22cfcab0f7a39fb2c4bd1e0fdc71b))

# [1.0.0-alpha.5](https://github.com/vtavernier/github-workflows/compare/v1.0.0-alpha.4...v1.0.0-alpha.5) (2022-11-02)


### Bug Fixes

* **rust-docker:** do not create multiple caches ([d8d2574](https://github.com/vtavernier/github-workflows/commit/d8d25747b5cfc98b83807f6465aca060888bfdf3))
* **rust-docker:** fetch dependencies before cargo-make ([4c613fb](https://github.com/vtavernier/github-workflows/commit/4c613fb11e9cb42e39b3a40aef518d947b796cf5))
* **rust-docker:** only bump version in the build job ([45de35f](https://github.com/vtavernier/github-workflows/commit/45de35f93c9d244eeb59e35147348d755a0ed4cf))
* **workflows:** fix commitlint range ([fa0d56e](https://github.com/vtavernier/github-workflows/commit/fa0d56e7db7e6bc7fd60d1b7a64ad0dd95f97449))

# [1.0.0-alpha.4](https://github.com/vtavernier/github-workflows/compare/v1.0.0-alpha.3...v1.0.0-alpha.4) (2022-10-31)


### Bug Fixes

* **rust-docker:** fix caching behavior ([58f7c1c](https://github.com/vtavernier/github-workflows/commit/58f7c1c99c2501b2efd09c38054aa769d84e739d))


### Features

* **rust-docker:** add build workflow ([60599b5](https://github.com/vtavernier/github-workflows/commit/60599b58044b87e7f36cce52e40c2abf3d407371))
* **rust-docker:** add checks job ([6482379](https://github.com/vtavernier/github-workflows/commit/64823792efcde1f9f801cb8d1e32f63475d6aed0))
* **rust-docker:** add ci-pre-check task ([00a52b4](https://github.com/vtavernier/github-workflows/commit/00a52b480588101494181a923df060d0c8df8b22))
* **rust-docker:** add Docker image name outputs ([d83f1a2](https://github.com/vtavernier/github-workflows/commit/d83f1a2217217ab7cfedf74ec04e42bd68c4127b))
* **rust-docker:** add semantic-release outputs ([e0adbba](https://github.com/vtavernier/github-workflows/commit/e0adbba6c11c8179fc53008b1f81eb7968c64433))
* **rust-docker:** add test job ([984b225](https://github.com/vtavernier/github-workflows/commit/984b2252be016a48de4a60068620fb3549fe20ee))
* **rust-docker:** expose checks arguments ([e4f6654](https://github.com/vtavernier/github-workflows/commit/e4f6654af5017b28d7aace3cb4da3f88564726fa))
* **rust-docker:** expose Dockerfile path input ([7db98bb](https://github.com/vtavernier/github-workflows/commit/7db98bb4f7a3d022df3e5d4192daf159ddb6def5))
* **rust-docker:** run hadolint in checks ([ee7313a](https://github.com/vtavernier/github-workflows/commit/ee7313ad85dc2015a2360de56bbca3475658273f))
* **rust-docker:** support dependabot updates ([2f9a8e6](https://github.com/vtavernier/github-workflows/commit/2f9a8e6178e1942c2117f37b3767edc223265ed8))

# [1.0.0-alpha.3](https://github.com/vtavernier/github-workflows/compare/v1.0.0-alpha.2...v1.0.0-alpha.3) (2022-10-18)


### Features

* update actions/checkout to v3 ([8b9621a](https://github.com/vtavernier/github-workflows/commit/8b9621a29c2e09751782dbc623129b95da5f84db))

# [1.0.0-alpha.2](https://github.com/vtavernier/github-workflows/compare/v1.0.0-alpha.1...v1.0.0-alpha.2) (2022-10-18)


### Bug Fixes

* use GITHUB_TOKEN for semantic-release ([eb920e6](https://github.com/vtavernier/github-workflows/commit/eb920e6d593ee643360b12c7d5029d1b2cc0c709))

# 1.0.0-alpha.1 (2022-10-18)


### Features

* add semantic-release ([3065706](https://github.com/vtavernier/github-workflows/commit/30657065dc63f810a2daf9eed5fa081bc51b3f6d))
* initial release ([6de0c89](https://github.com/vtavernier/github-workflows/commit/6de0c893a63c5fe2dd0d960565461e8dc34661a8))
