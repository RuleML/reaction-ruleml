#!/bin/bash
# dc:rights [ 'Copyright 2015 RuleML Inc. -- Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ]
# Configure path variables
# Dependencies:
# From oXygen XML
#   - Jing
#   - Trang
#   - Sax
#   - XSD flattening script
#   - schema docs generation script
# External libraries
#   - JAXB
# Installed packages
#  - java (1.6+)
#  - php5
#  - curl
#  - libxml2-utils (for xmllint)
#  - zip  
# Note: change the OXY_HOME and APP_HOME path according to your path to the
# Oxygen 17 installation and JAXB jar.
OXY_HOME="/home/tara/Oxygen XML Editor 17/"
FLATTEN_SCRIPT="${OXY_HOME}/flattenSchema.sh"
GENERATE_SCRIPT="${OXY_HOME}/xmlGenerator.sh"
DOC_SCRIPT="${OXY_HOME}/schemaDocumentation.sh"
OXY_LIB="${OXY_HOME}lib/"
SAX_HOME="${OXY_LIB}"
JING="${OXY_LIB}jing.jar"
TRANG="${OXY_LIB}trang.jar"
JAXB_HOME="${OXY_LIB}"jaxb-ri/
BASH_HOME=$( cd "$(dirname "$0")" ; pwd -P )/
REPO_HOME="${BASH_HOME}../"
RNC_HOME=${REPO_HOME}relaxng/
DRIVER_HOME=${RNC_HOME}drivers/
TMP=${RNC_HOME}tmp-std2xsd.rng
MYNG_BACK_END=${RNC_HOME}schema_rnc.php
PHP_CLI_INI=${RNC_HOME}php-cli.ini
DESIGN_HOME=${REPO_HOME}designPattern/
TEST_HOME=${REPO_HOME}relaxng/test/
RNC4SIMP_HOME=${REPO_HOME}relaxng/drivers4simp/
RNC4XSD_HOME=${REPO_HOME}relaxng/drivers4xsd/ 
RNC_TEST_SUITE_HOME=${REPO_HOME}test/rnc-test-suites/
TMP_MODULES=${RNC_HOME}tmp/modules/
SIMP_HOME=${REPO_HOME}simplified/
XSD_HOME="${REPO_HOME}xsd/"
XSLT2_HOME=${REPO_HOME}xslt/rnc2xsd/
XSD_HOME=${REPO_HOME}xsd/
XSD_TEST_SUITE_HOME=${REPO_HOME}test/rnc-test-suites/
COMPACT_SUITE_HOME=${REPO_HOME}test/compactifier-test-suites/
XSLT_HOME=${REPO_HOME}xslt/
COMPACT_XSLT_HOME="${XSLT_HOME}compactifier/"
NORMAL_SUITE_HOME="${REPO_HOME}test/normalizer-test-suites/"
NORMAL_XSLT_HOME="${XSLT_HOME}normalizer/"
TMP_HOME="${RNC_HOME}tmp/"
TMP_RNG="${TMP_HOME}tmp-std2xsd.rng"
MODULE_HOME="${REPO_HOME}relaxng/modules/"
TMPDIR="${XSD_HOME}/tmp/"
GIT_HOME="${REPO_HOME}../"
REACTION_CONFIG="${BASH_HOME}/settings/reaction-config.xml"
INSTANCE_HOME="${REPO_HOME}test/reaction-test-suites/"
DR_TEST_SUITE_HOME="${REPO_HOME}test/schema-test-suites/dr-test-suite/"

