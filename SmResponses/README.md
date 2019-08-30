* cleanse.sh - clean up a JSON object for create.sh to use
** handle SmResponseAttrs too
* create.sh DomainName JSONFileName -- create a domain response using a JSON file
* delete.sh DomainName ResponseName -- delete a domain response
* exist.sh DomainNameSpec ResponseSpec -- check if the domain response exists
** using read.sh, emit same output, and exist 1 if responseType is error
* id2path.sh --
* jaddattr.sh
* list.sh DomainNameSpec ResponseNameSpec -- list the existing responses in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh DomaiName ResponseName -- make a template script from an existing domain response
** only response name is parameterized
* read.sh DomainSpec ResponseSpec -- GET the domain response
* update.sh DomainName ResponseName JSONFileName -- update the domain response using a JSON file
