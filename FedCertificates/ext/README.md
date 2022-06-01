* env.shlib -- see env.shlib for detail Environment Variables
* wrapx5c.sh X5CCert -- wrap the Certificate that is commonly seen as x5c
	* with proper PEM BEGIN and END. This output is commonly redirected to a file
* for save, rename, copy.
	* only rename works as the same certificate is not allowed to exist twice by design
* rename.sh AliasName NewAliasName -- change the certificate from AliasName to NewAliasName
	* this retains all existing relationships
* search.sh CertPEMFileName -- find the CertPath of a PEMFile
	* use SHA1 fingerprint to look for the path of an imported certificate.
* selfsigned.sh CertName FQDN -- password MYCERPASS in env.shlib
* usedby.sh CertName -- show used by of a Cert
* imppemorsearch.sh AliasName CertPEMFileName -- import a PEMFile or search its existing Alias
