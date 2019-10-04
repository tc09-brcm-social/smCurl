* cleanse.sh -- clean up a JSON object for create.sh to use
* create.sh JSONFileName -- create an OIDC AP  using a JSON file
* delete.sh OIDCAPName -- delete a disabled OIDC AP
* disable.sh OIDCAPName -- disable an OIDC AP
* enable.sh OIDCAPName -- enable an OIDC AP
* exist.sh OIDCAPSpec -- check if the OIDC AP exists
** using read.sh, emit same output, and exist 1 if responseType is error
* list.sh OIDCAPNameSpec -- list the existing OIDC APs in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingOIDCAPName -- make a template script from an existing OIDC AP
** only OIDC AP name is parameterized
* read.sh OIDCAPSpec  -- GET the OIDC AP
* update.sh OIDCAPName JSONFileName -- update the OIDC AP using a JSON file
