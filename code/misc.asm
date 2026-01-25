lorom

; --- Script Compression Code ---
org $8BB3AA
incbin "../data/pascal_string_table.bin"
org $8BB488
incbin "../data/pascal_string_data.bin"

; Pascal string lookup routine
; org $8BB488
; Lookup_String:
;     phx
;     lda $18DA
;     sec
;     sbc #$90                ; subtract $90 to get index for lookup table
;     asl                     ; left shift to get final index for table
;     tax
;     rep #$20
;     lda $B3AA,X             ; get string offset from table
;     sta $18DC               ; store where existing routine expects
;     sep #$20
;     plx
;     rtl

; ; Replace old lookup routine with new
; org $818769
; lda #$90            ; pascal strings start at hex id $90
; cmp $18DA           ; compare with current id
; bcc $818788         ; if char's hex id is less than $90 it's not a string so move along
; jsl $Lookup_String

org $81875C         ; beginning of original pascal string lookup routine
sta $18DA
lda #$90            ; pascal strings start at hex id $90
cmp $18DA           ; compare with current id
bcc $818788         ; if char's hex id is less than $90 it's not a string so move along
phb
lda #$8B
pha
plb                 ; change DB to bank $8B
lda $18DA
sec
sbc #$90            ; subtract $90 to get index for lookup table
asl                 ; left shift to get final index for table
tax
rep #$20
lda $B3AA,X         ; get string offset from table
sta $18DC           ; store where existing routine expects
lda #$0000
sep #$20
plb
pla
brl $818A5D         ; continue to existing pascal string printing routine
nop #3              ; pad the remainder since new routine is shorter!
