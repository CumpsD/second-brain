# UDM-Pro Setup SSL

## New Unifi Version 

To setup SSL, copy your certificate into `/data/unifi-core/config/unifi-core.crt` and `/data/unifi-core/config/unifi-core.key` and restart.

```bash
Firmware version: v3.1.15

  ___ ___      .__________.__
 |   |   |____ |__\_  ____/__|
 |   |   /    \|  ||  __) |  |   (c) 2010-2023
 |   |  |   |  \  ||  \   |  |   Ubiquiti Inc.
 |______|___|  /__||__/   |__|
            |_/                  https://www.ui.com

      Welcome to UniFi Dream Machine Pro!

# cd /data/unifi-core/config/
# ls -al
total 68
drwxr-xr-x 2 root root 4096 Feb 18 16:51 ./
drwxr-xr-x 8 root root 4096 Jul 26 16:20 ../
-rw-r--r-- 1 root root  115 Jul  6 16:11 apps.availableUpdates.yaml
-rw-r--r-- 1 root root  170 Feb 18 16:51 apps.userPrefs.yaml
-rw-r--r-- 1 root root  736 Aug 11 06:49 backup.yaml
-rw-r--r-- 1 root root 3326 Feb 18 16:51 cloud.yaml
-rw-r--r-- 1 root root 2411 Aug 11 19:14 firmware.yaml
-rw-r--r-- 1 root root  152 Feb 18 16:51 jwt.yaml
-rw-r--r-- 1 root root  736 Jul 26 16:20 settings.yaml
-rw-r--r-- 1 root root 5607 Jul 26 16:21 unifi-core-direct.crt
-rw-r--r-- 1 root root 1706 Feb 18 16:51 unifi-core-direct.key
-rw-r--r-- 1 root root 6327 Feb 18 16:51 unifi-core.crt
-rw-r--r-- 1 root root 1709 Feb 18 16:51 unifi-core.key
# cp unifi-core.crt unifi-core.crt.bak
# cp unifi-core.key unifi-core.key.bak
# vi unifi-core.crt
# vi unifi-core.key
# systemctl restart unifi-core
```

## Old Unifi Version

To setup SSL, copy your certificate into `/mnt/data/unifi-os/unifi-core/config/unifi-core.crt` and `/mnt/data/unifi-os/unifi-core/config/unifi-core.key` and restart.

```bash
  ___ ___      .__________.__
 |   |   |____ |__\_  ____/__|
 |   |   /    \|  ||  __) |  |   (c) 2010-2022
 |   |  |   |  \  ||  \   |  |   Ubiquiti Inc.
 |______|___|  /__||__/   |__|
            |_/                  http://www.ui.com

      Welcome to UniFi Dream Machine!

# cd /mnt/data/unifi-os/unifi-core/config/
# ls -al
total 56
drwxr-xr-x    2 root     root          4096 Feb 24 22:03 .
drwxr-xr-x    8 root     root          4096 Jul 11 17:38 ..
-rw-r--r--    1 root     root           115 Jul  9 20:26 apps.availableUpdates.yaml
-rw-r--r--    1 root     root           170 Mar 28  2021 apps.userPrefs.yaml
-rw-r--r--    1 root     root           200 Mar 28  2021 backup.yaml
-rw-r--r--    1 root     root          3326 Mar 28  2021 cloud.yaml
-rw-r--r--    1 root     root          2128 Jul 11 17:39 firmware.yaml
-rw-r--r--    1 root     root           152 Jun  2 09:11 jwt.yaml
-rw-r--r--    1 root     root           624 Jun  2 09:11 settings.yaml
-rw-r--r--    1 root     root          5688 May 23 11:03 unifi-core-direct.crt
-rw-r--r--    1 root     root          1706 Feb 24 22:01 unifi-core-direct.key
-rw-r--r--    1 root     root          1192 Mar 28  2021 unifi-core.crt
-rw-r--r--    1 root     root          1702 Mar 28  2021 unifi-core.key
# cp unifi-core.crt unifi-core.crt.bak
# cp unifi-core.key unifi-core.key.bak
# vi unifi-core.crt
# vi unifi-core.key
# unifi-os restart
```
