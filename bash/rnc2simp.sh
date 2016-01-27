#!/bin/bash
# dc:rights [ 'Copyright 2015 RuleML Inc. -- Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ]
# Auto-generate Simplified RNC from RNC
#   - makes modular RNC monolothic
#   - removes intermediate named patterns
#   - simplified definitions
# Prerequisites:
#   Installation of Java and Jing/Trang. See https://code.google.com/p/jing-trang/
# Dependencies:
# Jing
# Trang
# Note: change the APP_HOME path according to your path to the Jing/Trang library
# Caution: Jing simplification cannot handle specified qualified names in content
BASH_HOME=$( cd "$(dirname "$0")" ; pwd -P )/ ;. "${BASH_HOME}path_config.sh";

# Finds the filename without extension
filename1=$(basename "$1")
extension1="${filename1##*.}"

# Verifies that input schema name ends in ".rnc"
if [[ "${extension1}" != "rnc" ]];then
   echo "Input extension is not .rnc"
   exit 1
fi

# Finds the filename without extension
filename2=$(basename "$2")
extension2="${filename2##*.}"

# Verifies that output name ends in ".rnc"
if [[ "${extension2}" != "rnc" ]];then
   echo "Output extension is not .rnc"
   exit 1
fi

java -jar "${JING}" -cs "$1" > "${TMP}"
if [[ "$?" != "0" ]];then
   echo "Simplification Failed."
   exit 1
fi
java -jar "${TRANG}" "${TMP}" "$2"
if [[ "$?" != "0" ]];then
   echo "Conversion back to RNC Failed."
   exit 1
fi
function finish {
  rm "${TMP}"
}
trap finish EXIT
  