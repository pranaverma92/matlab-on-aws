#!/usr/bin/env bats

setup() {
  # Create a temporary directory to mock MATLAB_ROOT
  MATLAB_ROOT=$(mktemp -d)
  mkdir -p "${MATLAB_ROOT}/bin/glnxa64"

  # Mock MATLABStartupAccelerator script
  echo '#!/bin/bash' > "${MATLAB_ROOT}/bin/glnxa64/MATLABStartupAccelerator"
  echo 'echo "MATLABStartupAccelerator executed with args: $*"' >> "${MATLAB_ROOT}/bin/glnxa64/MATLABStartupAccelerator"
  chmod +x "${MATLAB_ROOT}/bin/glnxa64/MATLABStartupAccelerator"
}

teardown() {
  # Clean up the temporary MATLAB_ROOT directory
  rm -rf "$MATLAB_ROOT"
}

@test "MATLAB_ROOT is set and MATLABStartupAccelerator executes" {
  export MATLAB_ROOT
  run bash /mathworks/devel/sandbox/pverma/matlab-aws-linux-fork/matlab-on-aws/tests/80_warmup-matlab.sh
  echo "output:$output"

  # Check if MATLABStartupAccelerator was executed and "Warm up done." was echoed
  [[ $output == *"MATLABStartupAccelerator executed with args: 64 ${MATLAB_ROOT} /usr/local/etc/msa/msa.ini /var/log/msa.log"* ]]
  [[ $output == *"Warm up done."* ]]
}
