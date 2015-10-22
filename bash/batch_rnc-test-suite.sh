#!/bin/bash
# dc:rights [ 'Copyright 2015 RuleML Inc. -- Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ]
# Instructions:
# run this script from the command line or another script after batch_config2rnc.sh
# FIXME use configuration script to validate test files against multiple schemas, including fail tests
# This will remove the fragile schema detection method now implemented.
shopt -s nullglob
BASH_HOME=$( cd "$(dirname "$0")" ; pwd -P )/ ;. "${BASH_HOME}path_config.sh";

for file in "${RNC_TEST_SUITE_HOME}"*/*.ruleml "${RNC_TEST_SUITE_HOME}"*/*/*.ruleml
do
  filename=$(basename "${file}")
  echo "File "${filename}
  while read -r; do
     #echo "Line ${REPLY}"
     if [[ "${REPLY}" =~ "^..xml-model" ]]
     then     
       tail="${REPLY#*\"}"
       #echo "Tail ${tail}"
       url="${tail%%\"*}"
       #echo "URL ${url}"
       schemaname="${url##*/}"
       #echo "Schema ${schemaname}"       
       sfile="${DRIVER_HOME}${schemaname}"       
       "${BASH_HOME}aux_valrnc.sh" "${sfile}"
       exitvalue=$?
       if [[ "${exitvalue}" -ne "0" ]]; then
          echo "Schema Validation Failed for ${schemaname} called in ${file}"
          exit 1
       fi   
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
       break
     fi
  done < "${file}"
done
