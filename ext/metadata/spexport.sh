#!/bin/bash
NAME=$1
if ! EXIST=$(bash FedSPLocals/exist.sh "$NAME") ; then
    >&2 echo "$NAME does not exist, skipped"
    exit 1
fi
SPID=$(echo "$EXIST" | jq -r '.data.SPID')
SignAuthnRequests=$(echo "$EXIST" | jq -r '.data.SignAuthnRequests')
SigningPrivateKey=$(echo "$EXIST" | jq -r '.data.SigningPrivateKey.id')
BaseURL=$(echo "$EXIST" | jq -r '.data.BaseURL')
if [[ "$SigningPrivateKey" == "null" ]] ; then
    SISSUER=
    SSN=
    SSUBJECT=
    SCERT=
else
    CERTOBJ=$(bash objects/read.sh "$SigningPrivateKey" | jq '.data')
    SISSUER=$(echo "$CERTOBJ" | jq -r ".IssuerDN")
    SSN=
    SSUBJECT=$(echo "$CERTOBJ" | jq -r ".IssuedTo")
    SCERT=$(echo "$CERTOBJ" | jq -r ".CertificateData" | base64 --decode | grep -v '\---')
fi
DecryptionPrivateKey=$(echo "$EXIST" | jq -r '.data.DecryptionPrivateKey.id')
if [[ "$DecryptionPrivateKey" == "null" ]] ; then
    EISSUER=
    ESN=
    ESUBJECT=
    ECERT=
else
    CERTOBJ=$(bash objects/read.sh "$SigningPrivateKey" | jq '.data')
    EISSUER=$(echo "$CERTOBJ" | jq -r ".IssuerDN")
    ESN=
    ESUBJECT=$(echo "$CERTOBJ" | jq -r ".IssuedTo")
    ECERT=$(echo "$CERTOBJ" | jq -r ".CertificateData" | base64 --decode | grep -v '\---')
fi
NameIDFormat=$(echo "$EXIST" | jq -r '.data.NameIDFormat')
if [[ "$NameIDFormat" = null ]] ; then
    NIDF=
else
    NIDF=
    TRAIL=
    LEN=$(echo "$NameIDFormat" | ./jq 'length')
    for (( i = 0; i < $LEN; ++i )) ; do
#        <ns2:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress</ns2:NameIDFormat>
        S=$(echo "$NameIDFormat" | ./jq -r ".[$i]")
        NIDF=$(echo "$NIDF$TRAIL<ns2:NameIDFormat>$S</ns2:NameIDFormat>")
        TRAIL=" "
    done
fi
cat <<EOF | xq --arg s "$SPID" \
    --arg t "$SignAuthnRequests" \
    -x \
    '
    ."ns2:EntityDescriptor"."@entityID" = $s
    | ."ns2:EntityDescriptor"."ns2:SPSSODescriptor"."@AuthnRequestsSigned" = $t
    '
<?xml version="1.0" encoding="UTF-8"?>
<ns2:EntityDescriptor
    xmlns:ns2="urn:oasis:names:tc:SAML:2.0:metadata"
    xmlns="http://www.w3.org/2000/09/xmldsig#"
    xmlns:ns3="http://www.w3.org/2001/04/xmlenc#"
    xmlns:ns4="urn:oasis:names:tc:SAML:2.0:assertion"
    ID="SM20dd049080e0574febb0f3f8df9debe29b93f537044"
    entityID="eid">
    <ns2:Extensions xmlns:alg="urn:oasis:names:tc:SAML:metadata:algsupport">
        <alg:DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/>
        <alg:DigestMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#sha224"/>
        <alg:DigestMethod Algorithm="http://www.w3.org/2001/04/xmlenc#sha256"/>
        <alg:DigestMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#sha384"/>
        <alg:DigestMethod Algorithm="http://www.w3.org/2001/04/xmlenc#sha512"/>
        <alg:SigningMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"/>
        <alg:SigningMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"/>
        <alg:SigningMethod Algorithm="http://www.w3.org/2007/05/xmldsig-more#sha1-rsa-MGF1"/>
        <alg:SigningMethod Algorithm="http://www.w3.org/2007/05/xmldsig-more#sha224-rsa-MGF1"/>
        <alg:SigningMethod Algorithm="http://www.w3.org/2007/05/xmldsig-more#sha256-rsa-MGF1"/>
        <alg:SigningMethod Algorithm="http://www.w3.org/2007/05/xmldsig-more#sha384-rsa-MGF1"/>
        <alg:SigningMethod Algorithm="http://www.w3.org/2007/05/xmldsig-more#sha512-rsa-MGF1"/>
    </ns2:Extensions>
    <ns2:SPSSODescriptor
        AuthnRequestsSigned="true_false"
        ID="SM3e42787d19a2b17ef2cd6c28767cad2685561a9e74"
        WantAssertionsSigned="false"
        protocolSupportEnumeration="urn:oasis:names:tc:SAML:2.0:protocol">
        <ns2:KeyDescriptor use="encryption">
            <KeyInfo Id="SMb17aada8e1da27ff64d4ac445cf870e1ce5bad16ab">
                <X509Data>
                    <X509IssuerSerial>
                        <X509IssuerName>$EISSUER</X509IssuerName>
                        <X509SerialNumber>$ESN</X509SerialNumber>
                    </X509IssuerSerial>
                    <X509Certificate>$ECERT</X509Certificate>
                    <X509SubjectName>$ESUBJECT</X509SubjectName>
                </X509Data>
            </KeyInfo>
            <ns2:EncryptionMethod Algorithm="http://www.w3.org/2001/04/xmlenc#tripledes-cbc"/>
            <ns2:EncryptionMethod Algorithm="http://www.w3.org/2001/04/xmlenc#aes128-cbc"/>
            <ns2:EncryptionMethod Algorithm="http://www.w3.org/2001/04/xmlenc#aes256-cbc"/>
            <ns2:EncryptionMethod Algorithm="http://www.w3.org/2009/xmlenc11#aes128-gcm"/>
            <ns2:EncryptionMethod Algorithm="http://www.w3.org/2009/xmlenc11#aes192-gcm"/>
            <ns2:EncryptionMethod Algorithm="http://www.w3.org/2009/xmlenc11#aes256-gcm"/>
            <ns2:EncryptionMethod Algorithm="http://www.w3.org/2001/04/xmlenc#rsa-1_5"/>
            <ns2:EncryptionMethod Algorithm="http://www.w3.org/2001/04/xmlenc#rsa-oaep-mgf1p"/>
            <ns2:EncryptionMethod Algorithm="http://www.w3.org/2009/xmlenc11#rsa-oaep"/>
        </ns2:KeyDescriptor>
        <ns2:KeyDescriptor use="signing">
            <KeyInfo Id="SM1cd6b5fbc3aaf6be938b1781898017d28562090b41">
                <X509Data>
                    <X509IssuerSerial>
                        <X509IssuerName>$SISSUER</X509IssuerName>
                        <X509SerialNumber>$SSN</X509SerialNumber>
                    </X509IssuerSerial>
                    <X509Certificate>$SCERT</X509Certificate>
                    <X509SubjectName>$SSUBJECT</X509SubjectName>
                </X509Data>
            </KeyInfo>
        </ns2:KeyDescriptor>
        <ns2:SingleLogoutService
            Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect"
            Location="$BaseURL/affwebservices/public/saml2slo"/>
        <ns2:SingleLogoutService
            Binding="urn:oasis:names:tc:SAML:2.0:bindings:SOAP"
            Location="$BaseURL/affwebservices/public/saml2slosoap"/>

        $NIDF
        <ns2:AssertionConsumerService
            Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"
            Location="$BaseURL/affwebservices/public/saml2assertionconsumer" index="0" isDefault="false"/>
        <ns2:AssertionConsumerService
            Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Artifact"
            Location="$BaseURL/affwebservices/public/saml2assertionconsumer" index="1" isDefault="false"/>
        <ns2:AssertionConsumerService
            Binding="urn:oasis:names:tc:SAML:2.0:bindings:PAOS"
            Location="$BaseURL/affwebservices/public/saml2assertionconsumer" index="2" isDefault="false"/>
    </ns2:SPSSODescriptor>
</ns2:EntityDescriptor>
EOF
