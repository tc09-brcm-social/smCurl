* jsave.sh DomainName PolicyName -- produces JSON policy ready for create.sh to use
** use exist.sh to check if policy exists,
** print exist.sh output and return the exist code if not
** use jsetdisabled.sh to set policy disabled by default
* save.sh DomainName PolicyName -- use jsave.sh and then create.sh to create domain policy
