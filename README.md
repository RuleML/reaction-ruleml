reaction-ruleml
=============

Verification Procedures

When a change is made to the hand-written XSD (xsd/dr.xsd or the modules it imports), the following verification steps should be performed:

1. Validate the new XSD using the Saxon and JAXB validators
2. Use the new XSD to validate the instances in the test directory
3. Use the new XSD to validate the instances in the auto-gen/dr-rnc directory
4. Generate new instances using the config.xml settings in the xsd directory. The new instances will overwrite existing instances in the auto-gen/dr-xsd directory. Note: these new instances will usually need to be manually corrected due to truncation problems.
5. Once these generated instance have been manually corrected so that they  validate against the new XSD, validate against the RNC for the relaxed serialization. (Note: ignore or correct errors due to two occurrences of slotted rest variables "resl".)
6. After pushing to Github (which will be cloned to the RuleML server within 5 minutes), validate the instances in the exa directory to confirm web-based validation against the new XSD.

When a change is made to the Relax NG schemas, the following verification steps should be performed:

1. Validate the relaxng/indep_valid_modules directory to check that each module is individually valid.
2. Validate the relaxng/dr directory to check that all drivers are valid.
3. Use the new RNC drivers to validate the instances in the test directory
4. Use the new RNC driver for the relaxed serialization to validate the auto-generated instances in auto-gen/dr-xsd
5. Generate new instances following the procedure in auto-gen/dr-rnc
6. Validate the new instances against the hand-written XSD (xsd/dr.xsd)
7. After pushing to Github (which will be cloned to the RuleML server within 5 minutes), validate the instances in the exa directory to confirm web-based validation against the new RNC.
