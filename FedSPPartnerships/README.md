* activate.sh IDPSPName -- activate the SAML2 IDP->SP Partnership
* cleanse.sh -- clean up a JSON object for create.sh to use
* create.sh JSONFileName -- create a SAML2 IDP->SP Partnership  using a JSON file
* deactivate.sh IDPSPName -- deactivate the SAML2 IDP->SP Partnership
* delete.sh IDPSPName -- delete a SAML2 IDP->SP Partnership
* exist.sh IDPSPName -- check if the SAML2 IDP->SP Partnership exists
** using read.sh, emit same output, and exist 1 if responseType is error
* list.sh IDPSPNameSpec -- list the existing SAML2 IDP->SP Partnership in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingIDPSPName -- make a template script from an existing SAML2 IDP->SP Partnership
** only name is parameterized
* read.sh IDPSPNameSpec  -- GET the SAML2 IDP->SP Partnership
* update.sh IDPSPName JSONFileName -- update the SAML2 IDP->SP Partnership using a JSON file
