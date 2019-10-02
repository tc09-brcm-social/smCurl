* create.sh JSONFileName -- create a certificate using a JSON file
* delete.sh AliasName -- delete a certificate
* exist.sh Alias -- check if the alias exists
** using read.sh, emit same output, and exist 1 if responseType is error
* export.sh JSONFile -- export a cert using spec in the JSONFile, used by the other exp*.sh
* expp12.sh aliasname password # to export p12, a binary file
* expp8.sh aliasname password # to export p8 (encrypted private key)
* exppem.sh aliasname # to export certificate in PEM format
* expder.sh aliasname # to export certificate in DER, a binary file
* expired.sh optionalDays -- list certificates being expired in optional number of days
* impca.sh alaisName pemAsCAFile # import a certificate PEM file as a CA
* impp12.sh alaisName p12File Password # import a Key Entry from a password protected p12 file
* imppem.sh alaisName pemFile # import a certificate from a PEM file
* list.sh AliasNameSpec -- list the existing certificate aliases in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingAliasName OptionalPassword -- make a template script from an existing alias
** maketemp.sh invokes other maketemp*.sh according to how the certificate is stored.
** only the alias name and the optional password are parameterized
* maketempca.sh ExistingAliasName -- make a template Trusted CA script from an existing alias
* maketemppem.sh ExistingAliasName -- make a template certificate script from an existing alias
* maketempp12.sh ExistingAliasName Password -- make a template script from an existing key alias
* read.sh AliasSpec  -- GET the certificate
* update.sh AliasName JSONFileName -- update the certificate using a JSON file
** this retains all existing relationships
