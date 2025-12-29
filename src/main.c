#include <stdint.h>

#define PPUCTRL   (*(volatile uint8_t*)0x2000)
#define PPUMASK   (*(volatile uint8_t*)0x2001)
#define PPUSTATUS (*(volatile uint8_t*)0x2002)
#define PPUADDR   (*(volatile uint8_t*)0x2006)
#define PPUDATA   (*(volatile uint8_t*)0x2007)

void ppu_wait_vblank(void) {
    while (!(PPUSTATUS & 0x80));
}

void main(void) {
    ppu_wait_vblank();

    /* パレット設定 */
    PPUADDR = 0x3F;
    PPUADDR = 0x00;
    PPUDATA = 0x0F; // 背景
    PPUDATA = 0x01; // 文字色
    PPUDATA = 0x00;
    PPUDATA = 0x00;

    /* ネームテーブル $2000 に "HELLO" を書く */
    PPUADDR = 0x20;
    PPUADDR = 0x40; // 画面中央付近

    PPUDATA = 1; // H
    PPUDATA = 2; // E
    PPUDATA = 3; // L
    PPUDATA = 3; // L
    PPUDATA = 4; // O

    /* PPU 有効化 */
    PPUCTRL = 0x00;
    PPUMASK = 0x08; // 背景ON

    while (1) {
        /* 無限ループ */
    }
}
