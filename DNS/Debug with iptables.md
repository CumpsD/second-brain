# Debug with iptables

```bash
iptables -t nat -A PREROUTING -p udp --dport 53 -j LOG --log-prefix "DNS Request: "
iptables -t nat -D PREROUTING -p udp --dport 53 -j LOG --log-prefix "DNS Request: "
cat /var/log/messages
```
