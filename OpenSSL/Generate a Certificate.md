# Generate a Certificate

## example.conf

```
[req]
default_bits       = 2048
default_md         = sha256
default_keyfile    = example.key
prompt             = no
encrypt_key        = no

# This sets a mask for permitted string types. There are several options.
# utf8only: only UTF8Strings (PKIX recommendation after 2004).
#string_mask        = utf8only

distinguished_name = req_distinguished_name
attributes         = req_attributes

[req_distinguished_name]
countryName            = "BE"                       # C=
stateOrProvinceName    = "West-Vlaanderen"          # ST=
localityName           = "Varsenare"                # L=
postalCode             = "8490"                     # L/postalcode=
streetAddress          = "Example Street 42"        # L/street=
organizationName       = "exira.com"                # O=
organizationalUnitName = "exira.com"                # OU=
commonName             = "*.example.com"            # CN=
emailAddress           = "ssl@exira.com"            # CN/emailAddress=

[req_attributes]
unstructuredName = "exira.com"
```

## Generate CSR + Private Key

```bash
rm example.{csr,key}
openssl req -config example.conf -new -out example.csr
openssl req -text -noout -verify -in example.csr
openssl rsa -in example.key -check
```

## Self-sign a development certificate

```bash
openssl x509 -req -days 365 -in example.csr -signkey example.key -out example.crt
```

## Convert a DER file (.crt .cer .der) to PEM

```bash
openssl x509 -inform der -in example.der -out example.crt
```

## Inspect certificate

```bash
openssl x509 -in example.crt -text -noout
```

## Convert a PEM certificate file and a private key to PKCS#12 (.pfx .p12)

```bash
openssl pkcs12 -export -out example.pfx -inkey example.key -in example.crt
```

## Convert a PEM certificate file and a private key to PKCS#12 (.pfx .p12) for Windows 2012

```bash
pkcs12 -export -certpbe PBE-SHA1-3DES -keypbe PBE-SHA1-3DES -nomac -out example.pfx -inkey example.key -in example.crt
```
