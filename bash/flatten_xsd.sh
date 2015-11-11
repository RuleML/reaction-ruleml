#!/bin/bash
# dc:rights [ 'Copyright 2015 RuleML Inc. -- Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ]
# flatten
# Instructions:
# apply the XSLT transformation in xslt/rnc2xsd after flattening
#
BASH_HOME=$( cd "$(dirname "$0")" ; pwd -P )/ ;. "${BASH_HOME}path_config.sh";

#   use oxygen to flatten the XSD driver in the $TMP directory and output to the $XSD_HOME directory
if [[ "${OXY_VERSION}" == "17" ]]; then 
  sh "$FLATTEN_SCRIPT" "-in:$1" "-outDir:$2"  "-flattenImports:false"
fi

if [[ "${OXY_VERSION}" == "14" ]]; then 
  sh "$FLATTEN_SCRIPT" "$1" "$2/"$(basename "$1")
fi

