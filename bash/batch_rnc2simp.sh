#!/bin/bash
# dc:rights [ 'Copyright 2015 RuleML Inc. -- Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ]
# Batch generate Simplified RNC from MYNG RNC
# This script will remove the contents of a sibling directory named /simplified.
#
# Notes
# due to problems in Jing with simplification of qualified names as content, the explicit datatyping feature is not included.
shopt -s nullglob
BASH_HOME=$( cd "$(dirname "$0")" ; pwd -P )/ ;. "${BASH_HOME}path_config.sh";

# 
# creates the simplifed directory if it doesn't exist, and clears it, in case it already has contents
mkdir -p "${SIMP_HOME}"
rm "${SIMP_HOME}"*.rnc  >> /dev/null 2>&1

for file in "${RNC4SIMP_HOME}"*.rnc
do
  filename=$(basename "$file")
  "${BASH_HOME}rnc2simp.sh" "$file" "${SIMP_HOME}${filename}"
  if [[ "$?" -ne "0" ]]; then
     echo "Simplification Failed for ${filename}"
     exit 1
   fi
done
# Validate simplified RNC
for file in "${SIMP_HOME}"*.rnc
do
  filename=$(basename "$file")
  "${BASH_HOME}aux_valrnc.sh" "${file}"
  if [[ "$?" -ne "0" ]]; then
     echo "Simplified RNC Validation Failed for ${filename}"
     exit 1
  fi
done
