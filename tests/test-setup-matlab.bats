#!/usr/bin/env bats

setup() {
  # Mock environment and files for testing
  BATS_TMPDIR=$(mktemp -d)
  export MLM_DEF_FILE="$BATS_TMPDIR/mlm_def.sh"
  touch "$MLM_DEF_FILE"
  echo "#export MLM_LICENSE_FILE='/test/license/file.lic'" > "$MLM_DEF_FILE"
  echo "output of mlm def file"
  cat $MLM_DEF_FILE
  export USERNAME="testuser"
  export HOME_DIR="$BATS_TMPDIR/home/$USERNAME"
  mkdir -p "$HOME_DIR"
  export HOME="$HOME_DIR"
}

teardown() {
  # Cleanup test environment
  unset MLM_LICENSE_FILE
  unset USERNAME
  rm -rf "$BATS_TMPDIR"
}

@test "License MATLAB using Network License Manager" {
  export MLM_LICENSE_FILE="/test/license/file.lic"
  run bash 70_setup-matlab.sh
  echo "output_from_script: $output"

  result=$(grep "export MLM_LICENSE_FILE='/test/license/file.lic'" "$MLM_DEF_FILE")
  echo "output_of_grep: $result"
  # [ "$status" -eq 0 ]
  # [ "${result}" != "" ]
  # [ "$output" = "License MATLAB using Network License Manager" ]
}

# @test "License MATLAB using Online Licensing" {
#   run bash path/to/your/script.sh

#   [ "$status" -eq 0 ]
#   [ "$output" = "License MATLAB using Online Licensing" ]
# }

# @test "Setup MATLAB licensing in non-login shells" {
#   run bash path/to/your/script.sh

#   result=$(tail -n 2 "$HOME_DIR/.bashrc")
#   expected_output="# Setup MATLAB Licensing"$'\n'"$MLM_DEF_FILE"

#   [ "$status" -eq 0 ]
#   [ "$result" = "$expected_output" ]
# }