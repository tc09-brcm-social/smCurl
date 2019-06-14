* examples of using export.sh
** bash FedCertificates/export.sh aliasname PKCS12 password # to export p12
** bash FedCertificates/export.sh aliasname PKCS8 password # to export p8
** bash FedCertificates/export.sh aliasname PEM # to export PEM
** bash FedCertificates/export.sh aliasname DER # to export DER
* The output of the export.sh when works can further be fed into jq
** jq -r '.data.CertificateData' | base64 -d >alias.p12 to create p12 file 
** jq -r '.data.CertificateData' | base64 -d to view the PKCS8 file 
** jq -r '.data.CertificateData' | base64 -d to view the crt in PEM file 
* import certificate examples
** bash FedCertificates/impp12.sh alaisName p12File Password
** bash FedCertificates/imppem.sh alaisName pemFile
** bash FedCertificates/impca.sh alaisName pemAsCAFile
