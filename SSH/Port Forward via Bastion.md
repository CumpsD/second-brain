# Port Forward via Bastion

```bash
ssh -o ServerAliveInterval=60 \
    -L 9000:es.internaldomain.local:443 \
    -L 9001:db.internaldomain.local:1433 \
    -L 6379:cache.internaldomain.local:6379 \
    -L 10001:wms.internaldomain.local:1433 \
    root@bastion
```
