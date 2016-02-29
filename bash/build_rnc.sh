#!/bin/bash
# dc:rights [ 'Copyright 2015 RuleML Inc. -- Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ]
# Fully local build script for RNC
shopt -s nullglob
BASH_HOME=$( cd "$(dirname "$0")" ; pwd -P )/ ;. "${BASH_HOME}path_config.sh";
#
# Validate drivers
for file in "${RNC_HOME}kr-cep.rnc" "${RNC_HOME}drivers4simp/kr-cep.rnc"
do
  "${BASH_HOME}aux_valrnc.sh" "${file}"
  if [[ "$?" -ne "0" ]]; then
     echo "Driver Validation Failed"
     exit 1
  fi
done
# Simplify, and validate
"${BASH_HOME}batch_rnc2simp.sh"  >> /dev/null 2>&1
if [[ "$?" -ne "0" ]]; then
     echo "Simplification Failed"
     exit 1
fi
# Validate Examples in Relax NG Test Suites
"${BASH_HOME}batch_rnc-test-suite.sh"  >> /dev/null 2>&1
if [[ "$?" -ne "0" ]]; then
     echo "Local Testing of RNC Schemas Failed"
     exit 1
fi

