# ProMicro as AVRISP (fork of [ArduinoISP](https://github.com/rsbohn/ArduinoISP))
[![Reseases](https://img.shields.io/github/tag/elfmimi/ProMicro-AVRISP.svg)](../../releases)

This is an all prepared bundle that allows your ProMicro to work as an AVRISP programmer.

You'll need this to replace, or reprogram if you like, the bootloader on your ProMicro.

See [QMK : ISP Flashing Guide](https://beta.docs.qmk.fm/for-makers-and-modders/isp_flashing_guide)

Please report issues on github.

## How to build
* No need of A-word IDE.
* prepare a compiler: download AVR-GCC from [Microchip](http://ww1.microchip.com/downloads/en/DeviceDoc/avr8-gnu-toolchain-3.6.1.1752-win32.any.x86.zip)

  or do apt-get install binutils-avr gcc-avr avr-libc , on linux
* git clone -b with-submodule --recursive https://github.com/elfmimi/ProMicro-AVRISP.git ProMicro-AVRISP
* cd ProMicro-AVRISP
* make

## Other notes
* It will be recognized as VID_16C0&PID_0483 and it will be recognized by QMK Toolbox aswell.

  VID&PID is defined in TeensyCore/usb_serial/usb_private.h
* Default bootloader of ATMEGA32U4 can be found [here](http://ww1.microchip.com/downloads/en/DeviceDoc/megaUSB_DFU_Bootloaders.zip).

  and it's document [here](http://ww1.microchip.com/downloads/en/DeviceDoc/doc7618.pdf).
