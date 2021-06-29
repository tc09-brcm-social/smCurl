# examples/ldapusermgmt
This uses the ldapud to implement the "Manage User Accounts"
functions on the Admin UI and others.
* Getting Started
	* Minimally modify UD and Password in the env.shlib
	* UD is an user directory object in the SiteMinder
	* BINDPWD is in the format of ldap password authentication
	* change only the password part.
	* When either the BINDDN or BASEDN is empty, they
	* are retrieved from SiteMinder.
* env.shlib
	* uses utils/setkeyvalue.sh and hence needs to be invoked at cassoCurl Home
	* if source when not at the current directory . "${DIR}/env.shlib" "${DIR}"
* Frictionless Password Reset
	* will need to modify the environment variables
	* used by selfpwdlink
	* see doc.txt for more details.
* env.shlib - take a look at the ldapud/env.shlib to
	* customize some of the values in the env.shlib
	* for your own customization
* bash userstatus.sh username -- return status value
* bash enable.sh username
* bash disable.sh username
* bash modifyuser.sh username attribute value
* bash newpwd.sh username newpassword
* bash forcepwd.sh username -- force password change
* bash clearpwd.sh username -- clear password change
* bash searchuser.sh username -- dump the ldif of the user
* bash adduser.sh username lastname firstname emailaddress
	* it create a user and show the self password service link.
	* adduser.temp is the template used to create the user
* ag.fcc -- a sample FCC that works with selfpwdlink.sh
	* needs to be deployed under the Web Agent forms 
* smpwservices.fcc --
	* the default password service fcc captured from
	* siteminder web agent installation
* bash selfpwdlink.sh id password
	* print out self password reset link
* doc.txt - a high-level document about self password reset
* ldif2json.awk - an open source ldif2json 
