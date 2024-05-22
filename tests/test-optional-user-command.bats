#!/usr/bin/env bats

@test "Test without OPTIONAL_USER_COMMAND" {
    run bash 99_run-optional-user-command.sh
    [ "$status" -eq 0 ]
    echo "Output: $output"
    [[ "$output" == *"No optional user command was passed."* ]]
}


@test "Test with OPTIONAL_USER_COMMAND" {
  OPTIONAL_USER_COMMAND='echo "Hello, World!"' run bash 99_run-optional-user-command.sh
  [ "$status" -eq 0 ]
  echo "Output: $output"
  [[ "$output" == *"Hello, World!"* ]]
}