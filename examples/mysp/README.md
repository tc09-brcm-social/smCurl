# examples/mysp
This example is designed to help create a Local SP Entity
and the certificates associate with it.
* Local SP Entity Templates
	* simple.temp -- a simple template that
		* supports email and unspecified NameID formats
		* DOES have a default signing certificate
		* DOES have a default encryption certificate
		* WILL sign authentication request
* Usage
	* Create/modify a Local SP Entity template using existing ones to start
	* Configure env.shlib properly, see env.shlib for more info, and
	*
	* bash make.sh
	*
	* to create a local SP Entity
* Manifest
	* READNME.md -- this file
	* env.shlib -- environment settings to provide the parameters needed
	* simple.temp -- a simple Local IdP Entity template
		* bash simple.temp NAME FQDN SHORTID FEDBASE SIGNCERT ENCERT
	* make.sh -- create a local SP Entity and its self-signed certs
	* unmake.sh -- remove what make.sh makes
