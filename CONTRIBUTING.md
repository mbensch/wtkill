# Contributing

## Requirements

- bash 4+
- git
- fzf

## Making changes

1. Fork the repo and create a branch from `main`.
2. Make your changes to the `wtkill` script.
3. Test manually against a real git repo that has multiple worktrees.
4. Open a PR — the template will guide you.

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
