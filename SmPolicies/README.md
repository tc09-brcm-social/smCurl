* cleanse.sh - clean up a JSON object for create.sh to use
** handle USER and RULES too
* create.sh DomainName JSONFileName -- create a domain policy using a JSON file
* delete.sh DomainName PolicyName -- delete a domain policy
* exist.sh DomainNameSpec PolicySpec -- check if the domain policy exists
** using read.sh, emit same output, and exist 1 if responseType is error
* jaddpol.sh JSONDATA -- adding the Policy Link in JSONDATA to the JSON policy
* jadduser.sh JSONDATA -- adding the user directory in JSONDATA to the JSON policy
* jaddvar.sh DomainName VariableSpec -- adding the variable link to the JSON policy
** using SmVariables/listpath.sh to retrieve the variable link
** return SmVariables/listpath.sh status if failed
** prints out JSON policy, modified or not
* jrmuser.sh EscapedUserDiretoryName -- remove the user diretory from the JSON policy
* jsetdisabled.sh -- set JSON policy to be disabled
* jsetenabled.sh -- set JSON policy to be enabled
* jsetexp.sh Expression -- set the expression to the JSON policy
* junsetexp.sh -- remove expression from the JSON policy
* junsetrules.sh -- remove rules from the JSON policy
* junsetvars.sh -- remove variables from the JSON policy
* list.sh DomainNameSpec PolicyNameSpec -- list the existing policies in JSON array
** prints out empty array if exist.sh fails
* maketemp1.sh -- a historical attempt, to be removed
** does not do complete job, however, the output could does capture
** the basic framework of a template.
* maketemp.sh DomaiName PolicyName -- make a template script from an existing domain policy
** only policy name is parameterized
* read.sh DomainSpec PolicySpec -- GET the domain policy
* setexp.sh DomainName PolicyName Expression -- set the domain policy the expression
** exist.sh, jsetexp.sh, and update.sh used
* update.sh DomainName PolicyName JSONFileName -- update the domain policy using a JSON file
