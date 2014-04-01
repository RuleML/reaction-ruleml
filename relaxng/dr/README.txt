Instance Generation Procedure for RNC

1. Use the script at https://github.com/RuleML/deliberation-ruleml/blob/1.01-dev/bash/rnc2xsd.sh to flatten and convert to XSD
2. Move the resulting XSD to the auto-gen/dr-rnc directory 
3. From the Tools menu, select Generate Sample XML Files
4. Load Settings from config.xml and run
5. Post-process using the oXygen Find/Replace dialog: <arg([^<>]*)/> becomes <arg$1><Ind/></arg>