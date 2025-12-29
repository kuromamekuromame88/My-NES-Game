.export _start
.import _main

.segment "STARTUP"

_start:
    sei             ; IRQ無効
    cld
    ldx #$FF
    txs             ; スタック初期化

    ; PPU無効化
    lda #$00
    sta $2000
    sta $2001

    ; RAMクリア（$0000-$07FF）
    ldx #$00
clear_ram:
    lda #$00
    sta $0000,x
    sta $0100,x
    sta $0200,x
    sta $0300,x
    sta $0400,x
    sta $0500,x
    sta $0600,x
    sta $0700,x
    inx
    bne clear_ram

    jsr _main       ; Cの main() へ

forever:
    jmp forever

.segment "VECINFO"
.word nmi_handler
.word _start
.word irq_handler

.segment "CODE"

nmi_handler:
    rti

irq_handler:
    rti
