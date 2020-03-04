# cassoCurl

This is the first public release original cassoRest then cassoCurl.
It uses the Shell Scripting framework proposed by:
https://apiacademy.co/2019/10/devops-rest-api-execution-through-bash-shell-scripting/

* Pre-requisites
	* jq: to be downloaded from https://stedolan.github.io/jq/download/
	* Windows git: https://git-scm.com/download/win

* authn - is now a working copied and to be ignored by the git status.
It is the first file to be created using the authn.sample to fit your running
instance. See its content for details.
The base64-id:password can actually be calculated using the following shell script:

echo -n "base64-id:password" | base64 

OPT environment variable in authn can now be used to carry more flags for curl command.

* isOK.sh - is used to verify ps and authentication has been set correctly within the authn.

When this kit is first deployed to a new machine where CA SSO API is 
to be used as a DevOps command center, the bash isOK.sh should be run first.
You will need to modify the authn for the Admin UI hostname and
Basic Auth base64 encoded id and password.

* examples contains a number of examples to poke your interest
	* examples/sps - used to enable the Access Gateway UI
		* after a successful Access Gateway Config Wizard
	* examples/saml2 - used to create sample SAML2 Federation Partnerships
	* examples/aad - used to import Microsoft Azure certs if you use it
