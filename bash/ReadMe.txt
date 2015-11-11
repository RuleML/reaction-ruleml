To locally verify the Consumer RuleML 1.02 schemas:
1. Clone the Github repository https://github.com/RuleML/consumer-ruleml.git
2. Clone the Github repository https://github.com/RuleML/reaction-ruleml.git
3. Copy the <path to your consumer-ruleml repo>/bash/path_config_template.sh file to <path to your consumer-ruleml repo>/bash/path_config.sh
4. In path_config.sh, modify the assignment of OXY_HOME according to the path to your Oxygen XML 17 installation.
5. Copy the <path to your consumer-ruleml repo>/bash/settings/reaction-config_template.xml file to <path to your consumer-ruleml repo>/bash/settings/reaction-config.xml
6. In reaction-config.xml, modify the content of schemaSystemId and outputFolder according to your local configuration.
7. For the complete build, run build.sh
8. Partial builds may be run for verification purposes:
  - build_rnc.sh verifies the Relax NG schames, as well as regenerates the simplified RNC (the content model)
  - build.xsd.sh regenerates and verifies the XSD schemas
  - build_xsd2doc.sh regenerates the schemadocs
  - build_zip.sh regenerates the zip corresponding to the Contribution to OASIS
 9. An additional verification: 
  -generate_xml.sh randomly generates instances of the consumer-reaction.xsd schema and 
     validates them against the Reaction RuleML 1.02 dr.xsd XSD schema.
   