# examples/ldapud
LDAP User Directory utilities
* env.shlib -- used to configure the LDAP User Directory name
	* and access information
	* depends on the OS, the installation of ldap utilities
	* would need to be set properly
* bash searchldap.sh LDAPFilter optionalSpaceSepeartedAttrs
	* ldapsearch to get all attributes use '*'
* bash modifyldap.sh FILE -- ldapmodify
* bash addldap.sh FILE -- ldapadd
* bash moduser.temp DN ATTR VALUE -- modify a single attr for a DN
* bash deleteldap.sh LDAPFilter -- ldapdelete
* add.ldif -- an example file for addldap
