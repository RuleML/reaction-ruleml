#!/bin/bash
# dc:rights [ 'Copyright 2015 RuleML Inc. -- Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ]
# FIXME use named pipes with mkfifo to eliminate temporary files
shopt -s nullglob
BASH_HOME=$( cd "$(dirname "$0")" ; pwd -P )/ ;. "${BASH_HOME}path_config.sh";
# convert all RNC modules to RNG in preparation
# for validation against the schema for the design pattern
#
# creates the output directories if they don't exist, and clears them of RNC files, in case they already have contents
mkdir -p "${TMP_MODULES}"
rm "${TMP_MODULES}"*.rng >> /dev/null 2>&1

# applies the auxiliary script aux_rnc2rng.sh to all RNC expansion modules
for file in "${RNC_HOME}modules/"*.rnc 
do 
  filename=$(basename "$file")
  #extension="${filename##*.}"
  #filenameNE="${filename%.*}"
  "${BASH_HOME}aux_rnc2rng.sh" "${file}" "${TMP_MODULES}"
   if [[ "$?" -ne "0" ]]; then
     echo "Conversion Failed for " "${filename}"
     exit 1
   fi
done
rngfiles=("${TMP_MODULES}"*.rng) # array initialization
numrng=${#rngfiles[@]}
#echo ${numrng}
if [[ "${numrng}" == "0" ]]; then
  echo "No Conversion"
  exit 1
fi
# Validate against ../designPattern/include_expansion_schema.rng
for file in "${TMP_MODULES}"*.rng
do
  filename=$(basename "$file")
  "${BASH_HOME}aux_valdesign.sh" "${file}" >> /dev/null 2>&1
   if [[ "$?" -ne "0" ]]; then
     echo "Validation Failed for " "${filename}"
     exit 1
   fi
done

# remove the temporary files and directory
function finish {
  rm "${TMP_MODULES}"*
  rmdir "${TMP_MODULES}"
}
trap finish EXIT 
