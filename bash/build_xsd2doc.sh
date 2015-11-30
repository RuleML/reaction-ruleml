#!/bin/bash
# dc:rights [ 'Copyright 2015 RuleML Inc. -- Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ]
# Auto-generate Schema Docs from XSD

shopt -s nullglob
BASH_HOME=$( cd "$(dirname "$0")" ; pwd -P )/ ;. "${BASH_HOME}path_config.sh";

"${DOC_SCRIPT}"  "${XSD_HOME}dr-pr.xsd"  -cfg:"${BASH_HOME}settings/doc.xml"
"${DOC_SCRIPT}"  "${XSD_HOME}dr.xsd"  -cfg:"${BASH_HOME}settings/doc.xml"
"${DOC_SCRIPT}"  "${XSD_HOME}eca.xsd"  -cfg:"${BASH_HOME}settings/doc.xml"
"${DOC_SCRIPT}"  "${XSD_HOME}kr-cep.xsd"  -cfg:"${BASH_HOME}settings/doc.xml"
"${DOC_SCRIPT}"  "${XSD_HOME}kr-eca.xsd"  -cfg:"${BASH_HOME}settings/doc.xml"
"${DOC_SCRIPT}"  "${XSD_HOME}kr.xsd"  -cfg:"${BASH_HOME}settings/doc.xml"
"${DOC_SCRIPT}"  "${XSD_HOME}pr.xsd"  -cfg:"${BASH_HOME}settings/doc.xml"
 