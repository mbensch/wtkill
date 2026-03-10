# AGENTS.md

## Commits

Use conventional commit messages. These drive automated versioning:

- `fix:` — patch release (bug fixes)
- `feat:` — minor release (new features)
- `feat!:` or `BREAKING CHANGE:` footer — major release
- `chore:`, `docs:`, `refactor:`, `test:` — no release

## Versioning

**Never edit `VERSION` in `wtkill` manually.** Versioning is fully automated
via release-please. On every merge to `main`, a Release PR is created or
updated. Merging that Release PR bumps the version in `wtkill`, updates
`CHANGELOG.md`, creates a git tag, and publishes a GitHub Release.

## Changelog

Do not edit `CHANGELOG.md` manually. It is auto-generated from commit messages
by release-please.

## Testing

Before opening a PR, run:

```sh
shellcheck wtkill install.sh
bats test/
```

All ShellCheck warnings must be clean and all bats tests must pass.
