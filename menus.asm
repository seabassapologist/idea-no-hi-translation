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
org $81F161
LDX #$0211
org $81F166
LDX #$070E
; shift stat labels right 3 tiles
org $81F16F
LDX #$0412
org $81F181
LDX #$0512
; orient the resistance labels to be horizontal and move them below the the stats
org $81F1A2
LDA $190F
STA $02
LDA #$07
STA $03