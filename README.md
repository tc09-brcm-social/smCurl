# cassoCurl

* This release contains an experimental SAML2 metadata import capabilities.
* They relies on xml2json available at https://www.npmjs.com/package/xml2json-cli
* which further requies npm to install. It also requires dos2unix as well.
* The installation of xml2json could be challenging. As a result, it is under
* review. We are hoping to create a new version to ease the possible pain of it.

This is the second public release original cassoRest then cassoCurl.
It uses the Shell Scripting framework proposed by:
https://apiacademy.co/2019/10/devops-rest-api-execution-through-bash-shell-scripting/

* Pre-requisites
	* jq: to be downloaded from https://stedolan.github.io/jq/download/
	* Windows git: https://git-scm.com/download/win
	* jq needs to be executable and stored at the same directory as authn.

* authn - is now to be made using bash utils/makeauthn.sh from the home diretory
	* use the utils/env.shlib.sample to utils/env.shlib
	* change the utils/env.shlib with your AdminUI host, port, id, and password
	* after the bash utils/makeauthn.sh, you can removed the utils/env.shlib.
	* it is ignored by the git status

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
	* and many others, please consult the examples/README.md for details.
