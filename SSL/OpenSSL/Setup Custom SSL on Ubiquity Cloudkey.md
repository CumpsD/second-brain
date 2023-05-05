# Setup Custom SSL on Ubiquity Cloudkey

## Upload certificate

```bash
vi wildcard.cumps.be.key
vi wildcard.cumps.be.crt
```

## Backup existing configuration

```bash
tar -zcvf cloudkey-2020-07-04.tgz /etc/ssl/private/*
cp /usr/lib/unifi/data/system.properties system.properties-2020-07-05
```

## Cleanup old configuration

```bash
rm -f   /etc/ssl/private/cert.tar                           \
        /etc/ssl/private/unifi.keystore.jks                 \
        /etc/ssl/private/unifi.keystore.jks.md5             \
        /etc/ssl/private/cloudkey.crt                       \
        /etc/ssl/private/cloudkey.key
```

## Create new configuration

```bash
# Unpack certificates
openssl pkcs12 -export -out unifi.p12 -inkey wildcard.cumps.be.key -in wildcard.cumps.be.crt
openssl pkcs12 -in unifi.p12 -nodes -out /etc/ssl/private/cloudkey.key -nocerts
cp wildcard.cumps.be.crt /etc/ssl/private/cloudkey.crt

# Decrypt keys and convert certificates to plain text
# Note, aircontrolenterprise is not arbitrary. this is what UniFi is expecting
openssl pkcs12 -export -in /etc/ssl/private/cloudkey.crt    \
                    -inkey /etc/ssl/private/cloudkey.key    \
                      -out /etc/ssl/private/cloudkey.p12    \
                      -name unifi -password pass:aircontrolenterprise

# Import keys into Java Key Store
keytool -importkeystore -deststorepass aircontrolenterprise \
            -destkeypass aircontrolenterprise               \
            -destkeystore /usr/lib/unifi/data/keystore      \
            -srckeystore /etc/ssl/private/cloudkey.p12      \
            -srcstoretype PKCS12 -srcstorepass aircontrolenterprise -alias unifi -noprompt

# Cleanup
rm -f /etc/ssl/private/cloudkey.p12
rm -f unifi.p12
```

## Install the new keystore and certificates

```bash
# Append password to configuration
echo "app.keystore.pass=aircontrolenterprise" >> /usr/lib/unifi/data/system.properties

pushd /etc/ssl/private

# Create tar file cloudkey expects
tar -cvf cert.tar *

# set permissions
chown root:ssl-cert /etc/ssl/private/*
chmod 640           /etc/ssl/private/*

popd

# Test
/usr/sbin/nginx -t
```

## Restart controller

```bash
# Restart nginx and UniFi Controller
/etc/init.d/nginx restart
/etc/init.d/unifi restart
```
