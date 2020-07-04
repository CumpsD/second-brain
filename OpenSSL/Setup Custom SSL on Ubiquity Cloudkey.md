# Setup Custom SSL on Ubiquity Cloudkey

## Upload certificate

```bash
vi wildcard.cumps.be.key
vi wildcard.cumps.be.crt
```

## Backup existing keystore

```bash
cp /usr/lib/unifi/data/keystore keystore-2020-07-05
```

## Create a new keystore

```bash
openssl pkcs12 -export -inkey wildcard.cumps.be.key -in wildcard.cumps.be.crt -out wildcard.cumps.be.p12 -name unifi -password pass:temppass
keytool -importkeystore -deststorepass aircontrolenterprise -destkeypass aircontrolenterprise -destkeystore /usr/lib/unifi/data/keystore -srckeystore wildcard.cumps.be.p12 -srcstoretype PKCS12 -srcstorepass temppass -alias unifi -noprompt
keytool -importkeystore -deststorepass aircontrolenterprise -destkeypass aircontrolenterprise -destkeystore /usr/lib/unifi/data/keystore.jks -srckeystore wildcard.cumps.be.p12 -srcstoretype PKCS12 -srcstorepass temppass -alias unifi -noprompt -deststoretype pkcs12
```

## Restart controller

```bash
reboot
```
