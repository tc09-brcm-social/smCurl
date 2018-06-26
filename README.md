# cassoCurl

This is the starting of the version 1 for the original cassoRest and
renamed as cassoCurl.

Naming conventions and re-structure is to be applied religiously for this branch.

* authn - is now a working copied and to be ignored by the git status.
It is the first file to be created using the authn.sample to fit your running
instance. See its content for details.
The base64-id:password can actually be calculated using the following shell script:

echo -n "base64-id:password" | base64 

* isOK.sh - is used to verify ps and authentication has been set correctly within the authn.

When this kit is first deployed to a new machine where CA SSO API is 
to be used as a DevOps command center, the bash isOK.sh should be run first.
You will need to modify the authn for the Admin UI hostname and
Basic Auth base64 encoded id and password.

* examples/makeapp1.sh, examples/delapp1.sh assumes iis-01, apache-01 and CA+Directory exists.

cd examples
bash makeapp1.sh \# to create domain and policies
bash delapp1.sh \# to clean up

* makebaseps.sh is used to deploy basic objects for a standalone policy server
** it assumes CA Directory and Policy Server components are colocated.
** makebaseps.sh should be run only once.
** after this is run, the SPS and apache web agent
** can then be configured to use these base object.
* apcert.key.temp is not usable as the impCert.sh does not support keyentry type
* jq stuff has been moved to https://github-isl-01.ca.com/cheyi02-social/jqtutor
