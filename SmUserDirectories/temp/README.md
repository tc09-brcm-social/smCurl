* addir.temp -- AD User Diretory example template
* dir.temp -- simple User Directory template well-known attributes
* simple.temp name ldapHostPort -- a simple user directory template
	* that does not contain the well-known user attribute mapping
* fromAH.temp LDAPconfigJSONFile -- a template that uses a VIP AuthHub LDAPconfig JSON file
	* to create a SmUserDirectory JSON payload.
	* Further processing is still needed to provide at least the Password value.
	* the bindDN has changed since Mar 21 build
