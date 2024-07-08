lorom
; --- VWF Font Code ---

; import the 8x16 VWF shift table
org $8BB256
incbin "shift_table.bin"

org $8BB2D6
Set_Shift:
    REP #$20
    PHX
    PHA
    LDA #$0000
    SEP #$20                        
    LDA $1B02               ; get the shift amount for previous char
    BEQ Set_Prev_Shift      ; if prev_char_shift = 0 don't need to update cur_shift
    ADC $1B03               ; add prev_char_shift to cur_shift
    AND #$07                ; modulo 8 to get the new cur_shift value
    STA $1B03               ; store new cur_shift value
Set_Prev_Shift:    
    LDA $18DA               ; get hex value of current character that's being printed
    SEC
    SBC #$10                ; subtract $10 to get index for lookup table
    TAX
    LDA $8BB256,X           ; get shift amount for current character
    STA $1B02               ; update the prev_char_shift value for next run
    LDA #$07
    SBC $1B03               ; 7 - cur_shift to get offset for JMP. This determines how many shifts happen
    REP #$20
    ADC #$B30F            ; set up the jump offset pointer
    STA $1B04
    PLA
    PLX
    SEP #$20
    RTL
Shift_Bits:
    PHX
    JMP ($1B04)             ; set the starting point of the shift operation
    ASL                     ; 7
    ASL                     ; 6
    ASL                     ; 5
    ASL                     ; 4
    ASL                     ; 3
    ASL                     ; 2
    ASL                     ; 1
    XBA                     ; 0
    PLX
    RTL

org $818DE2
JSL Set_Shift
NOP
NOP
NOP
NOP

org $818E24
JSL Shift_Bits
NOP

org $818E4A
NOP
NOP

org $818E56
LDA #$00
PHA
LDA $190D
BNE No_Or
PLA
STA $1B00
LDA $7F0000,X
EOR #$FF
NOP
NOP
ORA $1B00
PHA
No_Or:
PLA
EOR #$FF
