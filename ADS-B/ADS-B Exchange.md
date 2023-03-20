# ADS-B Exchange

## ADS-B/1090 Feeder Script

```bash
wget -O /tmp/axfeed.sh https://adsbexchange.com/feed.sh
sudo bash /tmp/axfeed.sh
```

## Stats

```bash
wget -O /tmp/axstats.sh https://adsbexchange.com/stats.sh
sudo bash /tmp/axstats.sh
```

## ADS-B Graphs

```bash
wget -O /tmp/axgraphs.sh https://raw.githubusercontent.com/wiedehopf/graphs1090/master/install.sh
sudo bash /tmp/axgraphs.sh
```

## Local Interface

```
sudo bash /usr/local/share/adsbexchange/git/install-or-update-interface.sh
```

## Display MLAT config

```bash
cat /etc/default/adsbexchange
```

## Restart

```bash
sudo systemctl restart adsbexchange-feed
sudo systemctl restart adsbexchange-mlat
sudo systemctl restart adsbexchange-stats
```

## Systemd Status

```bash
sudo systemctl status adsbexchange-mlat
sudo systemctl status adsbexchange-feed
sudo systemctl status adsbexchange-stats
```

## Show stats URL on console

```bash
adsbexchange-showurl
```

## Check

* https://adsbexchange.com/myip/
* https://map.adsbexchange.com/mlat-map/
* https://www.adsbexchange.com/api/feeders/?feed=xxx
* http://adsbx.org/sync
* http://10.0.4.31/adsbx
* http://10.0.4.31/graphs1090

## Uninstall

```bash
sudo bash /usr/local/share/adsbexchange/uninstall.sh
sudo bash /usr/local/share/adsbexchange-stats/uninstall.sh
```

## Profile

* Varsenare: https://www.adsbexchange.com/api/feeders/?feed=J02vHaIt_sRc
* Varsenare: https://globe.adsbexchange.com/?feed=J02vHaIt_sRc
