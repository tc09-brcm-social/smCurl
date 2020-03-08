* cleanse.sh -- clean up a JSON object for create.sh to use
* create.sh JSONFileName -- create an ACO using a JSON file
* delete.sh ACOName -- delete an ACO
* exist.sh ACO -- check if the ACO exists
** using read.sh, emit same output, and exist 1 if responseType is error
* jaddattr.sh ATTRName ATTRValue - add a value to a multi-value attribute of a JSON file
* jsetattr.sh ATTRName ATTRValue - set a value to a single-value attribute of a JSON file
* junsetattr.sh ATTRName -- unset an attribute of a JSON input
* list.sh ACONameSpec -- list the existing ACOs in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingACOName -- make a template script from an existing ACO
** only agent ACO is parameterized
* maketemp2.sh name, make a bash shell template from existing object
* normal.sh ExistingACOName -- normalize the JSON output of the read.sh output
** can be used with diff to compare the differences between two ACOs
* read.sh ACOSpec  -- GET the ACO
* update.sh ACOName JSONFileName -- update the ACO using a JSON file

