# プロジェクト名
PROJECT = cc65-helloworld

# ディレクトリ
SRC_DIR = src
BUILD_DIR = build

# ツールチェーン（PATH前提）
CC = cc65
CA = ca65
LD = ld65

# フラグ
CFLAGS = -t nes -Oirs
AFLAGS =
LDFLAGS = -C config.cfg

# ソース
C_SOURCES   = $(wildcard $(SRC_DIR)/*.c)
ASM_SOURCES = $(wildcard $(SRC_DIR)/*.asm)

C_OBJECTS   = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.s, $(C_SOURCES))
ASM_OBJECTS = $(patsubst $(SRC_DIR)/%.asm, $(BUILD_DIR)/%.o, $(ASM_SOURCES))
OBJECTS     = $(patsubst $(BUILD_DIR)/%.s, $(BUILD_DIR)/%.o, $(C_OBJECTS)) $(ASM_OBJECTS)

.SECONDARY: $(C_OBJECTS)

# デフォルト
all: $(BUILD_DIR)/$(PROJECT).nes

# NES生成
$(BUILD_DIR)/$(PROJECT).nes: $(OBJECTS)
	$(LD) $(LDFLAGS) -m $(BUILD_DIR)/$(PROJECT).map -o $@ $(OBJECTS)

# C → .s
$(BUILD_DIR)/%.s: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) $< -o $@

# ASM → .o
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm | $(BUILD_DIR)
	$(CA) $< -o $@

# .s → .o
$(BUILD_DIR)/%.o: $(BUILD_DIR)/%.s
	$(CA) $< -o $@

# build ディレクトリ
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# クリーン
clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean
