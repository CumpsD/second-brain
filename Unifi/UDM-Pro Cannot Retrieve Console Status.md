# UDM-Pro Cannot Retrieve Console Status

## Problem

The UDM-Pro is suddenly not reachable from the browser anymore. After manually restarting it, it shows the error `Cannot Retrieve Console Status` on the device.

![a](https://github.com/CumpsD/second-brain/raw/main/assets/unifi/console-status.png "a")

## Solution

SSH into the UDM-Pro and run `unifi-os restart`

```
  ___ ___      .__________.__
 |   |   |____ |__\_  ____/__|
 |   |   /    \|  ||  __) |  |   (c) 2010-2022
 |   |  |   |  \  ||  \   |  |   Ubiquiti Inc.
 |______|___|  /__||__/   |__|
            |_/                  http://www.ui.com

      Welcome to UniFi Dream Machine!

# unifi-os restart
unifi-os: Stopping unifi-os
unifi-os: Stopping unifi-os unifi-core.service
unifi-os: Stopping unifi-os unifi-protect.service
unifi-os: Stopping unifi-os unifi.service
unifi-os: Stopping unifi-os unifi-talk.service
unifi-os: Stopping unifi-os postgresql.service
unifi-os: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
unifi-os: Stopping unifi-os SSH daemon... OK
unifi-os: Starting unifi-os
unifi-os: Stopping unifi-os SSH daemon... OK
unifi-os: Starting unifi-os SSH daemon... OK
unifi-os: unifi-os
```
