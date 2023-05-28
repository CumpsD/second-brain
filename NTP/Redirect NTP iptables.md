# Redirect NTP iptables

## Setup

```bash
tcprule="PREROUTING ! -s 10.0.100.101 -p tcp --dport 123 -j DNAT --to 10.0.100.101"
iptables -t nat -C ${tcprule} || iptables -t nat -A ${tcprule}

udprule="PREROUTING ! -s 10.0.100.101 -p udp --dport 123 -j DNAT --to 10.0.100.101"
iptables -t nat -C ${udprule} || iptables -t nat -A ${udprule}

masqtcprule="POSTROUTING -s 10.0.0.0/8 -p tcp --dport 123 -j MASQUERADE"
masqudprule="POSTROUTING -s 10.0.0.0/8 -p udp --dport 123 -j MASQUERADE"
iptables -t nat -C ${masqtcprule} || iptables -t nat -A ${masqtcprule}
iptables -t nat -C ${masqudprule} || iptables -t nat -A ${masqudprule}

iptables -t nat -L -n --line-number
```

## Remove

```bash
iptables -t nat -D PREROUTING ! -s 10.0.100.101 -p tcp --dport 123 -j DNAT --to 10.0.100.101
iptables -t nat -D PREROUTING ! -s 10.0.100.101 -p udp --dport 123 -j DNAT --to 10.0.100.101
iptables -t nat -D POSTROUTING -s 10.0.0.0/8 -p tcp --dport 123 -j MASQUERADE
iptables -t nat -D POSTROUTING -s 10.0.0.0/8 -p udp --dport 123 -j MASQUERADE
iptables -t nat -L -n --line-number
```

## Persist on Reboot UDM

```bash
cd /data/on_boot.d/
touch 10-iptables-ntp.sh
chmod +x 10-iptables-ntp.sh
vi 10-iptables-ntp.sh
```

Add the following script:

```bash
#!/bin/sh
tcprule="PREROUTING ! -s 10.0.100.101 -p tcp --dport 123 -j DNAT --to 10.0.100.101"
iptables -t nat -C ${tcprule} || iptables -t nat -A ${tcprule}

udprule="PREROUTING ! -s 10.0.100.101 -p udp --dport 123 -j DNAT --to 10.0.100.101"
iptables -t nat -C ${udprule} || iptables -t nat -A ${udprule}

masqtcprule="POSTROUTING -s 10.0.0.0/8 -p tcp --dport 123 -j MASQUERADE"
masqudprule="POSTROUTING -s 10.0.0.0/8 -p udp --dport 123 -j MASQUERADE"
iptables -t nat -C ${masqtcprule} || iptables -t nat -A ${masqtcprule}
iptables -t nat -C ${masqudprule} || iptables -t nat -A ${masqudprule}
```
