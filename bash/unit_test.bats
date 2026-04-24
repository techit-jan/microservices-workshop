#!/usr/bin/env bats

load ./test_function.sh

@test "add success" {
  result="$(add 1 2)"
  [ "$result" -eq 3 ]
}

@test "add with negative number" {
  result="$(add -1 1)"
  [ "$result" -eq 0 ]
}

@test "add should not equal -1" {
  result="$(add 1 2)"
  [ "$result" -ne -1 ]
}

@test "bad_add should fail" {
  result="$(bad_add 1 2)"
  [ "$result" -eq 3 ]
}