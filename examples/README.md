# examples
There examples were created over several generations of this framework.
As a result, the tatics used to develop each of them could be very different.
Over time, they will be revised using a more consistent approach.
ldapusermgmt is a good example that reflects the current thinking.
It utilizes a far more complicated env.shlib and "git checkout" to 
retrieve original env.shlib under ldapud to avoid anomalies created
by earlier examples.
The current implementation of SAML2 Metadata import scripts needed by
saml2idpsp and saml2spidp requires xml2json utility available
at https://www.npmjs.com/package/xml2json-cli.
The installation of it further requires npm. Current thinking is to replace
this requirement using other tools to minimize the need for more
thirdparty tools.
* aad -- an example script that retrieves Microsoft Azure OpenID Connect Metadata
	* to import its embedded certificates.
	* To use with other OpenID Connect Metatdata that contains x5c data
	* modify the URL in the env.shlib
* apache -- an example script that use examples/wa to create
	* objects required before running Apache Web Agent Config Wizard
* app1 -- an example script that create auth scheme, agent, agent group,
	* domain associated with an existing user directory,
	* realm that uses the auth scheme and protected by agent/agent group
	* and policy that ties all users to allowgetpost rule of the realm.
	* The names of these objects are in the changable env.shlib file.
* forceoidc -- an example script that uses SiteMinder as an OIDC Provider
	* to single sign-on to SalesForce
* ldapud -- contains a set facilities to simplify the management interface of
	* your LDAP user directory.
	* It also checks the availability of ldapsearch command
	* and attempt to use yum install to install the openldap-clients.
* ldapusermgmt -- utilizes ldapud in an attempt to implement the
	* user management facilities seen on the regular SiteMinder AdminUI.
* redirectjsp -- sample script that create domain policies to protect
	* the Authentication URL redirecjsp used with Federation use cases.
	* It actually modify the env.shlib of the app1 examples and
	* reuse the make.sh of app1 to accomplish the work
* saml2 -- an ealier script that create all the objects required for
	* a working IdP->SP and SP->IdP partnerships
* saml2idpsp -- take an Remote SP Metadata file and an existing local IdP entity
	* to import the remote sp entity and its supported certificate objects.
	* Further, it uses a supplied template file idpsp.temp to create an
	* IdP->SP Partnership. idpsp.temp was modeled after examples/saml2.
* saml2spidp -- take an Remote IdP Metadata file and an existing local SP entity
        * to import the remote idp entity and its supported certificate objects.
        * Further, it uses a supplied template file spidp.temp to create an
        * SP->IdP Partnership. spidp.temp was modeled after examples/saml2.
* sps -- an example script that use examples/wa to create
	* objects required before running Access Gateway Config Wizard
	* also contains script to enable SPS UI
* wa -- an example script to create the three required objects
	* before a Web Agent Config Wizard could be run
