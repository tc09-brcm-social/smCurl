* cleanse.sh -- clean up a JSON object for create.sh to use
* create.sh JSONFileName -- create a SAML2 Remote SP Entity  using a JSON file
* delete.sh RemoteSPName -- delete a SAML2 Remote SP Entity
* exist.sh RemoteSPName -- check if the SAML2 Remote SP Entity exists
** using read.sh, emit same output, and exist 1 if responseType is error
* list.sh SPNameSpec -- list the existing SAML2 Remote SP Entity in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingRemoteSPName -- make a template script from an existing SAML2 Remote SP Entity
** only name is parameterized
* read.sh RemoteSPNameSpec  -- GET the SAML2 Remote SP Entity
* update.sh RemoteSPName JSONFileName -- update the SAML2 Remote SP Entity using a JSON file
