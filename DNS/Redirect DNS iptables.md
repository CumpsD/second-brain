# Redirect NTP iptables

## Setup

```bash
aqirule="PREROUTING -s 10.0.4.59 -j ACCEPT"
iptables -t nat -C ${aqirule} || iptables -t nat -A ${aqirule}

tcprule="PREROUTING ! -s 10.0.3.9 -p tcp --dport 53 -j DNAT --to 10.0.50.50"
iptables -t nat -C ${tcprule} || iptables -t nat -A ${tcprule}

udprule="PREROUTING ! -s 10.0.3.9 -p udp --dport 53 -j DNAT --to 10.0.50.50"
iptables -t nat -C ${udprule} || iptables -t nat -A ${udprule}

masqtcprule="POSTROUTING -s 10.0.0.0/8 -p tcp --dport 53 -j MASQUERADE"
masqudprule="POSTROUTING -s 10.0.0.0/8 -p udp --dport 53 -j MASQUERADE"
iptables -t nat -C ${masqtcprule} || iptables -t nat -A ${masqtcprule}
iptables -t nat -C ${masqudprule} || iptables -t nat -A ${masqudprule}

iptables -t nat -L -n --line-number
```

## Remove

```bash
iptables -t nat -D PREROUTING -s 10.0.4.59 -j ACCEPT
iptables -t nat -D PREROUTING ! -s 10.0.3.9 -p tcp --dport 53 -j DNAT --to 10.0.50.50
iptables -t nat -D PREROUTING ! -s 10.0.3.9 -p udp --dport 53 -j DNAT --to 10.0.50.50
iptables -t nat -D POSTROUTING -s 10.0.0.0/8 -p tcp --dport 53 -j MASQUERADE
iptables -t nat -D POSTROUTING -s 10.0.0.0/8 -p udp --dport 53 -j MASQUERADE
iptables -t nat -L -n --line-number
```

## Persist on Reboot UDM

```bash
cd /data/on_boot.d/
touch 10-iptables-dns.sh
chmod +x 10-iptables-dns.sh
vi 10-iptables-dns.sh
```

Add the following script:

```bash
#!/bin/sh
aqirule="PREROUTING -s 10.0.4.59 -j ACCEPT"
iptables -t nat -C ${aqirule} || iptables -t nat -A ${aqirule}

tcprule="PREROUTING ! -s 10.0.3.9 -p tcp --dport 53 -j DNAT --to 10.0.50.50"
iptables -t nat -C ${tcprule} || iptables -t nat -A ${tcprule}

udprule="PREROUTING ! -s 10.0.3.9 -p udp --dport 53 -j DNAT --to 10.0.50.50"
iptables -t nat -C ${udprule} || iptables -t nat -A ${udprule}

masqtcprule="POSTROUTING -s 10.0.0.0/8 -p tcp --dport 53 -j MASQUERADE"
masqudprule="POSTROUTING -s 10.0.0.0/8 -p udp --dport 53 -j MASQUERADE"
iptables -t nat -C ${masqtcprule} || iptables -t nat -A ${masqtcprule}
iptables -t nat -C ${masqudprule} || iptables -t nat -A ${masqudprule}
```
