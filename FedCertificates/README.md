* export.sh JSONFile
* expp12.sh aliasname password # to export p12, a binary file
* expp8.sh aliasname password # to export p8 (encrypted private key)
* exppem.sh aliasname # to export certificate in PEM format
* expder.sh aliasname # to export certificate in DER, a binary file
* import certificate examples
** bash FedCertificates/impp12.sh alaisName p12File Password
** bash FedCertificates/imppem.sh alaisName pemFile
** bash FedCertificates/impca.sh alaisName pemAsCAFile
