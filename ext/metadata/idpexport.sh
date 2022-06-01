#!/bin/bash
NAME=$1
if ! EXIST=$(bash FedIdPLocals/exist.sh "$NAME") ; then
    >&2 echo "$NAME does not exist, skipped"
    exit 1
fi
IdPID=$(echo "$EXIST" | jq -r '.data.IdPID')
BaseURL=$(echo "$EXIST" | jq -r '.data.BaseURL')
RequireSignedAuthnRequests=$(echo "$EXIST" | jq -r '.data.RequireSignedAuthnRequests')
DefaultSigningCertificateID=$(echo "$EXIST" | jq -r '.data.DefaultSigningCertificate.id')
if [[ "$DefaultSigningCertificateID" == "null" ]] ; then
    ISSUER=
    SN=
    SUBJECT=
    CERT=
else
    CERTOBJ=$(bash objects/read.sh "$DefaultSigningCertificateID" | jq '.data')
    ISSUER=$(echo "$CERTOBJ" | jq -r ".IssuerDN")
#    SN=$(echo "$CERTOBJ" | jq -r ".SerialNumber" | sed 's/://g' | tr '[A-Z]' '[a-z]')
#    SN=$(echo "$CERTOBJ" | jq -r ".SerialNumber")
    SN=
    SUBJECT=$(echo "$CERTOBJ" | jq -r ".IssuedTo")
    CERT=$(echo "$CERTOBJ" | jq -r ".CertificateData" | base64 --decode | grep -v '\---')
fi
SAA=$(echo "$EXIST" | jq '.data.SupportedAssertionAttributes')
if [[ "$SAA" = null ]] ; then
    ATTR=
else
    ATTR=
    LEN=$(echo "$SAA" | ./jq 'length')
    for (( i = 0; i < $LEN; ++i )) ; do
#        <ns3:Attribute
#            Name="lastname"
#            NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"/>
# ."ns4:EntityDescriptor"."ns4:IDPSSODescriptor"."@WantAuthnRequestsSigned" = $t
        S=$(echo "$SAA" | ./jq ".[$i]")
        NAME=$(echo "$S" | ./jq -r '.Name')
        NAMEF=$(echo "$S" | ./jq -r '.NameFormat')
        ATTR=$(echo "$ATTR <ns3:Attribute Name=\"$NAME\" NameFormat=\"$NAMEF\"/>")
    done
fi
NameIDFormat=$(echo "$EXIST" | jq -r '.data.NameIDFormat')
if [[ "$NameIDFormat" = null ]] ; then
    NIDF=
else
    NIDF=
    TRAIL=
    LEN=$(echo "$NameIDFormat" | ./jq 'length')
    for (( i = 0; i < $LEN; ++i )) ; do
#        <ns4:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress</ns4:NameIDFormat>
        S=$(echo "$NameIDFormat" | ./jq -r ".[$i]")
        NIDF=$(echo "$NIDF$TRAIL<ns4:NameIDFormat>$S</ns4:NameIDFormat>")
        TRAIL=" "
    done
fi
cat <<EOF | xq --arg s "$IdPID" \
    --arg t "$RequireSignedAuthnRequests" \
    '
    ."ns4:EntityDescriptor"."@entityID" = $s
    | ."ns4:EntityDescriptor"."ns4:IDPSSODescriptor"."@WantAuthnRequestsSigned" = $t
    ' \
    -x
<?xml version="1.0" encoding="UTF-8"?>
<ns4:EntityDescriptor
    xmlns:ns4="urn:oasis:names:tc:SAML:2.0:metadata"
    xmlns="http://www.w3.org/2000/09/xmldsig#"
    xmlns:ns2="http://www.w3.org/2001/04/xmlenc#"
    xmlns:ns3="urn:oasis:names:tc:SAML:2.0:assertion"
    ID="SMb34ec5acea0172b015821c3d1cf819f5d7f31ea7fc"
    entityID="eid">
    <ns4:Extensions xmlns:alg="urn:oasis:names:tc:SAML:metadata:algsupport">
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
    </ns4:Extensions>
    <ns4:IDPSSODescriptor
        ID="SM2bb883ed4c13b4a251f40d7eff869de1dc961cc736"
        WantAuthnRequestsSigned="true"
        protocolSupportEnumeration="urn:oasis:names:tc:SAML:2.0:protocol">
        <ns4:KeyDescriptor use="signing">
            <KeyInfo Id="SM142eb4117ef58cd1c0465f9026b47b8e5dcad31287f">
                <X509Data>
                    <X509IssuerSerial>
                        <X509IssuerName>$ISSUER</X509IssuerName>
                        <X509SerialNumber>$SN</X509SerialNumber>
                    </X509IssuerSerial>
                    <X509Certificate>$CERT</X509Certificate>
                    <X509SubjectName>$SUBJECT</X509SubjectName>
                </X509Data>
            </KeyInfo>
        </ns4:KeyDescriptor>
        <ns4:ArtifactResolutionService
            Binding="urn:oasis:names:tc:SAML:2.0:bindings:SOAP"
            Location="$BaseURL/affwebservices/public/saml2ars"
            index="0"
            isDefault="true"/>
        <ns4:SingleLogoutService
            Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect"
            Location="$BaseURL/affwebservices/public/saml2slo"/>
        <ns4:SingleLogoutService
            Binding="urn:oasis:names:tc:SAML:2.0:bindings:SOAP"
            Location="$BaseURL/affwebservices/public/saml2slosoap"/>
        <ns4:SingleLogoutService
            Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"
            Location="$BaseURL/affwebservices/public/saml2slo"/>
        $NIDF
        <ns4:SingleSignOnService
            Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect"
            Location="$BaseURL/affwebservices/public/saml2sso"/>
        <ns4:SingleSignOnService
            Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"
            Location="$BaseURL/affwebservices/public/saml2sso"/>
    $ATTR
    </ns4:IDPSSODescriptor>
</ns4:EntityDescriptor>
EOF
