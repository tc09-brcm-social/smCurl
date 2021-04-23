# examples/ldapusermgmt
This uses the ldapud to implement the "Manage User Accounts"
functions on the Admin UI and others.
* env.shlib - take a look at the ldapud/env.shlib to
	* customize some of the values in the env.shlib
	* for your own customization
* bash userstatus.sh username -- return status value
* bash enable.sh username
* bash disable.sh username
* bash newpwd.sh username newpassword
* bash forcepwd.sh username -- force password change
* bash clearpwd.sh username -- clear password change
* bash adduser.sh username lastname firstname emailaddress
	* it create a user and show the self password service link.
	* adduser.temp is the template used to create the user
* ag.fcc -- a sample FCC that works with selfpwdlink.sh
	* needs to be deployed under the Web Agent forms 
* smpwservices.fcc --
	* the default password service fcc captured from
	* siteminder web agent installtion
* bash selfpwdlink.sh id password
	* print out self password reset link
* doc.txt - a high-level document about self password reset
