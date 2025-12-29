typedef unsigned char UChar;

/* PPU registers */
#define PPU_CTRL1   (*(volatile UChar*)0x2000)
#define PPU_CTRL2   (*(volatile UChar*)0x2001)
#define PPU_STATUS  (*(volatile UChar*)0x2002)
#define PPU_ADDR    (*(volatile UChar*)0x2006)
#define PPU_DATA    (*(volatile UChar*)0x2007)

/*
 CHR-ROM の想定配置
 0: 空白
 1: H
 2: E
 3: L
 4: O
*/
const UChar hello_tiles[] = {
    1, 2, 3, 3, 4
};

void NesMain(void)
{
    UChar i;

    /* PPU OFF */
    PPU_CTRL1 = 0x00;
    PPU_CTRL2 = 0x00;

    /* VBlank 待ち */
    while (!(PPU_STATUS & 0x80));

    /* BG 書き込み位置 (x=10, y=10 → $214A) */
    PPU_ADDR = 0x21;
    PPU_ADDR = 0x4A;

    /* "HELLO" を書く */
    for (i = 0; i < 5; i++) {
        PPU_DATA = hello_tiles[i];
    }

    /* PPU ON
       - BG表示ON
       - NMIは一旦OFFでもOK */
    PPU_CTRL1 = 0x00;
    PPU_CTRL2 = 0x08;

    /* 何もしない無限ループ */
    while (1) {
        /* halt */
    }
}
