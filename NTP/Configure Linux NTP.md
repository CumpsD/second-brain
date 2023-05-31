# Configure Linux NTP

## SystemD

### Update

```bash
$ vi /etc/systemd/timesyncd.conf
[Time]
NTP=10.0.100.100
FallbackNTP=10.0.100.101

$ timedatectl set-ntp true
$ systemctl restart systemd-timesyncd.service
```

### Check

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

## NTPd

### Update

```bash
$ ntpq -p
     remote           refid      st t when poll reach   delay   offset  jitter
==============================================================================
 0.debian.pool.n .POOL.          16 p    -   64    0    0.000   +0.000   0.002
 1.debian.pool.n .POOL.          16 p    -   64    0    0.000   +0.000   0.002
 2.debian.pool.n .POOL.          16 p    -   64    0    0.000   +0.000   0.002
 3.debian.pool.n .POOL.          16 p    -   64    0    0.000   +0.000   0.002
-189.44-182-91.a .GPS.            1 u  155 1024  377    5.976   +0.560   1.796
*ntp2.belbone.be .GPS.            1 u  366 1024  377    2.936   -0.506   1.304
+45.87.78.35     .GPS.            1 u  428 1024  377    4.484   -0.024   1.042
+webserver.disco .GPS.            1 u   98 1024  377    4.508   +0.242   0.483
+dns-rec-2-brudi .GPS.            1 u   64 1024  377    6.510   -1.110   1.057
#ntp1.unix-solut .GPS.            1 u 1237 1024  376    8.936   +0.631   1.777
+ntp2.unix-solut .GPS.            1 u  153 1024  377    2.783   -0.572   1.006
+ntp1.telenet-op .GPS.            1 u  598 1024  377    6.201   -0.064   0.612
+time.cloudflare .GPS.            1 u  378 1024  377    3.114   -0.605   1.788
+45.87.77.15     .GPS.            1 u  517 1024  377    2.687   -0.529   1.867
-time.cloudflare .GPS.            1 u  385 1024  377    6.195   +1.204   1.155
#host-95-182-219 .GPS.            1 u  525 1024  377    6.705   +1.145   1.232

$ ntpd --version
ntpd 4.2.8p15@1.3728-o Wed Sep 23 11:46:38 UTC 2020 (1)

$ nano /etc/ntp.conf
server 10.0.100.100 iburst prefer
server 10.0.100.101 iburst

$ systemctl restart ntp.service

$ systemctl stop ntp.service

$ ntpd -gq
31 May 21:54:19 ntpd[9189]: ntpd 4.2.8p15@1.3728-o Wed Sep 23 11:46:38 UTC 2020 (1): Starting
31 May 21:54:19 ntpd[9189]: Command line: ntpd -gq
31 May 21:54:19 ntpd[9189]: ----------------------------------------------------
31 May 21:54:19 ntpd[9189]: ntp-4 is maintained by Network Time Foundation,
31 May 21:54:19 ntpd[9189]: Inc. (NTF), a non-profit 501(c)(3) public-benefit
31 May 21:54:19 ntpd[9189]: corporation.  Support and training for ntp-4 are
31 May 21:54:19 ntpd[9189]: available at https://www.nwtime.org/support
31 May 21:54:19 ntpd[9189]: ----------------------------------------------------
31 May 21:54:19 ntpd[9189]: proto: precision = 1.770 usec (-19)
31 May 21:54:19 ntpd[9189]: basedate set to 2020-09-11
31 May 21:54:19 ntpd[9189]: gps base set to 2020-09-13 (week 2123)
31 May 21:54:19 ntpd[9189]: switching logging to file /var/log/ntpd.log
31 May 21:54:19 ntpd[9189]: leapsecond file ('/usr/share/zoneinfo/leap-seconds.list'): good hash signature
31 May 21:54:19 ntpd[9189]: leapsecond file ('/usr/share/zoneinfo/leap-seconds.list'): loaded, expire=2023-06-28T00:00:00Z last=2017-01-01T00:00:00Z ofs=37
31 May 21:54:19 ntpd[9189]: leapsecond file ('/usr/share/zoneinfo/leap-seconds.list'): will expire in less than 28 days
31 May 21:54:19 ntpd[9189]: Listen and drop on 0 v6wildcard [::]:123
31 May 21:54:19 ntpd[9189]: Listen and drop on 1 v4wildcard 0.0.0.0:123
31 May 21:54:19 ntpd[9189]: Listen normally on 2 lo 127.0.0.1:123
31 May 21:54:19 ntpd[9189]: Listen normally on 3 wlan0 10.0.4.31:123
31 May 21:54:19 ntpd[9189]: Listen normally on 4 lo [::1]:123
31 May 21:54:19 ntpd[9189]: Listen normally on 5 wlan0 [fe80::e867:27fb:10b5:2487%3]:123
31 May 21:54:19 ntpd[9189]: Listening on routing socket on fd #22 for interface updates
31 May 21:54:26 ntpd[9189]: ntpd: time slew -0.001274 s
ntpd: time slew -0.001274s

$ systemctl start ntp.service
```

### Check

```bash
$ systemctl status ntp.service
● ntp.service - Network Time Service
     Loaded: loaded (/lib/systemd/system/ntp.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2023-05-31 21:55:04 CEST; 7s ago
       Docs: man:ntpd(8)
    Process: 9595 ExecStart=/usr/lib/ntp/ntp-systemd-wrapper (code=exited, status=0/SUCCESS)
   Main PID: 9601 (ntpd)
      Tasks: 2 (limit: 2057)
        CPU: 102ms
     CGroup: /system.slice/ntp.service
             └─9601 /usr/sbin/ntpd -p /var/run/ntpd.pid -g -c /etc/ntp.conf -u 111:115

May 31 21:55:03 piaware ntpd[9595]: ntp-4 is maintained by Network Time Foundation,
May 31 21:55:03 piaware ntpd[9595]: Inc. (NTF), a non-profit 501(c)(3) public-benefit
May 31 21:55:03 piaware ntpd[9595]: corporation.  Support and training for ntp-4 are
May 31 21:55:03 piaware ntpd[9595]: available at https://www.nwtime.org/support
May 31 21:55:03 piaware ntpd[9595]: ----------------------------------------------------
May 31 21:55:03 piaware ntpd[9601]: proto: precision = 1.771 usec (-19)
May 31 21:55:03 piaware ntpd[9601]: basedate set to 2020-09-11
May 31 21:55:03 piaware ntpd[9601]: gps base set to 2020-09-13 (week 2123)
May 31 21:55:03 piaware ntpd[9601]: switching logging to file /var/log/ntpd.log
May 31 21:55:04 piaware systemd[1]: Started Network Time Service.

$ ntpq -p
     remote           refid      st t when poll reach   delay   offset  jitter
==============================================================================
*leo             .GPS.            1 u   68   64  377    4.279   +0.509   1.151
+time-machine    .GPS.            1 u   63   64  377    2.646   +0.030   2.375
```
