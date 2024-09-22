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
incbin "glimmer-sans-8x16-1bpp-left-aligned.bin"

; patch the tile byte counter to start at 16 (#$10), instead of 12 (#$0C)
org $008C8F
LDA #$10

; patch out the upper padding for character tiles, previously an ADC #$0004 instruction
org $008C9D
nop #3

; update the value for checking if a half of a character tile has been written yet, from #$06 to #$08
org $008F52
CMP #$08

; update the value for checking if a half of a character tile has been written yet, from #$06 to #$08 in other version of Half width routine
org $008EBF
CMP #$08

; skip the pascal string search for now, change this back to $24 when done
org $117DD0
db $00
