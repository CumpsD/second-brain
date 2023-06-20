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
