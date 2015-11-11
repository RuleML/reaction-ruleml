#!/bin/bash
# dc:rights [ 'Copyright 2015 RuleML Inc. -- Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ]
#  Validate RuleML instances by XSD
# FIXME use configuration script to validate test files against multiple schemas, including fail tests
# This will remove the fragile schema detection method now implemented.
#
# globstar is only available in bash 4
#shopt -s globstar
shopt -s nullglob
BASH_HOME=$( cd "$(dirname "$0")" ; pwd -P )/ ;. "${BASH_HOME}path_config.sh";

schemaname="dr.xsd"
sxfile="${XSD_HOME}${schemaname}"       

for file in "${DR_TEST_SUITE_HOME}"*.rrml
do
  filename=$(basename "${file}")
  echo "File ${filename}"
  "${BASH_HOME}aux_valxsd.sh" "${sxfile}" "${file}"
  exitvalue=$?
  if [[ ! "${file}" =~ fail ]] && [[ "${exitvalue}" -ne "0" ]]; then
          echo "Validation Failed for ${file}"
          exit 1
   else
         if [[ "${file}" =~ fail ]] && [[ "${exitvalue}" == "0" ]]; then
           echo "Validation Succeeded for Failure Test ${file}"
           exit 1
         fi
  fi       
done

schemaname="kr-cep.xsd"
sxfile="${XSD_HOME}${schemaname}"       

for file in "${CEP_TEST_SUITE_HOME}"*.rrml
do
  filename=$(basename "${file}")
  echo "File ${filename}"
  "${BASH_HOME}aux_valxsd.sh" "${sxfile}" "${file}"
  exitvalue=$?
  if [[ ! "${file}" =~ fail ]] && [[ "${exitvalue}" -ne "0" ]]; then
          echo "Validation Failed for ${file}"
          exit 1
   else
         if [[ "${file}" =~ fail ]] && [[ "${exitvalue}" == "0" ]]; then
           echo "Validation Succeeded for Failure Test ${file}"
           exit 1
         fi
  fi       
done
