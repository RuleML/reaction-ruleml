#!/bin/bash
# dc:rights [ 'Copyright 2015 RuleML Inc. -- Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ]
# Fully local build script for RNC
# Dependencies
# indep_valid_modules/*.rnc
# aux_valrnc.sh
# batch_rnc2rng.sh
# batch_config2rnc.sh
# batch_config2rnc4simp.sh
# batch_rnc_test_suite.sh
# batch_rnc2simp.sh
shopt -s nullglob
BASH_HOME=$( cd "$(dirname "$0")" ; pwd -P )/ ;. "${BASH_HOME}path_config.sh";
#
# Validate modules individually
for file in ${RNC_HOME}indep_valid_modules/*.rnc
do
  ${BASH_HOME}aux_valrnc.sh "${file}"
  if [ "$?" -ne "0" ]; then
     echo "Module Validation Failed"
     exit 1
  fi
done
# Validate drivers
for file in "${RNC_HOME}drivers/"*.rnc
do
  ${BASH_HOME}aux_valrnc.sh "${file}"
  if [ "$?" -ne "0" ]; then
     echo "Driver Validation Failed"
     exit 1
  fi
done
# Generate RNC and convert to RNG, and validate
${BASH_HOME}batch_rnc2rng.sh  >> /dev/null 2>&1
if [ "$?" -ne "0" ]; then
     echo "Validation Against Design Failed"
     exit 1
fi
# Simplify, and validate
${BASH_HOME}batch_rnc2simp.sh  >> /dev/null 2>&1
if [ "$?" -ne "0" ]; then
     echo "Simplification Failed"
     exit 1
fi
# Validate Examples in Relax NG Test Suites
${BASH_HOME}batch_rnc-test-suite.sh  >> /dev/null 2>&1
if [ "$?" -ne "0" ]; then
     echo "Local Testing of RNC Schemas Failed"
     exit 1
fi
