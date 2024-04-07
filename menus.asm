norom

; --Main Menu boxes--
; shift the money box to the right by one tile
org $00E6F2
LDX #$0215
org $00E705
LDX #$0316
org $00E716
LDX #$0318

; widen the main menu box
org $0148FA
db $01,$02,$14,$C7,$00,$02,$02,$09

; --Wardrobe Screen--
; resize stat box to 14x7 tiles and shift right 3 tiles
org $00F161
LDX #$0211
org $00F166
LDX #$070E
; shift stat labels right 3 tiles
org $00F16F
LDX #$0312
org $00F185
LDX #$0512
; orient the resistance labels to be horizontal and move them below the the stats
org $00F19B
LDA #$12
org $00F1A2
LDA $190F
STA $02
LDA #$07
STA $03
; make the resistance labels print 3 tiles apart
org $00F1BA
STZ $07
JSL $81FC0D
INC $190F
INC $190F
INC $190F
INX
TXA
; shift the stat values right 4 tiles (pow, def, speed, luck respectively)
org $00F1D1
LDA #$0315
org $00F205
LDA #$031B
org $00F230
LDA #$0515
org $00F25B
LDA #$051B
; place the resistance icons one tile to the right of their label (heat, cold, electric, mind respectively)
org $00F2A7
LDX #$0713
org $00F2CE
LDX #$0716
org $00F2FA
LDX #$0719
org $00F322
LDX #$071C
; resize clothing list to 12x12 tiles, shift right by 1 tile, and shift down 1 tile
org $00EF04
LDX #$090D
org $00EF09
LDX #$1212
; shift all lables down by one tile
org $00EFCB
db $0A,$A7,$00,$0C,$A8,$00,$0E,$A9,$00,$10,$AA,$00,$12,$AB,$00,$14
db $AC,$00,$16,$AD,$00,$18,$AE,$00