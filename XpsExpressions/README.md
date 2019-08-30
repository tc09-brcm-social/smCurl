* cleanse.sh -- clean up a JSON object for create.sh to use
* create.sh JSONFileName -- create a Named Expression using a JSON file
* delete.sh NamedExprName -- delete the Named Expression
* exist.sh NamedExprName -- check if the Named Expression exists
** using read.sh, emit same output, and exist 1 if responseType is error
* list.sh NamedExprNameSpec -- list the existing Named Expressions in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingExprName -- make a template script from an existing Named Expression
** only Named Expression name is parameterized
* read.sh NamedExprSpec  -- GET the Named Expression
