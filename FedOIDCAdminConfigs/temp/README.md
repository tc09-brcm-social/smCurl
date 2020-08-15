* the FedOIDC RestAPI is known to be version dependent
** There are differences between different versions
* oidc.jsp -- a slightly modified version of the openid.jsp
	* to <     private final String SSOURL = "SMPORTALURL";
	* ---
	* from >     private final String SSOURL = "redirectURL";
	* deploy it under the affwebservices/redirectjsp
* sample.temp APName UserDirectoryName CertificateName BaseURL
** This sample.temp uses the oidc.jsp and the BaseURL to form the Authentication URL
