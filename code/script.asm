norom

check bankcross off

; BLOCK_1 
org $060000
incbin "../data/eng_block1.bin"

; BLOCK_2
; org $068000
; incbin "eng_block2.bin"

; BLOCK_3
; org $070000
; incbin "../data/eng_block3.bin"

; org $07C765
; db $02,$1D,$43,$42,$48,$3D,$42,$49,$39,$10,$10,$2D,$48,$35,$46,$48,$10,$10,$27,$39,$47,$47,$35,$3B,$39,$10,$10,$1D,$43,$44,$4D,$00

org $07BAA7
incbin "../data/eng_misc2.bin"
