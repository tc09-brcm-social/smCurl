* cleanse.sh -- clean up a JSON object for create.sh to use
* create.sh JSONFileName -- create an Auth Scheme using a JSON file
* delete.sh AuthSchemeName  -- delete an Auth Scheme
* exist.sh AuthSchemeName  -- check if the Auth Scheme exists
* list.sh AuthSchemeNameSpec -- list the existing AuthScheme in JSON array
** prints out empty array if exist.sh fails
* flist.sh filterExpr -- filtered list
* fexist.sh filterExpr -- for flist.sh similar how exist.sh supports list.sh
* fread.sh filterExpr -- for fexist.sh similar how read.sh supports exist.sh
* tested flist.sh ... indicates the SiteMinder object name
	* bash .../flist.sh "AuthSchemeType=HTMLForm"
	* bash .../flist.sh "Name beginswith 'a'"
	* bash .../flist.sh "Name endswith 'te'"
	* bash .../flist.sh "Name contains 'Def'"
	* bash .../flist.sh "Level > 5"
