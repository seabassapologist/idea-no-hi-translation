norom
; patch the 8x8 lookup table to line up with the new 8x16 table
org $058006
incbin "8x8-table.bin"

; import the 8x8 english font set
org $058FA6
incbin "glimmer-sans-8x8-1bpp.bin"

; patch the half-width lookup table to point to 16 byte aligned tiles
org $0581E6
incbin "half-width-table.bin"

; import the 8x16 english font set
org $0592C2
incbin "glimmer-sans-8x16-1bpp.bin"

; Junk to just test text printing, prints one of every 8x16 character
org $060000
db $02,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E
db $1F,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$0D,$2A,$2B,$2C
db $2D,$2E,$2F,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B
db $3C,$3D,$3E,$3F,$40,$41,$42,$43,$0D,$44,$45,$0D,$46,$47,$48
db $49,$4A,$4B,$4C,$4D,$4E,$4F,$50,$51,$52,$53,$54,$55,$56,$57
db $58,$59,$5A,$5B,$5C,$5D,$5E,$5F,$0D,$60,$00

; patch the tile byte counter to start at 16 (#$10), instead of 12 (#$0C)
org $008C8F
LDA #$10

; patch out the upper padding for character tiles, previously an ADC #$0004 instruction
org $008C9D
nop #3

; update the value for checking if a half of a character tile has been written yet, from #$06 to #$08
org $008F52
CMP #$08

; skip the pascal string search for now, change this back to $24 when done
org $117DD0
db $00