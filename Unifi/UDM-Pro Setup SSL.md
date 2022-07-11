# UDM-Pro Setup SSL

To setup SSL, copy your certificate into `/mnt/data/unifi-os/unifi-core/config/unifi-core.crt` and `/mnt/data/unifi-os/unifi-core/config/unifi-core.key` and restart.

```
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
