#!/usr/bin/env bats

setup() {
  WTKILL="$BATS_TEST_DIRNAME/../wtkill"
}

# ── --version ────────────────────────────────────────────────────────────────

@test "--version prints version string" {
  run "$WTKILL" --version
  [ "$status" -eq 0 ]
  [[ "$output" =~ ^wtkill\ [0-9]+\.[0-9]+\.[0-9]+$ ]]
}

@test "-V is an alias for --version" {
  run "$WTKILL" -V
  [ "$status" -eq 0 ]
  [[ "$output" =~ ^wtkill\  ]]
}

# ── --help ───────────────────────────────────────────────────────────────────

@test "--help exits successfully" {
  run "$WTKILL" --help
  [ "$status" -eq 0 ]
}

@test "--help documents --dry-run" {
  run "$WTKILL" --help
  [[ "$output" == *"--dry-run"* ]]
}

@test "--help documents --report-only" {
  run "$WTKILL" --help
  [[ "$output" == *"--report-only"* ]]
}

@test "--help documents --update" {
  run "$WTKILL" --help
  [[ "$output" == *"--update"* ]]
}

@test "-h is an alias for --help" {
  run "$WTKILL" -h
  [ "$status" -eq 0 ]
  [[ "$output" == *"Usage:"* ]]
}

# ── Unknown options ───────────────────────────────────────────────────────────

@test "unknown option exits with error" {
  run "$WTKILL" --bogus
  [ "$status" -ne 0 ]
}

@test "unknown option prints message to stderr" {
  run "$WTKILL" --bogus
  [[ "$output" == *"Unknown option"* ]]
}

# ── Not in a git repo ─────────────────────────────────────────────────────────

@test "fails gracefully outside a git repo" {
  run bash -c "cd /tmp && '$WTKILL'"
  [ "$status" -ne 0 ]
}
