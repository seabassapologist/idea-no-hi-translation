lorom
; --- VWF Font Code ---
; See notes/technical_notes.md#Variable-Width-Font-Algorithm for high level explanation of the routine

; import the 8x16 VWF shift table
org $8BB256
incbin "../data/shift_table-alt.bin"

; VWF bitshifting code
org $8BB2D6
Set_Shift:
    rep #$20
    phx
    pha
    lda #$0000
    sep #$20                        
    lda $1B02               ; get the shift amount for previous char
    beq Set_Prev_Shift      ; if prev_shift = 0 don't need to update cur_shift
    clc
    adc $1B03               ; add prev_shift to cur_shift
    and #$07                ; modulo 8 to get the new cur_shift value
    sta $1B03               ; store new cur_shift value
Set_Prev_Shift:    
    lda $18DA               ; get hex value of current character that's being printed
    sec
    sbc #$10                ; subtract $10 to get index for lookup table
    tax
    lda $8BB256,X           ; get shift amount for current character
    sta $1B02               ; update the prev_char_shift value for next run
    lda #$07
    sbc $1B03               ; 7 - cur_shift to get offset for JMP. This determines how many shifts happen
    rep #$20
    clc
    adc #$B312              ; set up the jump offset pointer
    sta $1B05
    pla
    plx
    sep #$20
    rtl
Shift_Bits:
    phx
    jmp ($1B05)             ; set the starting point of the shift operation
    asl                     ; 7
    asl                     ; 6
    asl                     ; 5
    asl                     ; 4
    asl                     ; 3
    asl                     ; 2
    asl                     ; 1
    ldx $1B03               ; 0
    beq No_Flip
    xba
No_Flip:                  
    plx
    rtl
; logic to update the tile index tracking variable used to determine where next tile will be drawn to on the screen
Tile_Offset:
    pha
    lda $1B03
    bne Update_Offset   ; if cur_shift > 0 increment goto Update_Offset
    lda $1B02           
    bne No_Shift        ; if prev_shift and cur_shift both equal 0 increment offset, otherwise don't
Update_Offset:
    clc
    adc $1B02
    cmp #09
    bcs No_Shift        ; if (cur_shift + prev_shift) > 8, don't increment the offset
    inc $1873
    inc $1873
No_Shift:
    pla
    rtl
; Reset the bitshift variables when a newline ($0D) control character has been found
Reset_Shifts_Line:
    sep #$20
    stz $1877
    stz $1B02
    stz $1B03
    rtl
; Reset the bitshift variables when the text box is cleared to draw more text
Reset_Shifts_Box:
    stz $1B02
    stz $1B03
    lda $04
    rep #$20
    rtl
; when the [Hero] control code is found, store the current letter at $18DA for the VWF routine
Store_Hero_Letter:
    rep #$20
    sta $18DA
    inc $06
    rtl
; Reset the bitshift variables when a string terminator ($00) control character has been found
Reset_String_End:
    plb
    ply
    plx
    rep #$20
    pla
    sep #$20
    stz $1877
    stz $1B02
    stz $1B03
    rtl
; Logic to properly set the [Fixed] control code parameters
; Check_Fixed_Width:
;     cmp #$02            ; if $02 we found a [Fixed] control code
;     bne Not_Fixed       ; else $01 so we're doing vwf
;     dec                 ; decrement so that font type flag is set to half-width ($01)
;     sta $1877           ; set the flag for fixed width
;     jmp Store_Results
; Not_Fixed:
;     stz $1877           ; make sure fw flag is always $00, in case font is switched mid-string
; Store_Results:
;     sta $1878           ; set the flag for font type
;     pla                 ; pull the address from earlier jsr off stack
;     pla                 ; hate this but i only had 4 bytes to work with
;     jml $8186EE         ; jump back to beginning of text loading routine
; Check if we're doing fixed width or vwf 
; Check_VWF_Flag:
;     lda $1877           ; fw flag - if $00 do vwf, if $01 do fixed-with
;     beq Do_VWF
;     jml $818EEA         ; fixed width routine
; Do_VWF:
;     jsl Set_Shift       ; prepare the shift values
;     jml $818DEA         ; vwf routine


; jump to new routine to choose which font routine (vwf or fw) will be used
; org $818DE2
; jml Check_VWF_Flag
; nop
; nop
; nop
; nop

; perform the bitshifts
org $818E24
jsl Shift_Bits
nop

; patch out the EOR #$FF when pulling tile data from ROM. This will happen after the ORA with existing tile
org $818E4A
nop
nop

; slightly modified tile merging routine. Undoes the EOR of the existing tile, and merges with shifted data, the redoes the EOR #$FF
org $818E56
lda #$00
pha
lda $190D
bne No_Or
pla
sta $1B00
lda $7F0000,X
eor #$FF
nop
nop
ora $1B00
pha
No_Or:
pla
eor #$FF

; jump to the modified tile index offset routine
org $818EDD
nop #6
jsl Tile_Offset

; jump to the modified part of the newline character handling code to reset bitshift variables
org $818AE3
jsl Reset_Shifts_Line
nop

; jump to the modified part of the text box clear handling code to reset bitshift variables
org $81852A
jsl Reset_Shifts_Box

; jump to modified hero name printing routine
org $818A03
jsl Store_Hero_Letter

; jump to the new string terminator handling code to reset bitshift variables
org $818793
jml Reset_String_End

; jump to modified font control code handler
; org $8187B8
; jml Check_Fixed_Width

; Modified font routine selection code
org $818CA4         ; original code here would choose between full and half width routines
cmp #$02            ; check the font type value from $1878
beq Do_FW           ; if #$02, it's [Fixed] so jump to fw routine, otherwise it's vwf
jsl Set_Shift       ; prepare the shift values
jml $818DEA         ; vwf routine
Do_FW:
jml $818EEA         ; fw routine
