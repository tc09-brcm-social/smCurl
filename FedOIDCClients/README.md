* cleanse.sh -- clean up a JSON object for create.sh to use
* create.sh JSONFileName -- create an OIDC Client  using a JSON file
* delete.sh OIDCClientName -- delete a disabled OIDC Client
* disable.sh OIDCClientName -- disable an OIDC Client
* enable.sh OIDCClientName -- enable an OIDC Client
* exist.sh OIDCClientSpec -- check if the OIDC Client exists
** using read.sh, emit same output, and exist 1 if responseType is error
* list.sh OIDCClientNameSpec -- list the existing OIDC Clients in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingOIDCClientName -- make a template script from an existing OIDC Client
** only OIDC Client name is parameterized
* read.sh OIDCClientSpec  -- GET the OIDC Client
* update.sh OIDCClientName JSONFileName -- update the OIDC Client using a JSON file
