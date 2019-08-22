* cleanse.sh -- clean up a JSON object for create.sh to use
* create.sh JSONFileName -- create a SAML2 Local IdP Entity  using a JSON file
* delete.sh LocalIdPName -- delete a SAML2 Local IdP Entity
* exist.sh LocalIdPName -- check if the SAML2 Local IdP Entity exists
** using read.sh, emit same output, and exist 1 if responseType is error
* list.sh IdPNameSpec -- list the existing SAML2 Local IdP Entity in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingLocalIdPName -- make a template script from an existing SAML2 Local IdP Entity
** only name is parameterized
* read.sh LocalIdPNameSpec  -- GET the SAML2 Local IdP Entity
* update.sh LocalIdPName JSONFileName -- update the agent using a JSON file
