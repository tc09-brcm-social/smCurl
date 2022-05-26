# examples/myidp
This example is designed to let us create a Local IdP Entity
and the certificates that associates with it.
* Local IdP Entity Templates
	* simple.temp -- a simple template that
		* supports email and unspecified NameID formats
		* DOES have a default signing certificate
		* DOES NOT require signed authentication request
		* DOES NOT announce available SAML Attributes
	* emailattribute.temp -- same as simple.temp but
		* supports an EMAIL SAML Attribute
* Getting Started
	* Create/modify a Local IdP Entity template using existing ones to start
	* Configure env.shlib properly, see env.shlib for more info, and
	*
	* bash make.sh
	*
	* to create a local IdP Entity
* Manifest
	* READNME.md -- this file
	* env.shlib -- environment settings to provide the parameters needed
	* simple.temp -- a simple Local IdP Entity template
		* bash simple.temp NAME FQDN SHORTID FEDBASE CERT
	* emailattribute.temp -- a simple Local IdP Entity template likes
		* simple.temp but provides an EMAIL SAML attribute
	* make.sh -- create a local IdP Entity and its self-signed signing cert
	* unmake.sh -- remove what make.sh makes
