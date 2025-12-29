CC65 = cl65
TARGET = build/game.nes

SRC = \
	src/crt0.s \
	src/main.c \
	src/chr.s

CFLAGS = -t nes
LDFLAGS = -C config/linker.cfg

all: $(TARGET)

$(TARGET): $(SRC)
	mkdir -p build
	$(CC65) $(CFLAGS) $(LDFLAGS) -o $(TARGET) $(SRC)

$(TARGET): $(PRG) src/chr.bin
	cat $(PRG) src/chr.bin > $(TARGET)


clean:
	rm -rf build
