#!/bin/bash
# dc:rights [ 'Copyright 2015 RuleML Inc. -- Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ]
# Master build script
shopt -s nullglob
BASH_HOME=$( cd "$(dirname "$0")" ; pwd -P )/ ;. "${BASH_HOME}path_config.sh";

# Test RNC locally
"${BASH_HOME}build_rnc.sh"  >> /dev/null 2>&1
if [[ "$?" -ne "0" ]]; then
     echo "Local Testing of RNC Schemas Failed"
     exit 1
fi
# Convert RNC to to XSD and test locally
"${BASH_HOME}build_xsd.sh"  >> /dev/null 2>&1
if [[ "$?" -ne "0" ]]; then
     echo "Local Testing of XSD Schemas Failed"
     exit 1
fi
# Build zip packaage
"${BASH_HOME}build_zip.sh"  >> /dev/null 2>&1
if [[ "$?" -ne "0" ]]; then
     echo "Zip Build Failed"
     exit 1
fi
# Build docs
"${BASH_HOME}build_xsd2doc.sh"  >> /dev/null 2>&1
if [[ "$?" -ne "0" ]]; then
     echo "Doc Build Failed"
     exit 1
fi
