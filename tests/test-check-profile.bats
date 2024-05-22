#!/usr/bin/env bats

setup() {
    # Create a temporary directory for mocks
     function curl() {
        echo "InstanceProfileArn: arn:aws:iam::123456789012:instance-profile/ExampleInstanceProfile"
    }
    export -f curl
}

teardown() {
    # Restore the original `curl` command if you have modified it or used `export -f` to override it.
    # This is important to prevent test side effects.
    unset -f curl  # Only necessary if you've overridden curl with a function.
}

@test "Test successful retrieval of Instance Profile ARN" {
    # Assuming 'your_script.sh' is the script you're testing
    run bash -c "source ./00_check-profile.sh"
    echo "output: $output"
    [ "$status" -eq 0 ]
    [[ "${lines[0]}" =~ "Found attached instance profile: InstanceProfileArn: arn:aws:iam::123456789012:instance-profile/ExampleInstanceProfile" ]]
}