#!/bin/bash

# Setup temporary environment for testing
setUp() {
    # Create a temporary directory for testing
    TEMP_DIR=$(mktemp -d)
    MLM_DEF_FILE="${TEMP_DIR}/mlm_def.sh"
    touch "${MLM_DEF_FILE}"

    export ${MLM_DEF_FILE}

    # Create a mock .bashrc file
    export HOME="${TEMP_DIR}"
    touch "${HOME}/.bashrc"

    # Back up the real USERNAME
    REAL_USERNAME=${USERNAME}
    USERNAME="testuser"

    # Create a home directory for the mock user
    mkdir -p "/home/${USERNAME}/testing_matlab"

    echo "# This is a mock MLM definition file" > "${MLM_DEF_FILE}"
    echo "#export MLM_LICENSE_FILE=''" >> "${MLM_DEF_FILE}"
}

# Tear down the temporary environment
tearDown() {
  # Clean up the temporary directory
  rm -rf "${TEMP_DIR}"

  # Restore the real USERNAME
  USERNAME=${REAL_USERNAME}
}

testWithMLMLicenseFileSet() {
  # Set MLM_LICENSE_FILE
  export MLM_LICENSE_FILE="path/to/license.lic"

  # Run the script
  output=$(./setup_matlab_licensing.sh 2>&1)

  # Check if the correct message is echoed
  assertTrue "License MATLAB using Network License Manager" grep -q "License MATLAB using Network License Manager" <<< "$output"

  # Check if MLM_DEF_FILE is modified correctly
  assertTrue "MLM_DEF_FILE should contain the license file path" grep -q "export MLM_LICENSE_FILE='${MLM_LICENSE_FILE}'" "${MLM_DEF_FILE}"
}

# testWithMLMLicenseFileUnset() {
#   # Unset MLM_LICENSE_FILE
#   unset MLM_LICENSE_FILE

#   # Run the script
#   output=$(./setup_matlab_licensing.sh 2>&1)

#   # Check if the correct message is echoed
#   assertTrue "License MATLAB using Online Licensing" grep -q "License MATLAB using Online Licensing" <<< "$output"
# }

# testBashrcUpdated() {
#   # Ensure USERNAME is set for this test
#   export USERNAME="testuser"

#   # Run the script
#   ./setup_matlab_licensing.sh

#   # Check if .bashrc is updated correctly
#   assertTrue ".bashrc should contain MLM_DEF_FILE sourcing" grep -q ". ${MLM_DEF_FILE}" "/home/${USERNAME}/.bashrc"
# }

. "${SHUNIT2_PATH}"