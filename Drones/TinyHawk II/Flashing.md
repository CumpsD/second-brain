# Flashing

## Factory

```
# version
# Betaflight / STM32F411 (S411) 4.1.0 Oct 16 2019 / 11:57:34 (c37a7c91a) MSP API: 1.42
# manufacturer_id: MTKS   board_name: MATEKF411RX   custom defaults: NO
```

## After flash

```
# version
# Betaflight / STM32F411 (S411) 4.2.6 Jan  5 2021 / 19:07:43 (a4b6db1e7) MSP API: 1.43
# config: manufacturer_id: MTKS, board_name: MATEKF411RX, version: ee671311, date: 2019-10-16T11:49:37Z
# board: manufacturer_id: MTKS, board_name: MATEKF411RX
```

> The following problems with your configuration were detected: \
> \
> **there is no motor output protocol selected.** \
> Please select a motor output protocol appropriate for your ESCs in 'ESC/Motor Features' on the 'Configuration' tab. \
> Caution: Selecting a motor output protocol that is not supported by your ESCs can lead to the ESCs spinning up as soon as a battery is connected. For this reason, always make sure to remove the props before connecting a battery for the first time after changing the motor output protocol. \
> \
> **the accelerometer is enabled but it is not calibrated.** \
> If you plan to use the accelerometer, please follow the instructions for 'Calibrate Accelerometer' on the 'Setup' tab. If any function that requires the accelerometer (auto level modes, GPS rescue, ...) is enabled, arming of the craft will be disabled until the accelerometer has been calibrated. \
> \
> Please fix these problems before attempting to fly your craft.
