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
* flist.sh filterExpr -- filtered list
* fexist.sh filterExpr -- for flist.sh similar how exist.sh supports list.sh
* fread.sh filterExpr -- for fexist.sh similar how read.sh supports exist.sh
* tested flist.sh ... indicates the SiteMinder object name
	* bash .../flist.sh "SignAuthnRequests = false"
	* bash .../flist.sh "Name beginswith 'a'"
	* bash .../flist.sh "Name endswith 'te'"
	* bash .../flist.sh "Name contains 'Def'"
		* Name can also be BaseURL
