* cleanse.sh -- clean up a JSON object for create.sh to use
* copy.sh ToDomainName FromDomainName -- copy the definition from FromDomainName to ToDomainName
** User Directory associations are copied too
* create.sh JSONFileName -- create a User Directory  using a JSON file
* delete.sh DomainName -- delete a Domain
* exist.sh DomainName -- check if the Domain exists
** using read.sh, emit same output, and exist 1 if responseType is error
* junsetusers.sh -- unset user directory links from domain in the JSON data
* list.sh DomainNameSpec -- list the existing Domain in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingDomainName -- make a template script from an existing Domain
** only Domain name is parameterized
* read.sh DomainSpec  -- GET the Domain
* rename.sh DomainName NewDomainName -- change the Domain from DomainName to NewDomainName
** this retains all existing relatioships
* save.sh DomainName  -- clone existing Domain using name.time as the new name
** only cloning the domain level info including user directory association
* update.sh DomainName JSONFileName -- update the Domain using a JSON file
** this retains all existing relatioships
