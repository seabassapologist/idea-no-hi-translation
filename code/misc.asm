lorom

; --- Script Compression Code ---
org $8BB3AA
incbin "../data/compressed_strings_lookup.bin"

; New compressed string lookup routine
org $8B????
Lookup_String:
    phx
    lda $18DA
    sec
    sbc #$90                ; subtract $90 to get index for lookup table
    rep #$20                ; turn on m flag in case lookup index is higher than 8-bit
    asl                     ; left shift to get final index for table
    tax
    ldx $8BB3AA,X

; Replace old lookup routine with new
org $818769
lda #$90            ; Compressed strings start at id $90
cmp $18DA
bcc $818788         ; if char's hex id is less than $90 it's not a string so move along
jml $Lookup_String
