* addresponse.sh DomainName ResponseGroupName ResponseName -- add a response to a group
* cleanse.sh -- clean up a JSON object for create.sh to use
* create.sh DomainName JSONFileName -- create a domain response group using a JSON file
* delete.sh DomainName ResponseGroupName -- delete a domain response group
* exist.sh DomainNameSpec ResponseGroupSpec -- check if the domain response group exists
** using read.sh, emit same output, and exist 1 if responseType is error
* id2path.sh ID -- UUID to path
* list.sh DomainNameSpec ResponseGroupNameSpec -- list the existing response groups in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh DomaiName ResponseGroupName -- make a template script from an existing domain response group
** only response group name is parameterized
* read.sh DomainSpec ResponseGroupSpec -- GET the domain response group
* update.sh DomainName ResponseGroupName JSONFileName -- update the domain response group using a JSON file
