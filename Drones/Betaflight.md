# Betaflight

## Useful CLI Commands

* `version`
* `bind_rx`
* `set frsky_x_rx_num`

## Protocol Information

* FRSKY_D = D8
* FRSKY_X = D16

## Binding via CLI

> Use this if forced to bind in D16 (i.e. newer ACCESS-based FrSky radios, but with ACCST16 firmware update). First, change the receiver protocol in the Configurations tab of Betaflight to SPI-based receiver, Frsky_X protocol (which is for D16; the default is Frsky_D for D8). Next, try using CLI commands to bind. Enter into the CLI, "bind_rx" (for 4.1.x firmware) or "bind_rx_spi" (for 4.0.x firmware) to get into binding mode. Activate the bind function in the transmitter in D16 protocol. The drone's LED's may not change back to blinking, but continue. Then enter into the CLI, "set frsky_x_rx_num". If the rx/receiver number changed to the number that matches the receiver number shown on your transmitter, then the bind was successful. Finally, enter into the CLI, "save". Upon the next reboot the SPI receiver should connect with your transmitter.

## Betaflight Versions

[Emax - Betaflight Configurator - Use Correct Version](https://emaxmodel.freshdesk.com/support/solutions/articles/63000082816-betaflight-configurator-use-correct-version):

> Each version of the Betaflight Configurator is configured to work with a certain subset of firmware for the flight controller. The Configurator's user interface (UI), options/settings/functions/features available via the UI, ranges, default settings/tuning, and the terminology/nomenclature (even for a feature/function that used to be the exact same function) changes between major releases/versions. There is no 100% backwards compatibility. As such, you MUST use the correct Configurator version for the firmware version on your drone. This simply a necessary evil when enjoying Betaflight's open source application and firmware.
>
> Use Betaflight Configurator 10.4.0 for firmware versions 3.x.x \
> https://github.com/betaflight/betaflight-configurator/releases/tag/10.4.0
>
> Use Betaflight Configurator 10.5.1 for firmware versions 4.0.x \
> https://github.com/betaflight/betaflight-configurator/releases/tag/10.5.1
>
> Use Betaflight Configurator 10.6.0 for firmware versions 4.1.x \
> https://github.com/betaflight/betaflight-configurator/releases/tag/10.6.0

## Multiple installations in Linux

Extract each Betaflight Configurator in it's own folder, e.g.: `betaflight/betaflight-configurator-10.6.0`

```bash
$ cat drones/betaflight/betaflight-configurator-10.6.0.sh
#!/usr/bin/
env bash
pushd betaflight-configurator-10.6.0
rm -rf ~/.cache/betaflight-configurator/
./betaflight-configurator --user-data-dir=.config/betaflight-configurator-10.6.0
```

## Dealing with USB in Linux

### Check if the flight controller is detected

```bash
$ lsusb
Bus 001 Device 013: ID 0483:5740 STMicroelectronics Virtual COM Port

$ usb-devices
T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=03 Dev#= 13 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=02(commc) Sub=02 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0483 ProdID=5740 Rev=02.00
S:  Manufacturer=Betaflight
S:  Product=Betaflight STM32F411
S:  SerialNumber=0x8000000
C:  #Ifs= 2 Cfg#= 1 Atr=c0 MxPwr=100mA
I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=02 Prot=01 Driver=cdc_acm
I:  If#=0x1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_acm

$ sudo dmesg
[112123.552315] usb 1-5: new full-speed USB device number 13 using xhci_hcd
[112123.702798] usb 1-5: New USB device found, idVendor=0483, idProduct=5740, bcdDevice= 2.00
[112123.702800] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[112123.702801] usb 1-5: Product: Betaflight STM32F411
[112123.702802] usb 1-5: Manufacturer: Betaflight
[112123.702803] usb 1-5: SerialNumber: 0x8000000
[112123.727169] cdc_acm 1-5:1.0: ttyACM0: USB ACM device
[112123.727381] usbcore: registered new interface driver cdc_acm
[112123.727381] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
```

### Add permissions

```bash
$ cat /etc/udev/rules.d/45-stdfu-permissions.rules
# DFU (Internal bootloader for STM32 MCUs
ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0664", GROUP="plugdev"
```

### Assign permissions

```bash
sudo usermod -a -G dialout cumpsd
```

