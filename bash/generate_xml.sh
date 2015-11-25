#!/bin/bash
# dc:rights [ 'Copyright 2015 RuleML Inc. -- Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ]
# See ReadMe.text for instructions on running this script.
# 
#
shopt -s nullglob
BASH_HOME=$( cd "$(dirname "$0")" ; pwd -P )/ ;. "${BASH_HOME}path_config.sh";
echo "${INSTANCE_HOME}"
if [[ ${INSTANCE_HOME} ]]; then rm "${INSTANCE_HOME}"*.ruleml  >> /dev/null 2>&1; fi

#   use oxygen to generate XML instances according to the configuration file for the generated xsd schema
"$GENERATE_SCRIPT" "$REACTION_CONFIG"

# Apply XSLT transforamtions
# transform in place for files in INSTANCE_HOME
for f in "${INSTANCE_HOME}"*.ruleml
do
  filename=$(basename "${f}")
  fnew="${INSTANCE_HOME}proc-${filename}"
  echo "Transforming ${filename}"
  "${BASH_HOME}aux_xslt.sh" "${f}" "${XSLT_HOME}instance-postprocessor/1.02_instance-postprocessor.xslt" "${fnew}"
  if [[ "$?" -ne "0" ]]; then
     echo "XSLT Transformation Failed for " "${filename}"
     exit 1
   fi
done

schemaname="kr-cep"
sxfile="${XSD_HOME}${schemaname}.xsd" 
srfile="${RNC_HOME}${schemaname}.rnc" 

#
# Check number of files to start with
files=( "${INSTANCE_HOME}"*.ruleml )
numfilesstart=${#files[@]}
echo "Number of Files to Start: ${numfilesstart}"

for file in "${INSTANCE_HOME}"proc-*.ruleml 
do
  filename=$(basename "${file}")
  echo "Validating  ${filename}"
  "${BASH_HOME}aux_valxsd.sh" "${sxfile}" "${file}"
  if [[ "$?" -ne "0" ]]; then
          echo "XSD Validation Failed for ${file}"
     rm "${file}"
  fi       
done

# Check if too many files were removed
files=( "${INSTANCE_HOME}"*.ruleml )
numfilesend=${#files[@]}
numfilesenddouble=2*$numfilesend
echo "Number of Files to End: ${numfilesend}"
  if [[ $numfilesenddouble -le $numfilesstart ]]; then
     echo "Completion Failed - Too Many Invalid Results"
     exit 1
   fi

for file in "${INSTANCE_HOME}"proc-*.ruleml 
do
  filename=$(basename "${file}")
  echo "RNC Validating  ${filename}"
  "${BASH_HOME}aux_valrnc.sh" "${srfile}" "${file}"
  if [[ "$?" -ne "0" ]]; then
          echo "RNC Validation Failed for ${file}"
          exit 1
  fi       
done
