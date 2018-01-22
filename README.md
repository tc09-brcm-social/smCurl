# cassoRest

When this kit is first deployed to a new machine where CA SSO API is 
to be used as a DevOps command center, the bash isOK.sh should be run first.
You will need to modify the authn for the Admin UI hostname and
Basic Auth base64 encoded id and password.

* makebaseps.sh is used to deploy basic objects for a standalone policy server
** it assumes CA Directory and Policy Server components are colocated.
** makebaseps.sh should be run only once.
** after this is run, the SPS and apache web agent
** can then be configured to use these base object.
* apcert.key.temp is not usable as the impCert.sh does not support keyentry type
* isOK.sh is added to verify ps and authentication has been set correctly
* jq https://stedolan.github.io/jq/download/
