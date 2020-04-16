* wrapx5c.sh X5CCert -- wrap the Certificate that is commonly seen as x5c
	* with proper PEM BEGIN and END. This output is commonly redirected to a file
* for save, rename, copy.
	* only rename works as the same certificate is not allowed to exist twice by design
* rename.sh AliasName NewAliasName -- change the certificate from AliasName to NewAliasName
	* this retains all existing relationships
* search.sh CertPEMFileName -- find the CertPath of a PEMFile
	* use SHA1 fingerprint to look for the path of an imported certificate.
