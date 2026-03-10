#!/usr/bin/env bats

setup() {
  WTKILL="$BATS_TEST_DIRNAME/../wtkill"
  # Find the first bash ≥4 available (Homebrew on macOS, system on Linux)
  BASH_BIN=""
  for _b in /opt/homebrew/bin/bash /usr/local/bin/bash /usr/bin/bash /bin/bash; do
    if [[ -x "$_b" ]] && [[ "$("$_b" -c 'echo ${BASH_VERSINFO[0]}')" -ge 4 ]]; then
      BASH_BIN="$_b"
      break
    fi
  done
  [[ -n "$BASH_BIN" ]] || { echo "bash 4+ not found" >&2; exit 1; }
}

# ── --version ────────────────────────────────────────────────────────────────

@test "--version prints version string" {
  run "$BASH_BIN" "$WTKILL" --version
  [ "$status" -eq 0 ]
  [[ "$output" =~ ^wtkill\ [0-9]+\.[0-9]+\.[0-9]+$ ]]
}

@test "-V is an alias for --version" {
  run "$BASH_BIN" "$WTKILL" -V
  [ "$status" -eq 0 ]
  [[ "$output" =~ ^wtkill\  ]]
}

# ── --help ───────────────────────────────────────────────────────────────────

@test "--help exits successfully" {
  run "$BASH_BIN" "$WTKILL" --help
  [ "$status" -eq 0 ]
}

@test "--help documents --dry-run" {
  run "$BASH_BIN" "$WTKILL" --help
  [[ "$output" == *"--dry-run"* ]]
}

@test "--help documents --report-only" {
  run "$BASH_BIN" "$WTKILL" --help
  [[ "$output" == *"--report-only"* ]]
}

@test "--help documents --update" {
  run "$BASH_BIN" "$WTKILL" --help
  [[ "$output" == *"--update"* ]]
}

@test "-h is an alias for --help" {
  run "$BASH_BIN" "$WTKILL" -h
  [ "$status" -eq 0 ]
  [[ "$output" == *"Usage:"* ]]
}

# ── Unknown options ───────────────────────────────────────────────────────────

@test "unknown option exits with error" {
  run "$BASH_BIN" "$WTKILL" --bogus
  [ "$status" -ne 0 ]
}

@test "unknown option prints message to stderr" {
  run "$BASH_BIN" "$WTKILL" --bogus
  [[ "$output" == *"Unknown option"* ]]
}

# ── Not in a git repo ─────────────────────────────────────────────────────────

@test "fails gracefully outside a git repo" {
  run "$BASH_BIN" -c "cd /tmp && '$BASH_BIN' '$WTKILL'"
  [ "$status" -ne 0 ]
}
