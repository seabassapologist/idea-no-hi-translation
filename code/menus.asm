lorom

; --Field Menu windows--
; shift the money window to the right by 1 tile
org $81E6F2
ldx #$0215
org $81E705
ldx #$0316
org $81E716
ldx #$0318
; widen the main field menu window
org $82C8FA
db $01,$02,$11,$C7,$00,$02,$02,$06
; --Inventory Menus--
; shift the item actions menu window left 1 tile
org $82C902
db $01,$06,$08,$CB,$00,$01,$04,$00
; adjust the parameters used to preserve what's under the item actions window before it's drawn
org $8280F5
ldx #$0801
org $8280FA
ldx #$0409
; shift the inventory window left 7 tiles and widen to 30 tiles
org $81E7FF
lda #$01
org $81E818
lda #$1E
; adjust the parameters used to clear inventory window after closing
org $8281AD
ldx #$0601
org $8281B2
ldx #$0A1E
; preserve the bottom two row of tiles of the field menu window to prevent tile flickering when clearing the inventory window
org $828098
ldx #$0601
org $82809D
ldx #$0214
; shift the inventory cursor left 7 tiles
org $82D312
ADC #$02
org $82D2E8
ldx #$0702
; shift the inventory text left 7 tiles when redrawing while scrolling
org $82D026
lda #$03
; widen the spacing between the two columns to 13 tiles
org $81E90A
lda #$0E
org $82D1A5
ADC #$0E
org $82D0B5
ADC #$0E
; adjust values needed to scroll inventory text properly
org $82D062
lda #$1E
org $82D07F
ldx #$011E
org $82D0FD
lda #$1E
org $82D13B
lda #$1E
org $82D15B
ldx #$011E
org $82D1E6
lda #$1E
; shift the item description window left 1 tile and widen to 24 tiles
org $82D338
ldx #$0207
org $81ED99
ldx #$0418
; adjust the parameters for preserving the tiles that will be overwritten by the description window. This has to be done separately for all 4 item actions
; use
org $828202
ldx #$0207
org $828207
ldx #$040E
org $828210
ldx #$0215
; give
org $8283D5
ldx #$0207
org $8283DA
ldx #$040E
org $8283E3
ldx #$0215
; move
org $8288CD
ldx #$0207
org $8288D2
ldx #$040E
org $8288DB
ldx #$0215
; toss
org $828AA3
ldx #$0207
org $828AA8
ldx #$040E
org $828AB1
ldx #$0215
; relocate the "who?" window to the upper left corner of the screen
org $82B47E
ldx #$0201
org $82B48C
ldx #$0302 
org $82B499
ldx #$0402

; --Special Ability Windows--
; shift the ability window left 7 tiles and widen to 30 tiles
org $81EAEA
lda #$01
org $81EAFE
ldx #$0A1E
; adjust the parameters for clearing ability window after closing
org $828CD3
ldx #$0601
org $828CD8
ldx #$0A1E
org $828C4E
ldx #$0A01
org $828C53
ldx #$0209
; widen the spacing between the two columns to 13 tiles
org $81EB8A
lda #$0E
; org $00EC90
; adjust the values used to scroll the text properly
org $82D9DC
lda #$03
org $82DA81
ADC #$0E
org $82DA0E
lda #$1E
org $82DAE8
lda #$1E
org $82DA2B
ldx #$011E
org $82DBB3
ADC #$0E
org $82DB26
lda #$1E
org $82DBE9
lda #$1E
org $82DB46
ldx #$011E
; adjust the cursor positioning to line up with the new window and text spacing
org $82DCF8
lda #$02
org $82DD76
ADC #$02
org $82DD6D
lda #$0E
; shift the ability description window left 1 tile
org $82DD9B
ldx #$0207
; adjust values used to restore tiles overwritten by description window. This has to be done separately for both options
; use
org $828D28
ldx #$0207
org $828D2D
ldx #$040E
org $828D36
ldx #$0215
; move
org $828EF7
ldx #$0207
org $828EFC
ldx #$040E
; org $010F05
; shift the ability actions window left 1 tile
org $82C90A
db $01,$0A,$08,$CF,$00,$01,$02,$00
; adjust the values for restoring tiles overwritten by the ability actions menu
org $828C01
ldx #$0601
org $828C06
ldx #$0214

; --Wardrobe Window--
; shift the wardrobe window left 7 tiles and widen to 30 tiles
org $81EE1A
ldx #$0601
org $81EE1F
ldx #$0A1E
; widen the placement of the equipment columns to 14 tiles
org $81EE5C
lda #$0D
org $81EE6D
adc #$03
; shift the "Current Clothing" label left two tiles to center in window
org $81EE41
ldx #$0608

; shift the wardrobe stat window left 1 tile and widen to 24 tiles
org $81EFFC
ldx #$0207
org $81F001
ldx #$0418

; --Wardrobe Screen--
org $8BB36D ; $8BB36D
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
Patch_Font_Type:
pha
lda #$01
sta $1B02
pla
jsl $81FA2B
stz $1B02
rtl
Select_Font_Type:
lda $1B02
cmp #$01
bne Default_Font
stz $18FB
rtl
Default_Font:
lda #$02
sta $18FB
rtl

; resize stat window to 14x7 tiles and shift right 3 tiles
org $81F161
ldx #$050D
org $81F166
ldx #$0412
; shift stat labels right 3 tiles
org $81F16F
ldx #$060E
org $81F185
ldx #$070E
; orient the resistance labels to be horizontal and move them below the the stats
org $81F19B
lda #$19
org $81F1A2
lda $190F
sta $02
jsl Stat_Label_Line_Check
; make the resistance labels print 3 tiles apart
org $81F1BA
stz $07
jsl $81FC0D
inc $190F
inc $190F
inc $190F
inx
txa
; change text palette for stat values to orange might not keep this
org $81F1FA 
lda #$00
; make stat values print as 8x8 characters
org $81F1FF
jsl Patch_Font_Type
org $81F22A
jsl Patch_Font_Type
org $81F255
jsl Patch_Font_Type
org $81F280
jsl Patch_Font_Type

org $81FA41
jsl Select_Font_Type
nop
; lda #$00
; org $00FB36
; jsl $8BB38A
; shift the stat values right 4 tiles (pow, def, speed, luck respectively)
org $81F1D1
lda #$0610
org $81F205
lda #$0615
org $81F230
lda #$0710
org $81F25B
lda #$0715
; place the resistance icons 1 tile to the right of their label (heat, cold, electric, mind respectively)
org $81F2A7
ldx #$061A
org $81F2CE
ldx #$061D
org $81F2FA
ldx #$071A
org $81F322
ldx #$071D
; update the character bytes for resistance symbols
org $81F340
db $69,$10,$68,$6A
; change the character bytes for the resistance labels
org $81F33B
db $6F,$70,$71,$72
; resize clothing list to 12x12 tiles, shift right by 1 tile, and shift down 1 tile
org $81EF04
ldx #$090D
org $81EF09
ldx #$1212
; shift clothing labels left 1 tile
org $81EF17
lda #$0E
; shift all clothing labels down by 1 tile
org $81EFCB
db $0A,$A7,$00,$0C,$A8,$00,$0E,$A9,$00,$10,$AA,$00,$12,$AB,$00,$14,$AC,$00,$16,$AD,$00,$18,$AE,$00
; shift clothing text down by 1 tile and to the left by 3 tiles
org $81EF8D
lda #$0A
org $81EFA6
lda #$10
; widen the wardrobe actions menu to 16 tiles and shift left by 1 tile
org $82C912
db $04,$01,$18,$D1,$00,$03,$01,$07
; reposition the selection arrow for the clothing list
org $8295AE
lda #$0D
org $8295B3
lda #$0A
; change some magic value to get the bottom border of the clothing list to draw
org $829150
ldx #$1902
; shift the window for selecting clothes from inventory left by 1 tile and widen to 16 tiles
org $8296FC
ldx #$0601
org $829701
ldx #$1410
; shift the clothing in inventory text left by 2 tiles
org $82980E
lda #$02
; shift the clothing in inventory arrow left by 2 tiles
org $829886
ldx #$0701
org $829A22
lda #$01
; shift the clothing swap text left by 2 tiles
org $82972B
lda #$02
; adjust parameters to preserve the "who?" box before transitioning to the wardrobe screen
org $82910F
ldx #$0101
org $829114
ldx #$0506

; --File Select Screen--
; shift options window left 2 tiles and widen to 
org $86F478
ldx #$0202
org $86F47D
ldx #$041C
org $86F48B
ldx #$0304
; TODO - Probably needs a custom routine to move the cursor in variable amounts
; shift cursor starting position for option window left 2 tiles
org $86EB39
lda #$03
; increase cursor horizontal movement to 7 tiles
org $86EB4D
lda #$07

; --New Game Screens--
; update name input routine to allow 8 characters
org $86EEC0
cpy #$0008
; insert the modified naming screen table
org $86F88E
incbin "../data/name-screen-table.bin"
; change the font type for in-progress name to [Fixed] so that overwriting the asterisks works correctly
org $86F063
ldx #$0102
; shift the in-progress name left 3 tiles
org $86F058
ldx #$0311
org $86F068
ldx #$0311
; widen the name window to 22 tiles and shift left by 1
org $86EDDF
ldx #$0205
org $86EDE4
ldx #$0416
org $86EE0C
ldx #$0307
