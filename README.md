# cassoCurl

* This is release 3 of this framework.
	* This package is distributed through the Broadcom Community website.
	* Starting with this release, we now embrace the usage of git client
	* and want to make you aware of it.
	* Find more information about git can be found at
	* https://git-scm.com/
	*
	* This package is distributed in a zip file.
	*
	* When you unzip the file, what you have is a subdirectory that contains
	* two git branches with smCurl3 being the default branch.
	*
	* "git checkout smCurl2" will take you back to the release 2
	* and vice versa.
	*
	* Some of the examples in the examples subdirectory actually use
	* "git checkout" to recover the original files that come with 
	* this release.
	*
	* You can also use "git status" and other git facilities to exam the
	* changes that have made to the unzipped subdirectory.
	*
* SAML2 metadata import capabilites notes ---
	* The SAML2 metadata import capabilities in this release
	* has not been changed. They remain experimental.
	* They relies on xml2json available at
	* https://www.npmjs.com/package/xml2json-cli
	* which further requies npm to install.
	* It also requires dos2unix as well.
	* The installation of xml2json could be challenging.
	* As a result, it is under review.
	* We are hoping to create a new version to ease the possible pain of it.

This is the third public release of the original cassoRest then cassoCurl.
It uses the Shell Scripting framework proposed by:
https://apiacademy.co/2019/10/devops-rest-api-execution-through-bash-shell-scripting/

* Pre-requisites
	* jq: to be downloaded from https://stedolan.github.io/jq/download/
	* Windows git: https://git-scm.com/download/win
	* jq needs to be executable and stored at the same directory as authn.
	* git: is assumed to be available.

* authn - is now to be made using bash utils/makeauthn.sh from the home diretory
	* use the utils/env.shlib.sample to create the utils/env.shlib
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
