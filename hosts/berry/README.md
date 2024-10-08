# berry

Template for Raspberry Pi [hardware].

- RPi 5 (BCM2712)
  2.4GHz quad-core 64-bit Arm Cortex-A76
  tagged as `5`
  ()
- RPi Zero 2 W (RP3A0)
  1GHz quad-core 64-bit Arm Cortex-A53
  512MB SDRAM
  tagged as `02w`
  (`berry-02w-1`)
- RPi Zero W
  1GHz single-core ARMv6 (BCM2835)
  512MB RAM
  tagged as `0w`
  (`berry-0w-1`, `berry-0w-2`)
- RPi Zero
  1GHZ single-core ARMv6 (BCM2835)
  512MB RAM
  tagged as `0`
  (`berry-0-1`)
- RPi Pico
  ()

A berry may be responsible for a
single, local, long-running task, such as

- Live information display
- Temperature, humidity, CO2
- Monitor APRS with RTL-SDR
- Route wake-on-LAN packets
- Take a picture every 5 minutes
- Network storage, DNS server

[hardware]: https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#raspberry-pi-zero

Owned

- berry-02w-1
- berry-0w-1
- berry-0w-2
- berry-0-1

Planned

- berry-5-1
- berry-02w-2

<!--

has the following [naming scheme]
[naming scheme]: https://www.raspberrypi.com/documentation/microcontrollers/rp2040.html#why-is-the-chip-called-rp2040

```
RP1234

1 - number of cores e.g. 2
2 - type of core e.g. 0 in M0+
3 - floor(log2(ram/16k)) e.g. floor(log2(264KiB/16KiB))=4
4 - floor(log2(nonvolatile/16k)) e.g. floor(log2(16KiB/16KiB))=0
```
-->

