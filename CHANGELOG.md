# Changelog

## [1.4.3](https://github.com/mbensch/wtkill/compare/v1.4.2...v1.4.3) (2026-03-10)


### Bug Fixes

* annotate VERSION for release-please generic updater ([#10](https://github.com/mbensch/wtkill/issues/10)) ([e33e49b](https://github.com/mbensch/wtkill/commit/e33e49bcb80962ddf43a01863330de30f9874a60))

## [1.4.2](https://github.com/mbensch/wtkill/compare/v1.4.1...v1.4.2) (2026-03-10)


### Bug Fixes

* correct VERSION to 1.4.1 and add -v shorthand for --version ([#8](https://github.com/mbensch/wtkill/issues/8)) ([4acf702](https://github.com/mbensch/wtkill/commit/4acf7026f2d7ed31b06c50c50b903c1958569c15))

## [1.4.1](https://github.com/mbensch/wtkill/compare/v1.4.0...v1.4.1) (2026-03-10)


### Bug Fixes

* wrap install.sh body in main() to prevent curl broken pipe ([#6](https://github.com/mbensch/wtkill/issues/6)) ([1f6806c](https://github.com/mbensch/wtkill/commit/1f6806c65f8dbd806c5023d099f48ae1362f7fc2))

## [1.4.0](https://github.com/mbensch/wtkill/compare/v1.3.0...v1.4.0) (2026-03-10)


### Features

* add ShellCheck linting and bats test suite ([#3](https://github.com/mbensch/wtkill/issues/3)) ([675a4c0](https://github.com/mbensch/wtkill/commit/675a4c08fc095cf5e65ee835c383e8a9dc6ab76a))

## [1.3.0](https://github.com/mbensch/wtkill/compare/v1.2.0...v1.3.0) (2026-03-10)


### Features

* add release-please, self-update, and AGENTS.md ([3a769cf](https://github.com/mbensch/wtkill/commit/3a769cf6ce26640ca18fdb96c0a385418c91afe8))
* initial commit ([d5c8942](https://github.com/mbensch/wtkill/commit/d5c89429e936f82ec4bc8ac5631c15e61aff0ec2))


### Bug Fixes

* add issues write permission and opt into Node.js 24 for release-please ([960c18d](https://github.com/mbensch/wtkill/commit/960c18d50944f93964d670798879a58eeb0da552))

## [1.2.0](https://github.com/mbensch/wtkill/releases/tag/v1.2.0)

- Initial public release
- Interactive TUI for worktree cleanup
- Squash-merge detection
- fzf-based individual selection
- Dry-run mode
- Configurable stale threshold via `--stale-days` and `GIT_WT_CLEAN_STALE_DAYS`
