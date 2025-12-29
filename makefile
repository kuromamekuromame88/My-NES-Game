# プロジェクト名
PROJECT = cc65-helloworld

# ソースディレクトリとビルドディレクトリ
SRC_DIR = src
BUILD_DIR = build

# cc65 ツールチェーンのパス
CC65_PATH = C:/cc65

# コンパイラとアセンブラの設定
CC = $(CC65_PATH)/bin/cc65
CA = $(CC65_PATH)/bin/ca65
LD = $(CC65_PATH)/bin/ld65

# コンパイルフラグ
CFLAGS = -t nes -Oirs
AFLAGS = 
LDFLAGS = -C $/config.cfg

# ソースファイルとオブジェクトファイルのリスト
C_SOURCES = $(wildcard $(SRC_DIR)/*.c)
ASM_SOURCES = $(wildcard $(SRC_DIR)/*.asm)
C_OBJECTS = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.s, $(C_SOURCES))
ASM_OBJECTS = $(patsubst $(SRC_DIR)/%.asm, $(BUILD_DIR)/%.o, $(ASM_SOURCES))
OBJECTS = $(patsubst $(BUILD_DIR)/%.s, $(BUILD_DIR)/%.o, $(C_OBJECTS)) $(ASM_OBJECTS)

# .s ファイルを残すための設定
.SECONDARY: $(C_OBJECTS)

# デフォルトターゲット
all: $(BUILD_DIR)/$(PROJECT).nes

# NES ファイルの生成
$(BUILD_DIR)/$(PROJECT).nes: $(OBJECTS)
	$(LD) $(LDFLAGS) -m $(BUILD_DIR)/$(PROJECT).map -o $@ $(OBJECTS) nes.lib

# C ファイルのコンパイル
$(BUILD_DIR)/%.s: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) $< -o $@

# アセンブリファイルのアセンブル
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm
	$(CA) $< -o $@

# C ファイルのアセンブル
$(BUILD_DIR)/%.o: $(BUILD_DIR)/%.s
	$(CA) $< -o $@

# ビルドディレクトリの作成
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# クリーンアップ
clean:
	for /f "delims=" %%f in ('dir /b /a-d $(BUILD_DIR)\*') do del /q /f "$(BUILD_DIR)\%%f"

.PHONY: all clean