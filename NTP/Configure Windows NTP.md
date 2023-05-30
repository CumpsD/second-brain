# Configure Windows NTP

## Before Update

```bash
w32tm /query /configuration
[Configuration]
EventLogFlags: 2 (Local)
AnnounceFlags: 10 (Local)
TimeJumpAuditOffset: 28800 (Local)
MinPollInterval: 10 (Local)
MaxPollInterval: 15 (Local)
MaxNegPhaseCorrection: 54000 (Local)
MaxPosPhaseCorrection: 54000 (Local)
MaxAllowedPhaseOffset: 1 (Local)

FrequencyCorrectRate: 4 (Local)
PollAdjustFactor: 5 (Local)
LargePhaseOffset: 50000000 (Local)
SpikeWatchPeriod: 900 (Local)
LocalClockDispersion: 10 (Local)
HoldPeriod: 5 (Local)
PhaseCorrectRate: 1 (Local)
UpdateInterval: 360000 (Local)

[TimeProviders]
NtpClient (Local)
DllName: C:\WINDOWS\system32\w32time.dll (Local)
Enabled: 1 (Local)
InputProvider: 1 (Local)
AllowNonstandardModeCombinations: 1 (Local)
ResolvePeerBackoffMinutes: 15 (Local)
ResolvePeerBackoffMaxTimes: 7 (Local)
CompatibilityFlags: 2147483648 (Local)
EventLogFlags: 1 (Local)
LargeSampleSkew: 3 (Local)
SpecialPollInterval: 32768 (Local)
Type: NTP (Local)
NtpServer: time.windows.com,0x9 (Local)

NtpServer (Local)
DllName: C:\WINDOWS\system32\w32time.dll (Local)
Enabled: 0 (Local)
InputProvider: 0 (Local)
```

```bash
w32tm /query /status
Leap Indicator: 0(no warning)
Stratum: 2 (secondary reference - syncd by (S)NTP)
Precision: -23 (119.209ns per tick)
Root Delay: 0.0062216s
Root Dispersion: 7.7702346s
ReferenceId: 0x14653909 (source IP:  20.101.57.9)
Last Successful Sync Time: 30/05/2023 20:21:27
Source: time.windows.com,0x9
Poll Interval: 13 (8192s)
```

```bash
w32tm /query /peers
#Peers: 1
Peer: time.windows.com,0x9
State: Active
Time Remaining: 23886.4147161s
Mode: 3 (Client)
Stratum: 1 (primary reference - syncd by radio clock)
PeerPoll Interval: 17 (out of valid range)
HostPoll Interval: 13 (8192s)
```

```bash
w32tm /tz
Time zone: Current:TIME_ZONE_ID_DAYLIGHT Bias: -60min (UTC=LocalTime+Bias)
  [Standard Name:"Romance Standard Time" Bias:0min Date:(M:10 D:5 DoW:0)]
  [Daylight Name:"Romance Daylight Time" Bias:-60min Date:(M:3 D:5 DoW:0)]
```

## Update

```bash
w32tm /config "/manualpeerlist:10.0.100.100 10.0.100.101" /syncfromflags:manual /reliable:yes /update
The command completed successfully.
```

```bash
w32tm /resync /rediscover
Sending resync command to local computer
The command completed successfully.
```

## After Update

```bash
w32tm /query /configuration
[Configuration]
EventLogFlags: 2 (Local)
AnnounceFlags: 5 (Local)
TimeJumpAuditOffset: 28800 (Local)
MinPollInterval: 10 (Local)
MaxPollInterval: 15 (Local)
MaxNegPhaseCorrection: 54000 (Local)
MaxPosPhaseCorrection: 54000 (Local)
MaxAllowedPhaseOffset: 1 (Local)

FrequencyCorrectRate: 4 (Local)
PollAdjustFactor: 5 (Local)
LargePhaseOffset: 50000000 (Local)
SpikeWatchPeriod: 900 (Local)
LocalClockDispersion: 10 (Local)
HoldPeriod: 5 (Local)
PhaseCorrectRate: 1 (Local)
UpdateInterval: 360000 (Local)

[TimeProviders]
NtpClient (Local)
DllName: C:\WINDOWS\system32\w32time.dll (Local)
Enabled: 1 (Local)
InputProvider: 1 (Local)
AllowNonstandardModeCombinations: 1 (Local)
ResolvePeerBackoffMinutes: 15 (Local)
ResolvePeerBackoffMaxTimes: 7 (Local)
CompatibilityFlags: 2147483648 (Local)
EventLogFlags: 1 (Local)
LargeSampleSkew: 3 (Local)
SpecialPollInterval: 32768 (Local)
Type: NTP (Local)
NtpServer: 10.0.100.100 10.0.100.101 (Local)

NtpServer (Local)
DllName: C:\WINDOWS\system32\w32time.dll (Local)
Enabled: 0 (Local)
InputProvider: 0 (Local)
```

```bash
w32tm /query /status
Leap Indicator: 0(no warning)
Stratum: 2 (secondary reference - syncd by (S)NTP)
Precision: -23 (119.209ns per tick)
Root Delay: 0.0038578s
Root Dispersion: 7.7667913s
ReferenceId: 0x0A006465 (source IP:  10.0.100.101)
Last Successful Sync Time: 30/05/2023 22:50:39
Source: 10.0.100.101
Poll Interval: 10 (1024s)
```

```bash
w32tm /query /peers
#Peers: 2
Peer: 10.0.100.100
State: Active
Time Remaining: 969.1482278s
Mode: 3 (Client)
Stratum: 1 (primary reference - syncd by radio clock)
PeerPoll Interval: 17 (out of valid range)
HostPoll Interval: 10 (1024s)

Peer: 10.0.100.101
State: Active
Time Remaining: 969.1498223s
Mode: 3 (Client)
Stratum: 1 (primary reference - syncd by radio clock)
PeerPoll Interval: 17 (out of valid range)
HostPoll Interval: 10 (1024s)
```

```bash
w32tm /tz
Time zone: Current:TIME_ZONE_ID_DAYLIGHT Bias: -60min (UTC=LocalTime+Bias)
  [Standard Name:"Romance Standard Time" Bias:0min Date:(M:10 D:5 DoW:0)]
  [Daylight Name:"Romance Daylight Time" Bias:-60min Date:(M:3 D:5 DoW:0)]
```

## Fun Stuff

```bash
w32tm /stripchart /computer:10.0.100.100 /samples:999 /dataonly
Tracking 10.0.100.100 [10.0.100.100:123].
Collecting 999 samples.
The current time is 30/05/2023 23:09:12.
23:09:12, +00.0110311s
23:09:14, +00.0112023s
23:09:16, +00.0099442s
...
23:42:37, +00.0176028s
23:42:39, +00.0159145s
23:42:41, +00.0149748s
```
