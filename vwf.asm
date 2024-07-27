lorom
; --- VWF Font Code ---

; import the 8x16 VWF shift table
org $8BB256
incbin "shift_table.bin"

org $8BB2D6
Set_Shift:
    rep #$20
    phx
    pha
    lda #$0000
    sep #$20                        
    lda $1B02               ; get the shift amount for previous char
    beq Set_Prev_Shift      ; if prev_char_shift = 0 don't need to update cur_shift
    clc
    adc $1B03               ; add prev_char_shift to cur_shift
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
Tile_Offset:
    pha
    lda $1B03
    bne Update_Offset   ; if cur_shift > 0 increment goto Update_Dffset
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
Reset_Shifts:           ; this code runs every time a line break is encountered
    sep #$20
    stz $1877
    stz $1B02
    stz $1B03
    rtl

org $818DE2
jsl Set_Shift
nop
nop
nop
nop

org $818E24
jsl Shift_Bits
nop

org $818E4A
nop
nop

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

org $818EDD
nop #6
jsl Tile_Offset

org $818AE3
jsl Reset_Shifts
nop
