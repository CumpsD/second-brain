# Redirect NTP iptables

## Setup

```bash
tcprule1="PREROUTING ! -s 10.0.100.101 -p tcp --dport 123 -j DNAT --to 10.0.100.101"
iptables -t nat -C ${tcprule1} || iptables -t nat -A ${tcprule1}

udprule1="PREROUTING ! -s 10.0.100.101 -p udp --dport 123 -j DNAT --to 10.0.100.101"
iptables -t nat -C ${udprule1} || iptables -t nat -A ${udprule1}

masqrule="POSTROUTING -s 10.0.0.0/8 -j MASQUERADE"
iptables -t nat -C ${masqrule} || iptables -t nat -A ${masqrule}

iptables -t nat -L
```

## Remove

```bash
iptables -t nat -D PREROUTING ! -s 10.0.100.101 -p tcp --dport 123 -j DNAT --to 10.0.100.101
iptables -t nat -D PREROUTING ! -s 10.0.100.101 -p udp --dport 123 -j DNAT --to 10.0.100.101
iptables -t nat -D POSTROUTING -s 10.0.0.0/8 -j MASQUERADE
iptables -t nat -L
```

## Persist on Reboot UDM

```bash
cd /data/on_boot.d/
touch 10-iptables.sh
chmod +x 10-iptables.sh
vi 10-iptables.sh
```

Add the following script:

```bash
#!/bin/sh
tcprule="PREROUTING ! -s 10.0.100.101 -p tcp --dport 123 -j DNAT --to 10.0.100.101"
iptables -t nat -C ${tcprule} || iptables -t nat -A ${tcprule}

udprule="PREROUTING ! -s 10.0.100.101 -p udp --dport 123 -j DNAT --to 10.0.100.101"
iptables -t nat -C ${udprule} || iptables -t nat -A ${udprule}

masqrule="POSTROUTING -s 10.0.0.0/8 -j MASQUERADE"
iptables -t nat -C ${masqrule} || iptables -t nat -A ${masqrule}
```
