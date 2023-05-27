# Persist Changes on Boot

## Install

### Automatically

```bash
curl -fsL "https://raw.githubusercontent.com/unifi-utilities/unifios-utilities/main/on-boot-script-2.x/remote_install.sh" | /bin/sh

  _   _ ___  __  __   ___           _
 | | | |   \|  \/  | | _ ) ___  ___| |_
 | |_| | |) | |\/| | | _ \/ _ \/ _ \  _|
  \___/|___/|_|  |_| |___/\___/\___/\__|

 Execute any script when your udm system
 starts.

UniFi Dream Machine Pro version 3.0.20 was detected
Installing on-boot script...
Failed to disable unit: Unit file udm-boot.service does not exist.
Creating systemctl service file
Enabling UDM boot...
Created symlink /etc/systemd/system/multi-user.target.wants/udm-boot.service → /etc/systemd/system/udm-boot.service.
UDM Boot Script installed

Downloading CNI plugins script...
CNI plugins script installed
Executing CNI plugins script...
Downloading https://github.com/containernetworking/plugins/releases/download/v1.3.0/cni-plugins-linux-arm64-v1.3.0.tgz.sha256
Downloading https://github.com/containernetworking/plugins/releases/download/v1.3.0/cni-plugins-linux-arm64-v1.3.0.tgz
Pouring /data/.cache/cni-plugins/cni-plugins-linux-arm64-v1.3.0.tgz

Downloading CNI bridge script...
CNI bridge script installed
Executing CNI bridge script...
/data/on_boot.d/06-cni-bridge.sh

On boot script installation finished

You can now place your scripts in `/data/on_boot.d`
```

### Manual

```bash
unifi-os shell
curl -L https://github.com/unifi-utilities/unifios-utilities/raw/main/on-boot-script-2.x/packages/udm-boot-2x_1.0.1_all.deb -o udm-boot-2x_1.0.1_all.deb
dpkg -i udm-boot-2x_1.0.1_all.deb
systemctl enable udm-boot
exit
```
