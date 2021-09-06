# examples/forceoidc
This example requires git client to work.
Salesforce OIDC Authorization Code Flow Configuration.
Modify the env.shlib then run bash make.sh to configure SiteMinder 
and obtain information used to configure Auth. Providers on force.com.
* Getting Started
	* # Setup the "OIDC Client Information" Section in env.shlib
	* sign on to http://developer.salesforce.com/
	* go to SETTINGS/Company Settings/Company Information
	* to locate the Salesforce.com Organization ID.
	* Set the FORCEORGID to this value.
	* Make up a URL Suffix you intend to use. By default
	* this is the Name of your Auth Provider to be created later.
	* Set the URLSUFFIX to this value.
	* Make up an OIDC client name stored on SiteMinder
	* Set the CLIENTNAME env.shlib to this value.
	* # Setup the "Authorization Provider Information" Section in env.shlib
	* See env.shlib for details
	* # Setup the "redirectjsp Protection Policy" Section in env.shlib
	* See env.shlib for details
* ../../env.shlib
	* This example also uses ../../env.shlib to obtain
	* the default Default Web Server Host Name, Web Server Base URL
	* Access Gateway Host Name, Access Gateway Base URL,
	* and the Default User Directory name
* oidc.jsp:
	* This is the oidc.jsp used in this example.
	* It is slightly modified from the oauth.jsp comes with
	* the standard Access Gateway distribution.
	* If you want to use it, deploy it under the
	* affwebservices/redirectjsp.
* make.sh
	* if not exist, create Authorization Provider,
	* Authorization Provider Signing Certificate,
	* OIDC Client object
	* display information needed to configure force.com for SiteMinder
* geturls.sh
	* base on make.sh but only
	* display the OIDC Excercising URLs if CLIENTNAME exists
* force.temp APName UserDirectory SigningCert BaseURL
	*  OIDC Authorization Provider template for force.com
* force0client.temp clientName APName forceTenantID URLSuffix
	* OIDC Client template for force.com
	* use FedOIDCClients/temp/azcode.temp as a base
* IDtoken Signing
	* RS256/RS384/RS512 all worked for IDtoken Signing
* claims need to include
	* sub, family_name, given_name, email
* SignUserInfo needs to be false
