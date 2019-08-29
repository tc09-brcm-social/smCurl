* allusers.temp EscapedUserDirectoryName -- produces a user directory to be added to a policy
* onepol.temp RulePath OptionResponsePath
** produces a policy link to be added to a policy
* policy.temp PolicyName DomainName RealmName RuleName EscapedUserDirectoryName --
** produces a JSON policy that can be used with SmPolicies/create.sh
* simmple.temp PolicyName -- produces a simply policy without any policy link
** use jaddpol.sh to add additional policy links
