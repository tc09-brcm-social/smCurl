* cleanse.sh - clean up a JSON object for create.sh to use
* create.sh DomainName JSONFileName -- create a domain variable using a JSON file
* delete.sh DomainName VarName -- delete a domain variable
* exist.sh DomainNameSpec PolicySpec -- check if the domain policy exists
** using read.sh, emit same output, and exist 1 if responseType is error
* listpath.sh Domain VarSpec: list variables of domain in array of path
* maketemp.sh DomaiName VarName -- make a template script from an existing domain variable
** only variable name is parameterized
* read.sh DomainSpec VarSpec -- GET the Variables
