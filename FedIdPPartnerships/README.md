* Notes
** del(.id)
#** .Name replace with parameter
** del(.StatusRedirect.id)
#** .UserDirectories[]
#*** keep .path only or replace it with parameter
#** .Policy.SmUserPolicies[]
*** del(.id)
#*** replace UserDirectory with path: /SmuserDirectories/name using id to search or parameter
#** .RemoteIdPEntityName replace with parameter
#** .LocalSPEntityName replace with parameter
** del(.UserProvisioning.OpenFormatCookieConfiguration.id)
#** .SignatureOptions.VerificationCertificate
#*** keep .path only or parameter IDP
#** .SignatureOptions.SigningPrivateKey
#*** keep .path only or parameter SP
** del(.NameID.AttributeSouce.id)
** del(.NameIDManagement.Configuration.id)
** .TargetApplication.AttributeMappings[]
*** del(.id)
** .SSO.RemoteSSOServices[]
*** del(.id)
** .SSO.RemoteArtifactResolutionServices[]
*** del(.id)
** del(.AttributeRequesterService.Configuration.id)
** .Backchannel
*** del(.Incoming.id)
*** del(.Outgoing.id)
** .SSO.SLOServices[]
*** del(.id)
#** .Encryptionptions
*** del(.EncryptionConfiguration.id)
#*** .DecryptionPrivateKey SP
#**** keep .path only or replace it with parameter
** del(.UserIdentification.UserMapping.id)
