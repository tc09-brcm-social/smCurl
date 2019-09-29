* cleanse.sh -- clean up a JSON object for create.sh to use
* create.sh JSONFileName -- create an HCO  using a JSON file
* delete.sh HCOName -- delete an HCO
* exist.sh HCO -- check if the HCO exists
** using read.sh, emit same output, and exist 1 if responseType is error
* list.sh HCONameSpec -- list the existing HCOs in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingHCOName -- make a template script from an existing HCO
** only HCO name is parameterized
* read.sh HCOSpec  -- GET the HCO
* update.sh HCOName JSONFileName -- update the HCO using a JSON file
