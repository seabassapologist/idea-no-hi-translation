norom

; First string 
org $060000
; db $02,$1E,$43,$37,$48,$43,$46,$10,$5A,$1D,$43,$41,$39,$10,$42,$43,$4B,$4F,$10,$2E,$43,$38,$35,$4D,$59,$47,$0D,$10,$48,$3C,$39,$10,$38,$35,$4D,$10,$4B,$3C,$39,$46,$39,$10,$4D,$43,$49,$10,$4B,$3D,$40,$40,$0D,$10,$47,$3C,$43,$4B,$10,$49,$47,$10,$4D,$43,$49,$46,$10,$44,$43,$4B,$39,$46,$47,$4F,$0D,$10,$1E,$43,$10,$3D,$48,$10,$42,$43,$4B,$4F,$5A,$00
; ; Second String
; db $02,$0D,$05,$5A,$2F,$3B,$35,$3B,$35,$35,$35,$35,$51,$51,$51,$4F,$5A,$0D,$00
incbin "test_strings.bin"
