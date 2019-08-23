*idpdemocert.temp aliasName password -- import the idp.demo certificate
** password is literially password as the p12 embedded in the template is protected as such
* Lidp.temp instanceCode certAliasName -- create a Local IdP named as Ldemo${instanceCode}
* make.sh -- the make script that creates required saml2 partnership objects.
** require a pre-existing User Directory
** change the instance codes to create additional instances if desired
** idpn1, spn1 being the default, you can set it to idpn2, spn2 to run again
* Rsp.temp instanceCode certAliasName -- create a Remote SP using Rdemo${instanceCode}
* spidp.temp partnershipName SPInstCode IdPInstCode SPCert IdPCert UserDirectoryName
** create SP->IdP partnership
* idpsp.temp partnershipName IdPInstCode SPInstCode IdPCert SPCert UserDirectoryName
** create IdP->SP partnership
* Lsp.temp instanceCode certAliasName -- create a Local SP named as Ldemo${instanceCode}
* Ridp.temp instanceCode certAliasName -- create a Remote IdP named as Rdemo${instanceCode}
* spdemocert.temp aliasName password -- import the sp.demo certificate
** password is literally password as the embedded p12 is protected by it.
* unmake.sh -- remove the two partnerships and four entities created through make.sh
