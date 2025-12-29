.segment "CHARS"

; タイル0: 空白
.repeat 8
  .byte %00000000
.endrepeat
.repeat 8
  .byte %00000000
.endrepeat

; タイル1: H
.byte %10000001
.byte %10000001
.byte %10000001
.byte %11111111
.byte %10000001
.byte %10000001
.byte %10000001
.byte %00000000
.repeat 8
  .byte %00000000
.endrepeat

; タイル2: E
.byte %11111111
.byte %10000000
.byte %10000000
.byte %11111110
.byte %10000000
.byte %10000000
.byte %11111111
.byte %00000000
.repeat 8
  .byte %00000000
.endrepeat

; タイル3: L
.byte %10000000
.byte %10000000
.byte %10000000
.byte %10000000
.byte %10000000
.byte %10000000
.byte %11111111
.byte %00000000
.repeat 8
  .byte %00000000
.endrepeat

; タイル4: O
.byte %01111110
.byte %10000001
.byte %10000001
.byte %10000001
.byte %10000001
.byte %10000001
.byte %01111110
.byte %00000000
.repeat 8
  .byte %00000000
.endrepeat
