#!/bin/bash
# dc:rights [ 'Copyright 2015 RuleML Inc. -- Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ]
shopt -s nullglob
BASH_HOME=$( cd "$(dirname "$0")" ; pwd -P )/ ;. "${BASH_HOME}path_config.sh";

schemaname="kr-cep.rnc"
sfile="${RNC_HOME}${schemaname}"      
simpfile="${SIMP_HOME}${schemaname}"      
for file in "${RNC_TEST_SUITE_HOME}"*/*.ruleml "${RNC_TEST_SUITE_HOME}"*/*/*.ruleml
do
  filename=$(basename "${file}")
  echo "File "${filename}
  "${BASH_HOME}aux_valrnc.sh" "${sfile}" "${file}"
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
  "${BASH_HOME}aux_valrnc.sh" "${simpfile}" "${file}"
  exitvalue=$?
       if [[ ! "${file}" =~ fail ]] && [[ "${exitvalue}" -ne "0" ]]; then
          echo "Simplified Validation Failed for ${file}"
          exit 1
       else
         if [[ "${file}" =~ fail ]] && [[ "${exitvalue}" == "0" ]]; then
           echo "Simplified Validation Succeeded for Failure Test ${file}"
           exit 1
         fi
       fi
done