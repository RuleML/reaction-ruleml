#!/bin/bash
# dc:rights [ 'Copyright 2015 RuleML Inc. -- Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ]
# flatten
# Instructions:
# apply the XSLT transformation in xslt/rnc2xsd after flattening
#
BASH_HOME=$( cd "$(dirname "$0")" ; pwd -P )/ ;. "${BASH_HOME}path_config.sh";
rm ${INSTANCE_HOME}*.ruleml  >> /dev/null 2>&1

#   use oxygen to generate XML instances according to the configuration file for the consumer-reaction driver
sh "$GENERATE_SCRIPT" "$REACTION_CONFIG"

# Apply XSLT transforamtions
# transform in place for files in INSTANCE_HOME
# FIXME write an aux script for the xslt call
for f in ${INSTANCE_HOME}*.ruleml
do
  filename=$(basename "$f")
  echo "Transforming " "${filename}"
  java -jar "${SAX_HOME}saxon9ee.jar" -s:"${f}" -xsl:"${XSLT_HOME}instance-postprocessor/1.02_instance-postprocessor.xslt"  -o:"${f}"
  if [ "$?" -ne "0" ]; then
     echo "XSLT Transformation Failed for " "${filename}"
     exit 1
   fi
done

  schemaname=consumer-reaction-normal.xsd
  sfile=${XSD_HOME}${schemaname}       
  ${BASH_HOME}aux_valxsd.sh "${sfile}"
  exitvalue=$?
  echo ${exitvalue}
  if [ "${exitvalue}" -ne "0" ]; then
       echo "Schema Validation Failed for ${schemaname}"
       exit 1
   fi   

for file in ${INSTANCE_HOME}*.ruleml 
do
  filename=$(basename "${file}")
  echo "File ${filename}"
  ${BASH_HOME}aux_valxsd.sh "${sfile}" "${file}"
  exitvalue=$?
  if [[ ! ${file} =~ fail ]] && [ "${exitvalue}" -ne "0" ]; then
          echo "Validation Failed for ${file}"
          exit 1
   else
         if [[ ${file} =~ fail ]] && [ "${exitvalue}" == "0" ]; then
           echo "Validation Succeeded for Failure Test ${file}"
           exit 1
         fi
  fi       
done

  schemaname2=dr.xsd
  sfile2=${REACTION_XSD_HOME}${schemaname2}       
  ${BASH_HOME}aux_valxsd.sh "${sfile}"
  exitvalue=$?
  echo ${exitvalue}
  if [ "${exitvalue}" -ne "0" ]; then
       echo "Schema Validation Failed for ${schemaname}"
       exit 1
   fi   


for file in ${INSTANCE_HOME}*.ruleml 
do
  filename=$(basename "${file}")
  echo "File ${filename}"
  ${BASH_HOME}aux_valxsd.sh "${sfile2}" "${file}"
  exitvalue=$?
  if [[ ! ${file} =~ fail ]] && [ "${exitvalue}" -ne "0" ]; then
          echo "Validation Failed for ${file}"
          exit 1
   else
         if [[ ${file} =~ fail ]] && [ "${exitvalue}" == "0" ]; then
           echo "Validation Succeeded for Failure Test ${file}"
           exit 1
         fi
  fi       
done
