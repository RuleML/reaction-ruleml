The modules in the indep_valid_modules, sibling to the modules directory, are intend for use in batch validation, in oXygen XML, of the modules. This kind of validation checks that the one module of concern, together with the initialization module(s) forms a complete, valid RNC schema, without undefined patterns or other errors. This is the property that allows the MYNG approach to work, where any subset of the modules (that includes the initialization modules) can be included into a driver schema to create a RNC schema that will validate without errors from undefined patterns.

To configure the validation scenarios of the modules,
1. Open the context menu of the modules directory, and select Validate > Configure Validation Scenarios
2. Select New
3. In the dialog, enter
  some title ( I use indep) 
  Choose Global (so this scenario can be used for both Reaction and Deliberation RuleML projects)
  ${cfdu}/../indep_valid_modules/${cfn}.rnc in the URL field
  RNC schema in the type field
  Default engine
  Automatic validation
4. Click OK , and then make sure the new scenario is selected. 
5. Click Apply Associated. This will run the batch validation on the whole directory, plus this validation will be run whenever you make changes to any module.


The validation tests at the other extreme are the validity of the drivers dr-all-ordered.rnc and dr-all-unordered.rnc, in the relaxng directory.