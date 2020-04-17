* env.shlib
	* IDPXML: Remote IdP Metadata File
	* SPNAME: Local SP Entity Name
	* IDPNAME: Remote IdP Entity Name
	* IDP: used as a Remote IdP name suffix and a Certificate Name prefix
	* UD: an existing User Directory
	* LANDING: default landing page for the SP->IDP partnership
* spidp.temp LocalSPName RemoteIDPName UserDirectory LandingPage
	* a template to create LocalSPName-RemoteIdPName Partnership 
* make.sh -- import the Remote IdP Metadata File to create certificates and
	* a Remote IdP Entity, then create an SP->IdP partnership
	* assuming the user directory and local SP exist
* unmake.sh -- remove the SP->IdP partnership and two possible Remote IdP entities
	* the two possible Remote IdP entities are ${IDPNAME} and Ridp${IDP}
