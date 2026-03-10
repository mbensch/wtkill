# Contributing

## Requirements

- bash 4+
- git
- fzf
- [shellcheck](https://www.shellcheck.net/) (for linting)
- [bats](https://github.com/bats-core/bats-core) (for tests)

## Making changes

1. Fork the repo and create a branch from `main`.
2. Make your changes to the `wtkill` script.
3. Lint your changes: `shellcheck wtkill install.sh`
4. Run the test suite: `bats test/`
5. Test manually against a real git repo that has multiple worktrees.
6. Open a PR — the template will guide you.

## Commit messages

Follow [Conventional Commits](https://www.conventionalcommits.org/). This drives automated versioning via release-please:

| Prefix | Release |
|---|---|
| `fix:` | patch |
| `feat:` | minor |
| `feat!:` or `BREAKING CHANGE:` footer | major |
| `chore:`, `docs:`, `refactor:`, `test:` | none |

**Never edit `VERSION` in `wtkill` manually** — it is bumped automatically when a Release PR is merged.

## Reporting issues

Use the GitHub issue templates for bug reports and feature requests.
