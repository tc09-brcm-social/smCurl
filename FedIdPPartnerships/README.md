* This is for SP->IDP Partnership, the name is somewhat reversed.
* activate.sh SPIDPName -- activate the SAML2 SP->IDP Partnership
* cleanse.sh -- clean up a JSON object for create.sh to use
* create.sh JSONFileName -- create a SAML2 SP->IDP Partnership  using a JSON file
* deactivate.sh SPIDPName -- deactivate the SAML2 SP->IDP Partnership
* delete.sh SPIDPName -- delete a SAML2 SP->IDP Partnership
** a partnership needs to be deactivated before it can be removed
* exist.sh SPIDPName -- check if the SAML2 SP->IDP Partnership exists
** using read.sh, emit same output, and exist 1 if responseType is error
* list.sh SPIDPNameSpec -- list the existing SAML2 SP->IDP Partnership in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingSPIDPName -- make a template script from an existing SAML2 SP->IDP Partnership
** only name is parameterized
* read.sh SPIDPNameSpec  -- GET the SAML2 SP->IDP Partnership
* update.sh SPIDPName JSONFileName -- update the SAML2 SP->IDP Partnership using a JSON file
* flist.sh filterExpr -- filtered list
* fexist.sh filterExpr -- for flist.sh similar how exist.sh supports list.sh
* fread.sh filterExpr -- for fexist.sh similar how read.sh supports exist.sh
* tested flist.sh ... indicates the SiteMinder object name
        * bash .../flist.sh "Status = 'Inactive'"
		* Status is one of Active, Inactive, Defined

        * bash .../flist.sh "Name beginswith 'a'"
        * bash .../flist.sh "Name endswith 'te'"
        * bash .../flist.sh "Name contains 'Def'"
        * bash .../flist.sh "Level > 5"
