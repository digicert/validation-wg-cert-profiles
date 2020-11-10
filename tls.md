## 7.1 Certificate Profile


### 7.1.1 All Certificates

All Certificates MUST Have a Certificate structure with the following fields as follows:

|Name|ASN.1 Type and Constraints|Permitted Values|References|
|----|--------------------------|----------------|----------|
|tbsCertificate|`TBSCertificate`|See Section 7.1.1.1|[RFC 5280, Section 4.1.1.1](https://tools.ietf.org/html/rfc5280#section-4.1.1.1)|
|signatureAlgorithm|`AlgorithmIdentifier`|See Section 7.1.3.2 for permitted values. The value MUST be equal to the `signature` field value of the TBSCertificate structure as defined in Section 7.1.1.1.|[RFC 5280, Section 4.1.1.2](https://tools.ietf.org/html/rfc5280#section-4.1.1.2)|
|signatureValue|`BIT STRING`|The digital signature computed upon the ASN.1 DER encoding of the `tbsCertificate` field|[RFC 5280, Section 4.1.1.3](https://tools.ietf.org/html/rfc5280#section-4.1.1.3)|


### 7.1.1.1 TBSCertificate Structure

All Certificates MUST Have a TBSCertificate structure with the following fields:

|Name|ASN.1 Type and Constraints|Permitted Value(s)|References|
|----|--------------------------|------------------|----------|
|version|`INTEGER`|MUST be v3(2)|[RFC 5280, Section 4.1.2.1](https://tools.ietf.org/html/rfc5280#section-4.1.2.1)|
|serialNumber|`INTEGER`<br>Encoded value MUST be no longer than 20 octets|MUST be a positive value that contains at least 64 bits of output from a CSPRNG|[RFC 5280, Section 4.1.2.2](https://tools.ietf.org/html/rfc5280#section-4.1.2.2)|
|signature|`AlgorithmIdentifier`|See Section 7.1.3.2 for permitted values. The value MUST be equal to the `signatureAlgorithm` field value of the Certificate structure as defined in Section 7.1.1.|[RFC 5280, Section 4.1.2.3](https://tools.ietf.org/html/rfc5280#section-4.1.2.3)|
|issuer|Name|MUST be byte-for-byte equal to the encoding of the `subject` field value of the issuing CA's Certificate|[RFC 5280, Section 4.1.2.4](https://tools.ietf.org/html/rfc5280#section-4.1.2.4)|
|validity|`Validity`|See Section 6.3.2.|[RFC 5280, Section 4.1.2.5](https://tools.ietf.org/html/rfc5280#section-4.1.2.5)|
|subject|`Name`|For Root and Subordinate CA Certificates, see Section 7.1.4.2.<br>For Subscriber Certificates, see Section 7.1.4.3.|[RFC 5280, Section 4.1.2.6](https://tools.ietf.org/html/rfc5280#section-4.1.2.6)|
|subjectPublicKeyInfo|`SubjectPublicKeyInfo`|See Sections 6.1.5, 6.1.6, and 7.1.3.1.|[RFC 5280, Section 4.1.2.7](https://tools.ietf.org/html/rfc5280#section-4.1.2.7)|
|issuerUniqueID|`BIT STRING`|MUST NOT be present|[RFC 5280, Section 4.1.2.8](https://tools.ietf.org/html/rfc5280#section-4.1.2.8)|
|subjectUniqueID|`BIT STRING`|MUST NOT be present|[RFC 5280, Section 4.1.2.8](https://tools.ietf.org/html/rfc5280#section-4.1.2.8)|
|extensions|`Extensions`|For Root Certificates, see Section 7.1.2.1.<br>For Subordinate CA Certificates, see Section 7.1.2.2.<br>For Subscriber Certificates, see Section 7.1.2.3.|[RFC 5280, Section 4.1.2.9](https://tools.ietf.org/html/rfc5280#section-4.1.2.9)|


### 7.1.2 Certificate Extensions

This Section specifies the additional requirements for Certificate extensions.

...


### 7.1.2.3 Subscriber Certificates

The Section specifies the requirements for extensions included in Subscriber Certificates.

|Extension ID|Required?|Critical?|Permitted Value(s)|References|
|------------|---------|-----------|------------------|----------|
|authorityKeyIdentifier|Yes|No|The `keyIdentifer` field MUST be present. `authorityCertIssuer` and `authorityCertSerialNumber` fields MUST NOT be present.|[RFC 5280, Section 4.2.1.1](https://tools.ietf.org/html/rfc5280#section-4.2.1.1)|
|certificatePolicies|Yes|SHOULD NOT be critical|See Section 7.1.6.4 for the permitted `policyIdentifiers`.<br>For each included `policyIdentifer`, the CA MAY include `policyQualifiers`. If the `id-qt-cps` policyQualifier is included, then it MUST contain a HTTP/HTTPS URL for the issuing CA's  Certification Practice Statement, Relying Party Agreement or other pointer to online information provided by the CA.|[RFC 5280, Section 4.2.1.4](https://tools.ietf.org/html/rfc5280#section-4.2.1.4)|
|subjectAlternateName|Yes|Yes if the `subject` is an empty sequence; otherwise, SHOULD NOT be critical|The set of Fully Qualified Domain Names (FQDN) validated under Section 3.2.2.4 and the set of IP addresses validated under Section 3.2.2.5.<br>Each FQDN is encoded as a `dNSName` GeneralName in preferred name syntax as defined in [RFC 1034, Section 3.5](https://tools.ietf.org/html/rfc1034#section-3.5) and modified by [RFC 1123, Section 2.1.](https://tools.ietf.org/html/rfc1123#section-2.1.) Wildcard FQDNs MAY be included by prepending a `U+002A ASTERISK ("*")` and `U+002E FULL STOP (".")` to a FQDN validated under Section 3.2.2.4 using a domain validation method that permits Wildcard FQDNs.<br>Each IP address is encoded in an `iPAddress` GeneralName in network byte order.|[RFC 5280, Section 4.2.1.6](https://tools.ietf.org/html/rfc5280#section-4.2.1.6)|
|extendedKeyUsage|Yes|No|`id-kp-serverAuth` MUST be present.<br>`ip-kp-clientAuth` and/or `ip-kp-emailProtection` MAY be present.<br>Other values SHOULD NOT be present.<br>`anyExtendedKeyUsage` MUST NOT be present.|[RFC 5280, Section 4.2.1.12](https://tools.ietf.org/html/rfc5280#section-4.2.1.12)|
|authorityInfoAccess|Yes|No|MUST contain at least one `accessMethod` value of type `id-ad-ocsp` that specifies the HTTP URI of the issuing CA's OCSP responder. Additional `id-ad-ocsp` LDAP, FTP, or HTTP URIs MAY be specified.<br>SHOULD contain at least one `accessMethod` value of type `id-ad-caIssuers` that specifies the HTTP URI of the issuing CA's Certificate. Additional `id-ad-caIssuers` LDAP, FTP, or HTTP URIs MAY be specified.|[RFC 5280, Section 4.2.2.1](https://tools.ietf.org/html/rfc5280#section-4.2.2.1)|
|subjectKeyIdentifer|No, but SHOULD be included|No|A string that identifies the Public Key encoded in the Certificate's `subjectPublicKeyInfo`.|[RFC 5280, Section 4.2.1.2](https://tools.ietf.org/html/rfc5280#section-4.2.1.2)|
|keyUsage|No|Yes|The `digitalSignature` bit MUST be asserted.<br>If the `subjectPublicKeyInfo` encoded in the Certificate is of type `rsaEncryption`, then the following bits MAY also be asserted:<ul><li>`nonRepudiation`</li><li>`keyEncipherment`</li><li>`dataEncipherment`</li></ul>If the `subjectPublicKeyInfo` encoded in the Certificate is of type `id-ecPublicKey`, then the following bits MAY also be asserted:<ul><li>`nonRepudiation`</li><li>`keyAgreement`</li></ul>Other bits MUST NOT be asserted.|[RFC 5280, Section 4.2.1.3](https://tools.ietf.org/html/rfc5280#section-4.2.1.3)<br>[RFC 8446, Section 4.4.2.2](https://tools.ietf.org/html/rfc8446#section-4.4.2.2)<br>[RFC 3279, Section 2.3.1](https://tools.ietf.org/html/rfc3279#section-2.3.1)<br>[RFC 5480, Section 3](https://tools.ietf.org/html/rfc5480#section-3) as updated by [RFC 8813, Section 3](https://tools.ietf.org/html/rfc8813#section-3)|
|basicConstraints|No|Yes|The `cA` field MUST be false.|[RFC 5280, Section 4.2.1.9](https://tools.ietf.org/html/rfc5280#section-4.2.1.9)|
|crlDistributionPoints|No|No|MUST contain at least one `distributionPoint` whose `fullName` value includes a GeneralName of type `URI` that includes a HTTP URI where the issuing CA's CRL can be retrieved.<br>Additional `fullName` LDAP, FTP, or HTTP URIs MAY be specified.|[RFC 5280, Section 4.2.1.13](https://tools.ietf.org/html/rfc5280#section-4.2.1.13)|
|Other extensions|No|N/A||Section 7.1.2.4|


### 7.1.4.3 Subject Distinguished Name - Subscriber Certificates

...

### 7.1.4.3.1 Individual Validation Certificates

|Attribute Type|OID|Required?|ASN.1 Type and Constraints|Permitted Values|References|
|---|---|---------|--------------------------|----------------|----------|
|commonName|2.5.4.3|No: discouraged, but not prohibited|`DirectoryString`<br>1-64 characters|A single `iPAddress` or `dNSName` from the `subjectAltName` extension as defined in Section 7.1.2.3.|[RFC 5280, Appendix A.1](https://tools.ietf.org/html/rfc5280#appendix-A.1)|
|organizationName|2.5.4.10|Yes if `givenName` and `surname` are not present; optional otherwise|`DirectoryString`<br>1-64 characters|The natural person Subject's name or DBA as verified under Section 3.2.2.2.|[RFC 5280, Appendix A.1](https://tools.ietf.org/html/rfc5280#appendix-A.1)|
|givenName|2.5.4.42|Yes if `surname` is present and/or `organizationName` is absent; prohibited otherwise|`DirectoryString`<br>1-64 characters|The natural person Subject's given name as verified under Section 3.2.3.|X.520 (2005), Section 5.2.4|
|surname|2.5.4.4|Yes if `givenName` is present and/or `organizationName` is absent; prohibited otherwise|`DirectoryString`<br>1-64 characters|The natural person Subject's surname as verified under Section 3.2.3.|X.520 (2005), Section 5.2.3|
|countryName|2.5.4.6|Yes|`PrintableString`<br>2 characters|The two-letter ISO 3166-1 country code associated with the location of the Subject verified under Section 3.2.2.1. If the Country is not represented by an official ISO 3166-1 country code, the CA MUST specify the ISO 3166-1 user-assigned code of `XX` indicating that an official ISO 3166-1 alpha-2 code has not been assigned.|[RFC 5280, Appendix A.1](https://tools.ietf.org/html/rfc5280#appendix-A.1)|
|stateOrProvinceName|2.5.4.8|Yes if `localityName` is absent; optional otherwise|`DirectoryString`<br>1-128 characters|The Subject’s state or province information as verified under Section 3.2.2.1. If `countryName` specifies the value `XX`, then the full name of the Subject’s country information as verified under Section 3.2.2.1 MAY be specified.|[RFC 5280, Appendix A.1](https://tools.ietf.org/html/rfc5280#appendix-A.1)|
|localityName|2.5.4.7|Yes if `stateOrProvinceName` is absent; optional otherwise|`DirectoryString`<br>1-128 characters|The Subject’s locality information as verified under Section 3.2.2.1. If `countryName` specifies the value `XX`, then the full name of the Subject’s locality and/or state or province information as verified under Section 3.2.2.1 MAY be specified.|[RFC 5280, Appendix A.1](https://tools.ietf.org/html/rfc5280#appendix-A.1)|
|streetAddress|2.5.4.9|No|`DirectoryString`<br>1-128 characters|The Subject’s street address information as verified under Section 3.2.2.1.|X.520 (2005), Section 5.3.4|
|postalCode|2.5.4.17|No|`DirectoryString`<br>1-40 characters|The Subject’s ZIP or postal code information as verified under Section 3.2.2.1.|X.520 (2005), Section 5.6.2|
|organizationalUnitName|2.5.4.11|No|`DirectoryString`<br>1-64 characters|A value.|X.520 (2005), Section 5.4.2|
|Other|N/A|No|N/A|MUST contain information that has been verified by the CA.|N/A|
