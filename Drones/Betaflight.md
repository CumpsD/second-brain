# Betaflight

## GitHub

* https://github.com/betaflight/betaflight
* https://github.com/betaflight/betaflight-configurator

## Useful CLI Commands

* `version`
* `bind_rx`
* `set frsky_x_rx_num`

## Protocol Information

* FRSKY_D = D8
* FRSKY_X = D16

## Useful Info

* [Betaflight 4.2 YouTube Series](https://www.youtube.com/playlist?list=PLwoDb7WF6c8k_Bpx8QsRHX1mcFjN5lGuw)
  * #1 [Five ways Betaflight 4.2 will surprise you!](https://www.youtube.com/watch?v=nALPi8cTXGY&list=PLwoDb7WF6c8k_Bpx8QsRHX1mcFjN5lGuw&index=1) \
    Try to use Actual Rates

## Binding via CLI

> Use this if forced to bind in D16 (i.e. newer ACCESS-based FrSky radios, but with ACCST16 firmware update). \
> \
> First, change the receiver protocol in the Configurations tab of Betaflight to SPI-based receiver, Frsky_X protocol (which is for D16; the default is Frsky_D for D8). \
> \
> Next, try using CLI commands to bind. Enter into the CLI, "`bind_rx`" (for 4.1.x firmware) or "`bind_rx_spi`" (for 4.0.x firmware) to get into binding mode. \
> \
> Activate the bind function in the transmitter in D16 protocol. The drone's LED's may not change back to blinking, but continue. \
> \
> Then enter into the CLI, "`set frsky_x_rx_num`". If the rx/receiver number changed to the number that matches the receiver number shown on your transmitter, then the bind was successful. \
> \
> Finally, enter into the CLI, "`save`". Upon the next reboot the SPI receiver should connect with your transmitter.

## Betaflight Versions

From [Emax - Betaflight Configurator - Use Correct Version](https://emaxmodel.freshdesk.com/support/solutions/articles/63000082816-betaflight-configurator-use-correct-version):

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
>
> Use Betaflight Configurator 10.7.0 for firmware versions 4.2.x \
> https://github.com/betaflight/betaflight-configurator/releases/tag/10.7.0

## Multiple installations in Linux

Extract each Betaflight Configurator in it's own folder, e.g.: `betaflight/betaflight-configurator-10.6.0`

```bash
$ cat drones/betaflight/betaflight-configurator-10.6.0.sh
#!/usr/bin/env bash
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

## Betaflight OSD

```text
set osd_units = METRIC
set osd_warn_arming_disable = ON
set osd_warn_batt_not_full = ON
set osd_warn_batt_warning = ON
set osd_warn_batt_critical = ON
set osd_warn_visual_beeper = ON
set osd_warn_crash_flip = ON
set osd_warn_esc_fail = ON
set osd_warn_core_temp = ON
set osd_warn_rc_smoothing = ON
set osd_warn_fail_safe = ON
set osd_warn_launch_control = ON
set osd_warn_no_gps_rescue = ON
set osd_warn_gps_rescue_disabled = ON
set osd_warn_rssi = OFF
set osd_warn_link_quality = OFF
set osd_warn_over_cap = OFF
set osd_rssi_alarm = 20
set osd_link_quality_alarm = 80
set osd_rssi_dbm_alarm = -60
set osd_cap_alarm = 2200
set osd_alt_alarm = 100
set osd_distance_alarm = 0
set osd_esc_temp_alarm = -128
set osd_esc_rpm_alarm = -1
set osd_esc_current_alarm = -1
set osd_core_temp_alarm = 70
set osd_ah_max_pit = 20
set osd_ah_max_rol = 40
set osd_ah_invert = OFF
set osd_logo_on_arming = OFF
set osd_logo_on_arming_duration = 5
set osd_tim1 = 2560
set osd_tim2 = 2561
set osd_vbat_pos = 257
set osd_rssi_pos = 2486
set osd_link_quality_pos = 234
set osd_rssi_dbm_pos = 161
set osd_tim_1_pos = 353
set osd_tim_2_pos = 321
set osd_remaining_time_estimate_pos = 234
set osd_flymode_pos = 2241
set osd_anti_gravity_pos = 234
set osd_g_force_pos = 234
set osd_throttle_pos = 313
set osd_vtx_channel_pos = 193
set osd_crosshairs_pos = 205
set osd_ah_sbar_pos = 206
set osd_ah_pos = 78
set osd_current_pos = 234
set osd_mah_drawn_pos = 234
set osd_motor_diag_pos = 234
set osd_craft_name_pos = 33
set osd_display_name_pos = 234
set osd_gps_speed_pos = 2209
set osd_gps_lon_pos = 2081
set osd_gps_lat_pos = 2049
set osd_gps_sats_pos = 2113
set osd_home_dir_pos = 2275
set osd_home_dist_pos = 2145
set osd_flight_dist_pos = 184
set osd_compass_bar_pos = 234
set osd_altitude_pos = 2177
set osd_pid_roll_pos = 234
set osd_pid_pitch_pos = 234
set osd_pid_yaw_pos = 234
set osd_debug_pos = 234
set osd_power_pos = 234
set osd_pidrate_profile_pos = 234
set osd_warnings_pos = 2441
set osd_avg_cell_voltage_pos = 2516
set osd_pit_ang_pos = 234
set osd_rol_ang_pos = 234
set osd_battery_usage_pos = 234
set osd_disarmed_pos = 2411
set osd_nheading_pos = 234
set osd_nvario_pos = 234
set osd_esc_tmp_pos = 234
set osd_esc_rpm_pos = 234
set osd_esc_rpm_freq_pos = 234
set osd_rtc_date_time_pos = 234
set osd_adjustment_range_pos = 234
set osd_flip_arrow_pos = 65
set osd_core_temp_pos = 248
set osd_log_status_pos = 97
set osd_stick_overlay_left_pos = 234
set osd_stick_overlay_right_pos = 234
set osd_stick_overlay_radio_mode = 2
set osd_rate_profile_name_pos = 234
set osd_pid_profile_name_pos = 234
set osd_profile_name_pos = 234
set osd_rcchannels_pos = 234
set osd_camera_frame_pos = 35
set osd_efficiency_pos = 234
set osd_stat_rtc_date_time = OFF
set osd_stat_tim_1 = OFF
set osd_stat_tim_2 = ON
set osd_stat_max_spd = ON
set osd_stat_max_dist = OFF
set osd_stat_min_batt = ON
set osd_stat_endbatt = OFF
set osd_stat_battery = OFF
set osd_stat_min_rssi = ON
set osd_stat_max_curr = ON
set osd_stat_used_mah = ON
set osd_stat_max_alt = OFF
set osd_stat_bbox = ON
set osd_stat_bb_no = ON
set osd_stat_max_g_force = OFF
set osd_stat_max_esc_temp = OFF
set osd_stat_max_esc_rpm = OFF
set osd_stat_min_link_quality = OFF
set osd_stat_flight_dist = OFF
set osd_stat_max_fft = OFF
set osd_stat_total_flights = OFF
set osd_stat_total_time = OFF
set osd_stat_total_dist = OFF
set osd_stat_min_rssi_dbm = OFF
set osd_profile = 1
set osd_profile_1_name = -
set osd_profile_2_name = -
set osd_profile_3_name = -
set osd_gps_sats_show_hdop = OFF
set osd_displayport_device = AUTO
set osd_rcchannels = -1,-1,-1,-1
set osd_camera_frame_width = 24
set osd_camera_frame_height = 11
```
