* cleanse.sh -- clean up a JSON object for create.sh to use
* create.sh DomainName RealmName JSONFileName -- create domain realm rule using
** a JSON file
* delete.sh DomainName RealmName RuleName -- delete a rule.
* exist.sh DomainName RealmName RuleName -- check if the rule exists
** using read.sh, emit same output, and exist 1 if responseType is error
* id2path.sh objectID -- return path through a rule ID
** does not check whether the ID is actually a rule
* jaddaction.sh Action -- add an action
** use jrmaction.sh to remove first to avoid duplication
* jrmaction.sh Action -- remove an action
* jsetdisabled.sh -- set JSON policy to be disabled
* jsetenabled.sh -- set JSON policy to be enabled
* list.sh DomainNameSpec RealmNameSpec RuleNameSpec -- list the existing rules
** in JSON array, prints out empty array if exist.sh fails
* maketemp.sh DomainName RealmName RuleName -- make a template from an existing rule
* read.sh DomainName RealName RuleName -- GET the rule
