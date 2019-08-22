* cleanse.sh -- clean up a JSON object for create.sh to use
* create.sh JSONFileName -- create a SAML2 Local SP Entity  using a JSON file
* delete.sh LocalSPName -- delete a SAML2 Local SP Entity
* exist.sh LocalSPName -- check if the SAML2 Local SP Entity exists
** using read.sh, emit same output, and exist 1 if responseType is error
* list.sh SPNameSpec -- list the existing SAML2 Local SP Entity in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingLocalSPName -- make a template script from an existing SAML2 Local SP Entity
** only name is parameterized
* read.sh LocalSPNameSpec  -- GET the SAML2 Local SP Entity
* update.sh LocalSPName JSONFileName -- update the agent using a JSON file
