* Notes
** del(.id)
** .Name replace with parameter
** del(.Policy.SmUserPolicies.id)
** .Policy.SmUserPolicies[]
*** del(.id)
*** .UserDirectory[]
***  replace with path: /SmUserDirectories/name using id to search or parameter
** del(.AttributeService.id)
** del(.StatusRedirect.id)
** .UserDirectories[]
*** keep .path only or replace it with parameter
** .RemoteSPEntityName replace with parameter
** .LocalIdPEntityName replace with parameter
** .SignatureOptions.VerificationCertificate
*** keep .path only or parameter
** .SignatureOptions.SigningPrivateKey
*** keep .path only or parameter
** del(.Authentication.OpenFormatCookieConfiguration.id)
** .Backchannel
*** del(.Incoming.id)
*** del(.Outgoing.id)
** .SLO.SLOServices[]
*** del(.id)
** .AssertionConfiguration.AssertionAttributes[]
*** del(.id)
*** del(.AttributeSource.id)
** del(.AttributeSource.id)
** del(.EncryptionOptions.EncryptionConfiguration.id)
** .EncryptionOptions.EncryptionConfiguration.EncryptionCertificate
*** replace with path: /FedCertificates/name using id to search or parameter SP
** del(.NameIDManagement.Configuration.id)
** .SSO.RemoteAssertionConsumerServices[]
*** del(.id)
