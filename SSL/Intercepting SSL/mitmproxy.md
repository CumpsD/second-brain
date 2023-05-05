# mitmproxy

> mitmproxy is a free and open source interactive HTTPS proxy.

* [Download mitmproxy 9.0.1](https://downloads.mitmproxy.org/9.0.1/mitmproxy-9.0.1-linux.tar.gz)

## Reverse Proxy

Replace `yourdomain` with your cert and `x.x.x.x` with the backend IP.

```bash
cat yourdomain.key yourdomain.crt > yourdomain.pem
./mitmproxy -p 3333 --certs *.yourdomain.be=yourdomain.pem --mode reverse:https://x.x.x.x:6001 --set keep_host_header --ssl-insecure --set block_global=false
```
