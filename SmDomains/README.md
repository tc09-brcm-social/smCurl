* cleanse.sh -- clean up a JSON object for create.sh to use
* create.sh JSONFileName -- create a Domain  using a JSON file
* delete.sh DomainName -- delete a Domain
* exist.sh DomainName -- check if the Domain exists
** using read.sh, emit same output, and exist 1 if responseType is error
* junsetusers.sh -- unset user directory links from domain in the JSON data
* list.sh DomainNameSpec -- list the existing Domain in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingDomainName -- make a template script from an existing Domain
** only Domain name is parameterized
* read.sh DomainSpec  -- GET the Domain
* update.sh DomainName JSONFileName -- update the Domain using a JSON file
** this retains all existing relatioships
* rmuser.sh DomainName UDName -- remove user directory from domain
