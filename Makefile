TARGET=ArduinoISP

MCU=atmega32u4 
F_CPU=16000000

# We are gonna build against TeensyCore, because of VID&PID.
# https://github.com/PaulStoffregen/cores
TEENSY=../../GitHub/teensy-core/teensy

# You just need two files, SPI.cpp and SPI.h from ArduinoCore for AVR.
# https://github.com/arduino/ArduinoCore-avr
# https://github.com/arduino/ArduinoCore-avr/tree/master/libraries/SPI/src
LIBSPI=../../GitHub/ArduinoCore-avr/libraries/SPI/src

INO_PATH=$(TARGET)
SRC_PATH=$(TEENSY) $(LIBSPI)
DEFS=-DARDUINO=100 -DUSB_SERIAL -DF_CPU=$(F_CPU)UL 
INCS=$(addprefix -I,$(SRC_PATH)) -Wp,-include,WProgram.h
FLAGS=-Os -mmcu=$(MCU)
CXXFLAGS=-std=c++11
SRCS=main.cpp usb.c usb_api.cpp pins_teensy.c SPI.cpp
OBJS=$(TARGET).o $(filter %.o,$(SRCS:.c=.o) $(SRCS:.cpp=.o))
OBJDIR=obj

default: hex
bin: $(TARGET).bin
hex: $(TARGET).hex
elf: $(TARGET).elf

$(OBJDIR):
	@mkdir -p $@

vpath %.ino $(INO_PATH)
vpath %.ino.h $(INO_PATH)
$(OBJDIR)/%.o: %.ino %.ino.h | $(OBJDIR)
	avr-gcc -x c++ $(CXXFLAGS) $(FLAGS) $(DEFS) $(INCS) -Wp,-include,$(filter %.ino.h,$^) -c -o $@ $<

vpath %.c $(SRC_PATH)
$(OBJDIR)/%.o: %.c | $(OBJDIR)
	avr-gcc $(FLAGS) $(DEFS) $(INCS) -c -o $@ $<

vpath %.cpp $(SRC_PATH)
$(OBJDIR)/%.o: %.cpp | $(OBJDIR)
	avr-gcc $(CXXFLAGS) $(FLAGS) $(DEFS) $(INCS) -c -o $@ $<

$(TARGET).elf: $(addprefix $(OBJDIR)/,$(OBJS))
	avr-gcc -mmcu=$(MCU) -Wl,--gc-sections --output $@ $^

%.hex: %.elf
	avr-objcopy -O ihex -R .eeprom -R .fuse -R .lock -R .signature $< $@

%.bin: %.hex
	avr-objcopy -I ihex -O binary $< $@

clean:
	rm -rf obj $(TARGET).elf $(TARGET).hex $(TARGET).bin
