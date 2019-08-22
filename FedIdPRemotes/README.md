* cleanse.sh -- clean up a JSON object for create.sh to use
* create.sh JSONFileName -- create a SAML2 Remote IdP Entity  using a JSON file
* delete.sh RemoteIdPName -- delete a SAML2 Remote IdP Entity
* exist.sh RemoteIdPName -- check if the SAML2 Remote IdP Entity exists
** using read.sh, emit same output, and exist 1 if responseType is error
* list.sh IdPNameSpec -- list the existing SAML2 Remote IdP Entity in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingRemoteIdPName -- make a template script from an existing SAML2 Remote IdP Entity
** only name is parameterized
* read.sh RemoteIdPNameSpec  -- GET the SAML2 Remote IdP Entity
* update.sh RemoteIdPName JSONFileName -- update the SAML2 Remote IdP Entity using a JSON file
