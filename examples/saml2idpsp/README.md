* env.shlib
	* SPXML: Remote SP Metadata File
	* IDPNAME: Local IdP Entity Name
	* SP: used as a Remote SP name suffix and a Certificate Name prefix
	* SPNAME: Remote SP Entity Name to rename to after metadata file import
	* UD: an existing User Directory
* idpsp.temp LocalIdPName RemoteSPName UserDirectory
	* a template to create LocalIdpName-RemoteSPName Partnership 
* make.sh -- import the Remote SP Metadata File to create certificates and
	* a Remote SP Entity, then create an IdP->SP partnership
	* assuming the user directory and local IdP exist
* unmake.sh -- remove the IdP->SP partnership and two possible Remote SP entities
	* the two possible Remote SP entities are ${SPNAME} and Rsp${SP}
