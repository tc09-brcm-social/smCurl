* authn.sh -- uses the env.shlib to help create the authn
* makeauth.sh -- create authn file from env.shlib
	* run this from the home directory as bash utils/makeauth.sh
* escName.sh - escape name 
	* currently convert " " to "+", '#' to %23, '/' to %2F
* jdelattrs.sh -- set first level attributes to "" or []
* . utils/jsontokv.sh JSONFile -- convert a JSON File to environment variables 
* . utils/listtokv.sh LIST -- convert a comma separated key=value to environment variables 
* setkeyvalue.sh FILENAME KEY VALUE -- set KEY=VALUE in a file
* getcert.sh hostname optionalPortNumber -- obtain https server certificate
