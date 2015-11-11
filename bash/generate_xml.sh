#!/bin/bash
# dc:rights [ 'Copyright 2015 RuleML Inc. -- Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ]
# See ReadMe.text for instructions on running this script.
# 
#
shopt -s nullglob
BASH_HOME=$( cd "$(dirname "$0")" ; pwd -P )/ ;. "${BASH_HOME}path_config.sh";
if [[ ${INSTANCE_HOME} ]]; then rm "{INSTANCE_HOME}"*.ruleml  >> /dev/null 2>&1; fi

#   use oxygen to generate XML instances according to the configuration file for the generated xsd schema
"$GENERATE_SCRIPT" "$REACTION_CONFIG"

# Apply XSLT transforamtions
# transform in place for files in INSTANCE_HOME
# FIXME write an aux script for the xslt call
for f in "${INSTANCE_HOME}"*.ruleml
do
  filename=$(basename "${f}")
  echo "Transforming ${filename}"
  "${BASH_HOME}aux_xslt.sh" "${f}" "${XSLT_HOME}instance-postprocessor/1.02_instance-postprocessor.xslt" "${f}"
  if [[ "$?" -ne "0" ]]; then
     echo "XSLT Transformation Failed for " "${filename}"
     exit 1
   fi
done

schemaname="kr-cep.xsd"
sxfile="${XSD_HOME}${schemaname}" 
for file in "${INSTANCE_HOME}"*.ruleml 
do
  filename=$(basename "${file}")
  echo "File ${filename}"
  "${BASH_HOME}aux_valxsd.sh" "${sxfile}" "${file}"
  if [[ "$?" -ne "0" ]]; then
          echo "Validation Failed for ${file}"
          exit 1
  fi       
done
