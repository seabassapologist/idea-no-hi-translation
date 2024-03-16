norom

; shift the money box to the right by one tile
org $00E6F2
LDX #$0215
org $00E705
LDX #$0316
org $00E716
LDX #$0318

; widen the main menu box
org $0148FA
db $01,$02,$14,$C7,$00,$02,$02,$09