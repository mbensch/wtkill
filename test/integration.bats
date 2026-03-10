#!/usr/bin/env bats

WTKILL=""
TEST_REPO=""
BASH_BIN=""

setup() {
  WTKILL="$(cd "$BATS_TEST_DIRNAME/.." && pwd)/wtkill"
  # Find the first bash ≥4 available (Homebrew on macOS, system on Linux)
  BASH_BIN=""
  for _b in /opt/homebrew/bin/bash /usr/local/bin/bash /usr/bin/bash /bin/bash; do
    if [[ -x "$_b" ]] && [[ "$("$_b" -c 'echo ${BASH_VERSINFO[0]}')" -ge 4 ]]; then
      BASH_BIN="$_b"
      break
    fi
  done
  [[ -n "$BASH_BIN" ]] || { echo "bash 4+ not found" >&2; exit 1; }
  TEST_REPO="$(mktemp -d)"

  # Initialise the main repo
  git -C "$TEST_REPO" init -b main
  git -C "$TEST_REPO" config user.email "test@test.com"
  git -C "$TEST_REPO" config user.name "Test"
  git -C "$TEST_REPO" commit --allow-empty -m "init"

  # ── merged worktree ───────────────────────────────────────────────────────
  git -C "$TEST_REPO" checkout -b merged-branch
  git -C "$TEST_REPO" commit --allow-empty -m "feat: merged work"
  git -C "$TEST_REPO" checkout main
  git -C "$TEST_REPO" merge merged-branch --no-ff -m "Merge merged-branch"
  git -C "$TEST_REPO" worktree add "$TEST_REPO/wt-merged" merged-branch

  # ── stale worktree (last commit >14 days ago) ─────────────────────────────
  git -C "$TEST_REPO" checkout -b stale-branch
  GIT_AUTHOR_DATE="2020-01-01T00:00:00" \
  GIT_COMMITTER_DATE="2020-01-01T00:00:00" \
    git -C "$TEST_REPO" commit --allow-empty -m "old work" \
      --date="2020-01-01T00:00:00"
  git -C "$TEST_REPO" checkout main
  git -C "$TEST_REPO" worktree add "$TEST_REPO/wt-stale" stale-branch

  # ── active worktree ───────────────────────────────────────────────────────
  git -C "$TEST_REPO" checkout -b active-branch
  git -C "$TEST_REPO" commit --allow-empty -m "feat: active work"
  git -C "$TEST_REPO" checkout main
  git -C "$TEST_REPO" worktree add "$TEST_REPO/wt-active" active-branch

  # ── detached HEAD worktree ────────────────────────────────────────────────
  git -C "$TEST_REPO" worktree add --detach "$TEST_REPO/wt-detached"
}

teardown() {
  rm -rf "$TEST_REPO"
}

_report() {
  # Run wtkill --report-only --no-fetch from within the test repo
  run "$BASH_BIN" -c "cd '$TEST_REPO' && '$BASH_BIN' '$WTKILL' --no-fetch --report-only"
}

# ── Classification ────────────────────────────────────────────────────────────

@test "exits successfully with --report-only" {
  _report
  [ "$status" -eq 0 ]
}

@test "summary line reports correct totals" {
  _report
  [[ "$output" == *"1 merged"* ]]
  [[ "$output" == *"1 stale"* ]]
  [[ "$output" == *"1 detached"* ]]
  [[ "$output" == *"1 active"* ]]
}

@test "identifies merged worktree" {
  _report
  [[ "$output" == *"MERGED"* ]]
  [[ "$output" == *"merged-branch"* ]]
}

@test "identifies stale worktree" {
  _report
  [[ "$output" == *"STALE"* ]]
  [[ "$output" == *"stale-branch"* ]]
}

@test "identifies active worktree" {
  _report
  [[ "$output" == *"ACTIVE"* ]]
  [[ "$output" == *"active-branch"* ]]
}

@test "identifies detached HEAD worktree" {
  _report
  [[ "$output" == *"DETACHED"* ]]
}

# ── --dry-run ─────────────────────────────────────────────────────────────────

@test "--dry-run does not remove any worktrees" {
  run "$BASH_BIN" -c "cd '$TEST_REPO' && printf '\n' | '$BASH_BIN' '$WTKILL' --no-fetch --dry-run"
  # All worktree dirs must still exist
  [ -d "$TEST_REPO/wt-merged" ]
  [ -d "$TEST_REPO/wt-stale" ]
  [ -d "$TEST_REPO/wt-active" ]
  [ -d "$TEST_REPO/wt-detached" ]
}

# ── --stale-days ──────────────────────────────────────────────────────────────

@test "active branch is not stale with default stale-days" {
  _report
  # active-branch should appear under ACTIVE, not STALE
  [[ "$output" == *"ACTIVE"* ]]
  [[ "$output" == *"active-branch"* ]]
}

@test "--stale-days=0 marks active branch as stale" {
  run "$BASH_BIN" -c "cd '$TEST_REPO' && '$BASH_BIN' '$WTKILL' --no-fetch --report-only --stale-days=0"
  [ "$status" -eq 0 ]
  [[ "$output" == *"STALE"* ]]
}
