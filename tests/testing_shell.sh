#!/bin/bash
SHUNIT2_PATH="${GITHUB_WORKSPACE}/shunit2/shunit2"

testOptionalUserCommandNotSet() {
    unset OPTIONAL_USER_COMMAND

    result=$(${GITHUB_WORKSPACE}/tests/optional_user_command.sh | tr '\n' ' ')
    expectedOutput="Optional user command - script started. No optional user command was passed. Optional user command - script completed. "

    echo "Expected: '$expectedOutput'"
    echo "Actual: '$result'"

    assertEquals "When OPTIONAL_USER_COMMAND is not set, the output should indicate no command was passed." "$expectedOutput" "$result"
}

testOptionalUserCommandIsSet() {
    # Set OPTIONAL_USER_COMMAND for this test
    OPTIONAL_USER_COMMAND='echo "Hello, World!"'

    # Execute the script in a subshell to keep the environment variable local
    result=$(OPTIONAL_USER_COMMAND="$OPTIONAL_USER_COMMAND" ${GITHUB_WORKSPACE}/tests/optional_user_command.sh | tr '\n' ' ')

    # Define expected output
    expectedOutput="Optional user command - script started. The passed string is an inline shell command. Hello, World! Optional user command - script completed. "

    echo "Expected: '$expectedOutput'"
    echo "Actual: '$result'"

    # Perform the test assertion
    assertEquals "When OPTIONAL_USER_COMMAND is set, it should execute and echo 'Hello, World!'." "$expectedOutput" "$result"
}

. "${SHUNIT2_PATH}"