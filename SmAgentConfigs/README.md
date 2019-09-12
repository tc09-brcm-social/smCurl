* cleanse.sh -- clean up a JSON object for create.sh to use
* copy.sh ToACOName FromACOName -- copy the definition from FromACOName to ToACOName
** this retains all existing relatioships
* create.sh JSONFileName -- create an ACO using a JSON file
* delete.sh ACOName -- delete an ACO
* exist.sh ACO -- check if the ACO exists
** using read.sh, emit same output, and exist 1 if responseType is error
* list.sh ACONameSpec -- list the existing ACOs in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingACOName -- make a template script from an existing ACO
** only agent ACO is parameterized
* maketemp2.sh name, make a bash shell template from existing object
* normal.sh ExistingACOName -- normalize the JSON output of the read.sh output
** can be used with diff to compare the differences between two ACOs
* read.sh ACOSpec  -- GET the ACO
* rename.sh ACOName NewACOName -- change the ACO from ACOName to NewACOName
** this retains all existing relatioships
* save.sh ACOName -- clone existing agent using name.time as the new name
* update.sh ACOName JSONFileName -- update the ACO using a JSON file

