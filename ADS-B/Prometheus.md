# Prometheus

> Export ADS-B dump1090 data to Prometheus

* Repository: https://github.com/claws/dump1090-exporter

## `/etc/systemd/system/dump1090-exporter.service`

```
[Unit]
Description=Dump1090 Exporter
After=dump1090-fa.service

[Service]
Type=simple
User=pi
ExecStart=/home/pi/.local/bin/dump1090exporter --resource-path=/run/dump1090-fa/
Restart=on-failure

[Install]
WantedBy=default.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable dump1090-exporter.service
sudo systemctl start dump1090-exporter.service
curl http://127.0.0.1:9105/metrics
```

## `/etc/systemd/system/piaware-exporter.service`

```
[Unit]
Description=PiAware Exporter
After=dump1090-fa.service

[Service]
Type=simple
User=pi
ExecStart=python3 /home/pi/piaware-exporter/piaware_exporter/main.py --piaware_host 127.0.0.1 --piaware_port 8080 --expo_port 9101 --fetch_interval 15
Restart=on-failure

[Install]
WantedBy=default.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable piaware-exporter.service
sudo systemctl start piaware-exporter.service
curl http://127.0.0.1:9101/metrics
```
