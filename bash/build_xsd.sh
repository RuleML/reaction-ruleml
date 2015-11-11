#!/bin/bash
# dc:rights [ 'Copyright 2015 RuleML Inc. -- Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ]
# Fully local test script for XSD
shopt -s nullglob
BASH_HOME=$( cd "$(dirname "$0")" ; pwd -P )/ ;. "${BASH_HOME}path_config.sh";

# Generate XSD, and validate
#"${BASH_HOME}batch_rnc2xsd.sh"   >> /dev/null 2>&1
#if [[ "$?" -ne "0" ]]; then
#     echo "Generation of XSD Failed"
#     exit 1
#fi
   
# Validate Examples in Test Suites
"${BASH_HOME}batch_xsd-test-suite.sh"  >> /dev/null 2>&1
if [[ "$?" -ne "0" ]]; then
     echo "Local Testing of XSD Schema Failed"
     exit 1
fi

# Normalize and Validate Examples Test Suites
"${BASH_HOME}batch_xsd-normal-suite.sh" >> /dev/null 2>&1
if [[ "$?" -ne "0" ]]; then
     echo "Local Testing of XSD Normal Schema Failed"
     exit 1
fi

# Compactify and Validate Examples Test Suites
"${BASH_HOME}batch_xsd-compact-suite.sh"  >> /dev/null 2>&1
if [[ "$?" -ne "0" ]]; then
     echo "Local Testing of RNC Compact Schema Failed"
     exit 1
fi
# Generate xml instances of consumer-reaction and validate against dr.xsd
"${BASH_HOME}generate_xml.sh"  >> /dev/null 2>&1
if [[ "$?" -ne "0" ]]; then
     echo "Testing of Consumer-Reaction Sublanguages Failed"
     exit 1
fi
