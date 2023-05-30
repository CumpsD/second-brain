# Configure Linux NTP

## Update

```bash
$ vi /etc/systemd/timesyncd.conf
[Time]
NTP=10.0.100.100
FallbackNTP=10.0.100.101

$ timedatectl set-ntp true
$ systemctl restart systemd-timesyncd.service
```

## Check

```bash
$ timedatectl status
               Local time: Tue 2023-05-30 21:04:09 UTC
           Universal time: Tue 2023-05-30 21:04:09 UTC
                 RTC time: Tue 2023-05-30 21:04:09
                Time zone: Etc/UTC (UTC, +0000)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no

$ systemctl status systemd-timesyncd.service
● systemd-timesyncd.service - Network Time Synchronization
     Loaded: loaded (/lib/systemd/system/systemd-timesyncd.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2023-05-30 21:05:28 UTC; 4s ago
       Docs: man:systemd-timesyncd.service(8)
   Main PID: 1036959 (systemd-timesyn)
     Status: "Initial synchronization to time server 10.0.100.100:123 (10.0.100.100)."
      Tasks: 2 (limit: 154409)
     Memory: 1.3M
        CPU: 1.231s
     CGroup: /system.slice/systemd-timesyncd.service
             └─1036959 /lib/systemd/systemd-timesyncd

May 30 21:05:27 docky systemd[1]: Starting Network Time Synchronization...
May 30 21:05:28 docky systemd[1]: Started Network Time Synchronization.
May 30 21:05:28 docky systemd-timesyncd[1036959]: Initial synchronization to time server 10.0.100.100:123 (10.0.100.100).

$ timedatectl timesync-status
       Server: 10.0.100.100 (10.0.100.100)
Poll interval: 8min 32s (min: 32s; max 34min 8s)
         Leap: normal
      Version: 4
      Stratum: 1
    Reference: GPS
    Precision: 1us (-25)
Root distance: 0 (max: 5s)
       Offset: -45us
        Delay: 140us
       Jitter: 33us
 Packet count: 4
    Frequency: +7.458ppm
```
