* cleanse.sh - clean up a JSON object for create.sh to use
* create.sh DomainName JSONFileName -- create a domain realm using a JSON file
* delete.sh DomainName RealmName -- delete a domain realm
* exist.sh DomainNameSpec RealmSpec -- check if the domain realm exists
** using read.sh, emit same output, and exist 1 if responseType is error
* list.sh Domain RealmSpec: list realms of domain in array of path
* listpath.sh Domain RealmSpec: list realms of domain in array of path
* maketemp.sh DomaiName RealmName -- make a template script from an existing domain realm
** only variable name is parameterized
* read.sh DomainSpec RealmSpec -- GET the domain realm
