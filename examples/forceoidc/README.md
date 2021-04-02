# examples/auth0oidc
Salesforce OIDC Authorization Code Flow Configuration.
Modify the env.shlib then run bash make.sh to configure SiteMinder 
and obtain information used to configure Auth. Providers on force.com.
* See env.shlib for configuration detail
* make.sh
	* if not exist, create Authorization Provider,
	* Authorization Provider Signing Certificate,
	* OIDC Client object
	* display information needed to configure force.com for SiteMinder
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
