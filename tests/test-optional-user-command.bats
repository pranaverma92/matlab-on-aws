#!/usr/bin/env bats

@test "Test without OPTIONAL_USER_COMMAND" {
    run bash optional_user_command.sh
    [ "$status" -eq 0 ]
    echo "Output: $output"
    [[ "$output" == *"No optional user command was passed."* ]]
}


@test "Test with OPTIONAL_USER_COMMAND" {
  OPTIONAL_USER_COMMAND='echo "Hello, World!"' run bash optional_user_command.sh
  [ "$status" -eq 0 ]
  echo "Output: $output"
  [[ "$output" == *"Hello, World!"* ]]
}