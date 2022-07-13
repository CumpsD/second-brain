# Enable HTTPS PiAware

We need to configure lighttpd to support SSL:

```bash
nano /etc/lighttpd/conf-enabled/99-ssl.conf
```

Add:

```text
# Listen on 443 for SSL connections
server.modules += ( "mod_openssl" )
$SERVER["socket"] == ":443" {
  ssl.engine = "enable"
  ssl.privkey = "/home/pi/cumps.key"
  ssl.pemfile = "/home/pi/cumps.crt"
  ssl.use-sslv2 = "disable"
  ssl.use-sslv3 = "disable"
  ssl.openssl.ssl-conf-cmd = ("Protocol" => "-ALL, TLSv1.2")
  ssl.honor-cipher-order = "enable"
  ssl.cipher-list = "EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH"
  ssl.use-compression = "disable"

  alias.url += (
    "/data/" => "/run/dump1090-fa/",
    "/status/status.json" => "/run/piaware/status.json",
    "/status/translations/lang.js" => "/var/www/html/translations/en.js",
    "/status/" => "/var/www/html/",
    "/" => "/usr/share/skyaware/html/"
  )
}

# Redirect HTTP to HTTPS
#$HTTP["scheme"] == "http" {
#  $HTTP["host"] =~ ".*" {
#    url.redirect = (".*" => "https://%0$0")
#  }
#}
```

And restart:

```bash
service lighttpd restart
```
