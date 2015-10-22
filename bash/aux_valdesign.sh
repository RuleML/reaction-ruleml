#!/bin/bash
# dc:rights [ 'Copyright 2015 RuleML Inc. -- Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ]
# Validate an RNG schema against the design pattern
BASH_HOME=$( cd "$(dirname "$0")" ; pwd -P )/ ;. "${BASH_HOME}path_config.sh";

# Finds the filename without extension
filename1=$(basename "$1")
extension1="${filename1##*.}"

# Verifies that input file name ends in ".rng"
if [ "${extension1}" != "rng" ];then
   echo "Extension is not .rng"
   exit 1
fi

#Validate
java -jar "${JING}"  "${DESIGN_HOME}include_expansion_schema.rng" "$1"
