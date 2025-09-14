norom

; --Field Menu windows--
; shift the money window to the right by 1 tile
org $00E6F2
ldx #$0215
org $00E705
ldx #$0316
org $00E716
ldx #$0318
; switch the money window font type to [Fixed] to prevent border palette corruption when there's 6 digits
org $00FA41
lda #$02

; widen the main field menu window
org $0148FA
db $01,$02,$11,$C7,$00,$02,$02,$06

; --Inventory Menus--
; shift the item actions menu window left 1 tile
org $014902
db $01,$06,$08,$CB,$00,$01,$04,$00
; adjust the parameters used to preserve what's under the item actions window before it's drawn
org $0100F5
ldx #$0801
org $0100FA
ldx #$0409
; shift the inventory window left 7 tiles and widen to 30 tiles
org $00E7FF
lda #$01
org $00E818
lda #$1E
; adjust the parameters used to clear inventory window after closing
org $0101AD
ldx #$0601
org $0101B2
ldx #$0A1E
; preserve the bottom two row of tiles of the field menu window to prevent tile flickering when clearing the inventory window
org $010098
ldx #$0601
org $01009D
ldx #$0214
; shift the inventory cursor left 7 tiles
org $015312
ADC #$02
org $0152E8
ldx #$0702
; shift the inventory text left 7 tiles when redrawing while scrolling
org $015026
lda #$03
; widen the spacing between the two columns to 13 tiles
org $00E90A
lda #$0E
org $0151A5
ADC #$0E
org $0150B5
ADC #$0E
; adjust values needed to scroll inventory text properly
org $015062
lda #$1E
org $01507F
ldx #$011E
org $0150FD
lda #$1E
org $01513B
lda #$1E
org $01515B
ldx #$011E
org $0151E6
lda #$1E
; shift the item description window left 1 tile and widen to 24 tiles
org $015338
ldx #$0207
org $00ED99
ldx #$0418
; adjust the parameters for preserving the tiles that will be overwritten by the description window. This has to be done separately for all 4 item actions
; use
org $010202
ldx #$0207
org $010207
ldx #$040E
org $010210
ldx #$0215
; give
org $0103D5
ldx #$0207
org $0103DA
ldx #$040E
org $0103E3
ldx #$0215
; move
org $0108CD
ldx #$0207
org $0108D2
ldx #$040E
org $0108DB
ldx #$0215
; toss
org $010AA3
ldx #$0207
org $010AA8
ldx #$040E
org $010AB1
ldx #$0215
; relocate the "who?" window to the upper left corner of the screen
org $01347E
ldx #$0201
org $01348C
ldx #$0302 
org $013499
ldx #$0402

; --Special Ability Windows--
; shift the ability window left 7 tiles and widen to 30 tiles
org $00EAEA
lda #$01
org $00EAFE
ldx #$0A1E
; adjust the parameters for clearing ability window after closing
org $010CD3
ldx #$0601
org $010CD8
ldx #$0A1E
org $010C4E
ldx #$0A01
org $010C53
ldx #$0209
; widen the spacing between the two columns to 13 tiles
org $00EB8A
lda #$0E
org $00EC90
; adjust the values used to scroll the text properly
org $0159DC
lda #$03
org $015A81
ADC #$0E
org $015A0E
lda #$1E
org $015AE8
lda #$1E
org $015A2B
ldx #$011E
org $015BB3
ADC #$0E
org $015B26
lda #$1E
org $015BE9
lda #$1E
org $015B46
ldx #$011E
; adjust the cursor positioning to line up with the new window and text spacing
org $015CF8
lda #$02
org $015D76
ADC #$02
org $015D6D
lda #$0E
; shift the ability description window left 1 tile
org $015D9B
ldx #$0207
; adjust values used to restore tiles overwritten by description window. This has to be done separately for both options
; use
org $010D28
ldx #$0207
org $010D2D
ldx #$040E
org $010D36
ldx #$0215
; move
org $010EF7
ldx #$0207
org $010EFC
ldx #$040E
org $010F05
; shift the ability actions window left 1 tile
org $01490A
db $01,$0A,$08,$CF,$00,$01,$02,$00
; adjust the values for restoring tiles overwritten by the ability actions menu
org $010C01
ldx #$0601
org $010C06
ldx #$0214

; --Wardrobe Screen--
org $05B36D ; $8BB36D
Stat_Label_Line_Check:
;pha
txa
cmp #$02    ; check if first two labels have been printed
bcc No_Reset
lda #$07    ; if yes shift the y coordinate down 1 tile
sta $03
txa
cmp #$03
bcs Finish
lda #$19    ; reset x coordinate back to original value
sta $190F
sta $02
jmp Finish
No_Reset:
lda #$06
sta $03
Finish:
;pla
rtl

; resize stat window to 14x7 tiles and shift right 3 tiles
org $00F161
ldx #$050D
org $00F166
ldx #$0412
; shift stat labels right 3 tiles
org $00F16F
ldx #$060E
org $00F185
ldx #$070E
; orient the resistance labels to be horizontal and move them below the the stats
org $00F19B
lda #$19
org $00F1A2
lda $190F
sta $02
jsl $8BB36D
; make the resistance labels print 3 tiles apart
org $00F1BA
stz $07
jsl $81FC0D
inc $190F
inc $190F
inc $190F
inx
txa
; change text palette for stat values to orange might not keep this
org $00F1FA 
lda #$00
; make stat values print as 8x8 characters
org $00FA41
lda #$00
; shift the stat values right 4 tiles (pow, def, speed, luck respectively)
org $00F1D1
lda #$0610
org $00F205
lda #$0615
org $00F230
lda #$0710
org $00F25B
lda #$0715
; place the resistance icons 1 tile to the right of their label (heat, cold, electric, mind respectively)
org $00F2A7
ldx #$061A
org $00F2CE
ldx #$061D
org $00F2FA
ldx #$071A
org $00F322
ldx #$071D
; update the character bytes for resistance symbols
org $00F340
db $69,$10,$68,$6A
; change the character bytes for the resistance labels
org $00F33B
db $6F,$70,$71,$72
; resize clothing list to 12x12 tiles, shift right by 1 tile, and shift down 1 tile
org $00EF04
ldx #$090D
org $00EF09
ldx #$1212
; shift clothing labels left 1 tile
org $00EF17
lda #$0E
; shift all clothing labels down by 1 tile
org $00EFCB
db $0A,$A7,$00,$0C,$A8,$00,$0E,$A9,$00,$10,$AA,$00,$12,$AB,$00,$14,$AC,$00,$16,$AD,$00,$18,$AE,$00
; shift clothing text down by 1 tile and to the left by 3 tiles
org $00EF8D
lda #$0A
org $00EFA6
lda #$10
; widen the wardrobe actions menu to 16 tiles and shift left by 1 tile
org $014912
db $04,$01,$18,$D1,$00,$03,$01,$07
; reposition the selection arrow for the clothing list
org $0115AE
lda #$0D
org $0115B3
lda #$0A
; change some magic value to get the bottom border of the clothing list to draw
org $011150
ldx #$1902
; shift the window for selecting clothes from inventory left by 1 tile and widen to 16 tiles
org $0116FC
ldx #$0601
org $011701
ldx #$1410
; shift the clothing in inventory text left by 2 tiles
org $01180E
lda #$02
; shift the clothing in inventory arrow left by 2 tiles
org $011886
ldx #$0701
org $011A22
lda #$01
; shift the clothing swap text left by 2 tiles
org $01172B
lda #$02
; adjust parameters to preserve the "who?" box before transitioning to the wardrobe screen
org $01110F
ldx #$0101
org $011114
ldx #$0506

; --File Select Screen--
; shift options window left 2 tiles and widen to 
org $037478
ldx #$0202
org $03747D
ldx #$041C
org $03748B
ldx #$0304
; TODO - Probably needs a custom routine to move the cursor in variable amounts
; shift cursor starting position for option window left 2 tiles
org $036B39
lda #$03
; increase cursor horizontal movement to 7 tiles
org $036B4D
lda #$07

; --New Game Screens--
; update name input routine to allow 8 characters
org $036EC0
cpy #$0008
; insert the modified naming screen table
org $03788E
incbin "../data/name-screen-table.bin"
; change the font type for in-progress name to [Fixed] so that overwriting the asterisks works correctly
org $037063
ldx #$0102
; shift the in-progress name left 3 tiles
org $037058
ldx #$0311
org $037068
ldx #$0311
; widen the name window to 22 tiles and shift left by 1
org $036DDF
ldx #$0205
org $036DE4
ldx #$0416
org $036E0C
ldx #$0307
