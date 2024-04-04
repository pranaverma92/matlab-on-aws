#!/bin/bash

# Test when MATLAB_ROOT is set
testMATLAB_ROOTSet() {

    # Mock MATLAB_ROOT

    MATLAB_ROOT="/home/pverma/Desktop/testing"
    mkdir -p "${MATLAB_ROOT}/bin/glnxa64"

    echo '#!/bin/bash' > "${MATLAB_ROOT}/bin/glnxa64/MATLABStartupAccelerator"
    echo '"MATLABStartupAccelerator mocked."' >> "${MATLAB_ROOT}/bin/glnxa64/MATLABStartupAccelerator"
    chmod +x "${MATLAB_ROOT}/bin/glnxa64/MATLABStartupAccelerator"
    export MATLAB_ROOT

    # Capture the output of the script
    output=$(./startup_accelerator.sh)
    echo "output: $output"
    expectedOutput="Warm up done."

    # Assert the expected output
    assertEquals "Error" "$expectedOutput" "$output"
}

# Test when MATLAB_ROOT is unset
testMATLAB_ROOTUnset() {
  # Unset MATLAB_ROOT
  unset MATLAB_ROOT

  # Capture the output of the script
  output=$(./startup_accelerator.sh)

  # Assert that there is no output
  assertEquals "Expected no output when MATLAB_ROOT is unset" "" "$output"
}

. /home/pverma/Downloads/shunit2-2.1.8/shunit2