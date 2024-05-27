norom

; --Field Menu windows--
; shift the money window to the right by 1 tile
org $00E6F2
LDX #$0215
org $00E705
LDX #$0316
org $00E716
LDX #$0318

; widen the main field menu window
org $0148FA
db $01,$02,$14,$C7,$00,$02,$02,$09

; --Inventory Menus--
; shift the item actions menu window left 1 tile
org $014902
db $01,$06,$08,$CB,$00,$01,$04,$00
; adjust the parameters used to preserve what's under the item actions window before it's drawn
org $0100F5
LDX #$0801
org $0100FA
LDX #$0409
; shift the inventory window left 7 tiles and widen to 30 tiles
org $00E7FF
LDA #$01
org $00E818
LDA #$1E
; adjust the parameters used to clear inventory window after closing
org $0101AD
LDX #$0601
org $0101B2
LDX #$0A1E
; preserve the bottom two row of tiles of the field menu window to prevent tile flickering when clearing the inventory window
org $010098
LDX #$0601
org $01009D
LDX #$0214
; shift the inventory cursor left 7 tiles
org $015312
ADC #$02
org $0152E8
LDX #$0702
; shift the inventory text left 7 tiles when redrawing while scrolling
org $015026
LDA #$03
; widen the spacing between the two columns to 13 tiles
org $00E90A
LDA #$0E
org $0151A5
ADC #$0E
org $0150B5
ADC #$0E
; adjust values needed to scroll inventory text properly
org $015062
LDA #$1E
org $01507F
LDX #$011E
org $0150FD
LDA #$1E
org $01513B
LDA #$1E
org $01515B
LDX #$011E
org $0151E6
LDA #$1E
; shift the item description window left 1 tile and widen to 24 tiles
org $015338
LDX #$0207
org $00ED99
LDX #$0418
; adjust the parameters for preserving the tiles that will be overwritten by the description window. This has to be done separately for all 4 item actions
; use
org $010202
LDX #$0207
org $010207
LDX #$040E
org $010210
LDX #$0215
; give
org $0103D5
LDX #$0207
org $0103DA
LDX #$040E
org $0103E3
LDX #$0215
; move
org $0108CD
LDX #$0207
org $0108D2
LDX #$040E
org $0108DB
LDX #$0215
; toss
org $010AA3
LDX #$0207
org $010AA8
LDX #$040E
org $010AB1
LDX #$0215
; relocate the "who?" window to the upper left corner of the screen
org $01347E
LDX #$0201
org $01348C
LDX #$0302 
org $013499
LDX #$0402

; --Special Ability Windows--
; shift the ability window left 7 tiles and widen to 30 tiles
org $00EAEA
LDA #$01
org $00EAFE
LDX #$0A1E
; adjust the parameters for clearing ability window after closing
org $010CD3
LDX #$0601
org $010CD8
LDX #$0A1E
org $010C4E
LDX #$0A01
org $010C53
LDX #$0209
; widen the spacing between the two columns to 13 tiles
org $00EB8A
LDA #$0E
org $00EC90
; adjust the values used to scroll the text properly
org $0159DC
LDA #$03
org $015A81
ADC #$0E
org $015A0E
LDA #$1E
org $015AE8
LDA #$1E
org $015A2B
LDX #$011E
org $015BB3
ADC #$0E
org $015B26
LDA #$1E
org $015BE9
LDA #$1E
org $015B46
LDX #$011E
; adjust the cursor positioning to line up with the new window and text spacing
org $015CF8
LDA #$02
org $015D76
ADC #$02
org $015D6D
LDA #$0E
; shift the ability description window left 1 tile
org $015D9B
LDX #$0207
; adjust values used to restore tiles overwritten by description window. This has to be done separately for both options
; use
org $010D28
LDX #$0207
org $010D2D
LDX #$040E
org $010D36
LDX #$0215
; move
org $010EF7
LDX #$0207
org $010EFC
LDX #$040E
org $010F05
; shift the ability actions window left 1 tile
org $01490A
db $01,$0A,$08,$CF,$00,$01,$02,$00
; adjust the values for restoring tiles overwritten by the ability actions menu
org $010C01
LDX #$0601
org $010C06
LDX #$0214

; --Wardrobe Screen--
; resize stat window to 14x7 tiles and shift right 3 tiles
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
; place the resistance icons 1 tile to the right of their label (heat, cold, electric, mind respectively)
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
; shift clothing labels left 1 tile
org $00EF17
LDA #$0E
; shift all clothing labels down by 1 tile
org $00EFCB
db $0A,$A7,$00,$0C,$A8,$00,$0E,$A9,$00,$10,$AA,$00,$12,$AB,$00,$14,$AC,$00,$16,$AD,$00,$18,$AE,$00
; shift clothing text down by 1 tile and to the left by 3 tiles
org $00EF8D
LDA #$0A
org $00EFA6
LDA #$10
; widen the wardrobe actions menu to 16 tiles and shift left by 1 tile
org $014912
db $01,$02,$10,$D1,$00,$03,$01,$05
; reposition the selection arrow for the clothing list
org $0115AE
LDA #$0D
org $0115B3
LDA #$0A
; change some magic value to get the bottom border of the clothing list to draw
org $011150
LDX #$1902
; shift the window for selecting clothes from inventory left by 1 tile and widen to 16 tiles
org $0116FC
LDX #$0601
org $011701
LDX #$1410
; shift the clothing in inventory text left by 2 tiles
org $01180E
LDA #$02
; shift the clothing in inventory arrow left by 2 tiles
org $001886
LDX #$0701
org $011A22
LDA #$01
; shift the clothing swap text left by 2 tiles
org $01172B
LDA #$02