#!/bin/bash
# dc:rights [ 'Copyright 2015 RuleML Inc. -- Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ]
# Apply an XSLT transformation to an XML file
# Instructions:
# run this script from the command line or another script with three arguments
# the input file, the xslt file, and the output file
#
BASH_HOME=$( cd "$(dirname "$0")" ; pwd -P )/ ;. "${BASH_HOME}path_config.sh";

# creates the output directory if it doesn't exist
mkdir -p $(dirname "${3}")

echo "Transforming  ${1}"
java -jar "${SAX_HOME}saxon9ee.jar" -s:"${1}" -xsl:"${2}"  -o:"${3}"

if [[ "$?" -ne "0" ]]; then
     echo "XSLT Transformation with ${2} Failed"
     exit 1
fi
