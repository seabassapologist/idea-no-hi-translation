# Lookup Tables

## Pascal String Tables

These seem to be loaded using offset values stored starting at **PRG**`$117DCA`/**loROM**`$A2FDCA`, and the index of this "pre-lookup-table" is determined by a check made after a character byte is loaded. 

From here, each of these lookup tables and and offsets are relative to **PRG**`$117DCA`/**loROM**`$A2FDCA`

* **PRG**`$117DCA`/**loROM**`$A2FDCA` loads `$0006`, which points to table at **loROM**`$117DD0`
    * This happens when loading printable, non-kanji characters are found
* **PRG**`$117DCC`/**loROM**`$A2FDCC` loads `$002E`, which points to table at **loROM**`$117DF8`
    * This is happens if the byte is `$FD`, `$FE`, or `$FF` (aka it's a Kanji character or pascal string) |
* **PRG**`$117DCE`/**loROM**`$A2FDCE` loads `$00C8` which points to a table at **PRG**`$117E92`/**loROM**`$A2FE92`
    * loaded when the character byte is `$0F`
* These three tables are contiguous in ROM, but are separated because they are loaded differently

### Pascal String Table Part 1

| Index | Offset | Length| String |
|-------|--------|-------|--------|
| `$0F` | `$00C8`| `$05` | `D4 00 03 D2 D3`|

* This string is interesting, it prints `」<end><full>*「`
* Current theory: This is related to handling generic NPC or "non-speaking" dialogue box text. These instances have a * character in place of the character name. So it would make sense that this could be used to string together dialogue chunks more efficiently

### Pascal String Table Part 2

Stored at **PRG**`$117DD0`/**loROM**`$A2FDD0`

| Index | Offset | Length| String |
|-------|--------|-------|--------|
| `$24` | `$00CE`| `$02` | `0D 10` |
| `$25` | `$00D1`| `$03` | `D9 D9 D9` |
| `$29` | `$00D5`| `$02` | `49 36` |
| `$2A` | `$00D8`| `$02` | `6E 65` |
| `$2B` | `$00DB`| `$02` | `41 5D` |
| `$2C` | `$00DE`| `$02` | `72 D5` |
| `$2F` | `$00E1`| `$02` | `3C 5E` |
| `$31` | `$00E4`| `$02` | `FF D9` |
| `$32` | `$00E7`| `$02` | `FF E6` |
| `$34` | `$00EA`| `$02` | `D5 D5` |
| `$FA` | `$00ED`| `$03` | `D7 D7 D7` |
| `$FB` | `$00F1`| `$02` | `36 44` |
| `$FC` | `$00F4`| `$04` | `FF CD FF D8` |

* Observation: `$24` does a line break and space
* Some of these may be names, others are are strings of punctuation


### Pascal String Table Part 3

| Index | Offset | Length| String |
|-------|--------|-------|--------|
| `$FF` | `$00F9`| `$14` | `FE 7B FF 73 D3 3F D7 FF DC FF B5 10 FE 58 FF 74 41 5D 4D 4E` |
| `$FE` | `$010E`| `$05` | `35 5C 68 48 37` |
| `$FD` | `$0114`| `$05` | `FF D2 3D FF E3 ` |
| `$FC` | `$011A`| `$08` | `BD B4 C7 9C AF F1 BE F1` |
| `$FB` | `$0123`| `$14` | `3A 44 58 FE 9F FF 60 FF C3 4E 10 FF 8B FF 60 FF 8B FF 25 4D` |
| `$FA` | `$0138`| `$04` | `85 A8 C9 81`|
| `$F9` | `$013D`| `$03` | `FF D5 62` |
| `$F8` | `$0141`| `$05` | `FF BF FF AC 4A` |
| `$F7` | `$0147`| `$04` | `FF D6 FF CA` |
| `$F6` | `$014C`| `$04` | `FF E7 FF D4` |
| `$F5` | `$0151`| `$04` | `FF E0 FF C4` |
| `$F4` | `$0156`| `$06` | `FF AD FF AE FF DB` |
| `$F3` | `$015D`| `$03` | `5C 62 3E` |
| `$F2` | `$0161`| `$08` | `9C B2 A0 96 F1 4D FF E1` |
| `$F1` | `$016A`| `$04` | `1E F0 D1 F1` |
| `$F0` | `$016F`| `$03` | `82 C6 81` |
| `$EF` | `$0173`| `$03` | `35 62 44` |
| `$EE` | `$0177`| `$06` | `FF 1B FF BC FF 07` | 
| `$ED` | `$017E`| `$06` | `39 6E 67 37 3F 62` |
| `$EC` | `$0185`| `$06` | `FE 37 FE 60 FF E7` |
| `$EB` | `$018C`| `$05` | `39 FF B9 3F 62` |
| `$EA` | `$0192`| `$04` | `FF C1 3D 47` |
| `$E9` | `$0197`| `$07` | `81 94 A0 B4 88 FE CD` |
| `$E8` | `$019F`| `$04` | `FF C2 FD 67` |
| `$E7` | `$01A4`| `$05` | `91 B5 F1 A9 C0` |
| `$E6` | `$01AA`| `$06` | `9D A8 8A CF 90 F1` |
| `$E5` | `$01B1`| `$08` | `FF E0 FE 01 FF 7B FF 55` |
| `$E4` | `$01BA`| `$04` | `A1 95 86 90` |
| `$E3` | `$01BF`| `$03` | `39 53 38` |
| `$E2` | `$01C3`| `$03` | `BF B5 C7` |
| `$E1` | `$01C7`| `$03` | `35 44 40` |
| `$E0` | `$01CB`| `$04` | `FF CE FD 67` |
| `$DF` | `$01D0`| `$04` | `C3 82 81 95` |
| `$DE` | `$01D5`| `$04` | `FF 8E FF CF` |
| `$DD` | `$01DA`| `$04` | `40 3A 40 10` |
| `$DC` | `$01DF`| `$05` | `C8 86 A4 AB F1` |
| `$DB` | `$01E5`| `$06` | `83 AE 8A 3C 3F D7` |
| `$DA` | `$01EC`| `$04` | `FF E7 FF 58` |
| `$D9` | `$01F1`| `$04` | `AE CD AE CD` |
| `$D8` | `$01F6`| `$04` | `FF A7 FF E4` |
| `$D7` | `$01FB`| `$08` | `96 94 AB BB A8 8E A8 AE` |
| `$D6` | `$0204`| `$04` | `FF 77 FF 6D ` |
| `$D5` | `$0209`| `$03` | `C3 82 A4` |
| `$D4` | `$020D`| `$04` | `FF 51 3C 46` |
| `$D3` | `$0212`| `$03` | `FF E1 4D` |
| `$D2` | `$0216`| `$04` | `35 35 35 35` |
| `$D1` | `$021B`| `$03` | `45 65 62` |
| `$D0` | `$021F`| `$03` | `75 57 10` |
| `$CF` | `$0223`| `$03` | `3E 3E 4E` |
| `$CE` | `$0227`| `$04` | `FF B4 FF D4` |
| `$CD` | `$022C`| `$09` | `FE FC 2E FE FB EC 18 FE FE` |

* The way this table is constructed it a bit roundabout, but ultimately the most important columns are Index and String, the other two are just used for finding and reading the string data but are included for context
    1. In the script data, when `$FD` is found, the next byte is then loaded and, and the Index column is scanned starting at row `$FF`
    2. Once the Index is located, the Offset value is loaded into memory
    3. The Offset value is then loaded against **REL**`$FDCA` which will get the Length byte of the corresponding string, and that is stored in memory
    4. The Offset value is used again by incrementing it once and the adding `$FDCA` to it's value and that resulting value is stored at **WRAM**`$00006`, aka the variable that's used to track where in a blob of text is currently being read from
        * A this point, the value at **WRAM**`$00006` is now configured to be a pointer to the beginning of the text data in the string
    5. The Length byte is checked if it's zero, and if not, decremented, and is used as a counter for reading in the remaining text bytes
    6. From here the string seems to be processed in the same way as regular script text, by doing a `JSR` to **loROM**`$818C2C`
        * Before the `JSR` it does check if the current byte is a `$FD` or higher (aka it's Kanji) and decrements the Length counter once more to indicate that two bytes are processed by the following routine. 
        * The Kanji processing routine _SHOULD_ also increment the pointer at **WRAM**`$00006` again as well, so that by the time the subroutine returns it's now pointing at the next byte after the Kanji bytes
    7. Once that subroutine finishes, execution is looped back to **loROM**`$818A78` where the Length counter is check again, and the next byte in the string is loaded if the counter is not 0. 
    8. Rinse repeat until string has been printed out fully!

* Format: Each string starts with 1 byte to indicate the number of bytes that make up the string, and the rest is the actual text data (corresponding to both regular and kanji) |
    * Index and offset data is stored between  **PRG**:`$117DF8-$117E90`/**loROM**`$A2FDF8-$A2FE90`
    * The string data for the above table is stored between **PRG**`$117EC3-$117FFF`/ **loROM**`$A2FEC3-$A2FFFF`
        * This is at the end of the `$A2` bank so it will definitely need to be relocated to somewhere else with more space when the time comes :/
* As an example `$E8` prints two characters "博士" (the first two characters of dialogue in the script) which themselves are both kanji, meaning the string requires 4 bytes 
* Per the romhacking forum notes, `$FD` contains pascal strings in addition to Kanji

## Graphics Lookup Tables

* All Tables and Offsets in this section are relative to **PRG**`$058000`. Both the lookup tables and the graphics data itself live in this region of ROM
* Each table is allocated 239 bytes in ROM, but not all of them are fully used. This is so that the smaller fonts still line up with the same character bytes used in the Full Width table

* Table Format: 
    * Index corresponds to a character byte in the script
    * Table Offset is the location within the table, that contains the Graphics Offset value for that character. This is calculated by taking the Index, subtracting `$10`, then doubling the value, and adding it with the corresponding Font Offset
        * For those curious why: The first 16 bytes of script bytes are all control codes, meaning there's no graphics data for them, so we subtract `$10` from the index, so that the table indexing lines up with the first drawable character. We then double it because each entry is two bytes, and the Font Offset comes from the Font Offset table (see [Font Offset Table](#font-offset-table)) |
    * The Graphics Offset for each index is stored in a table starting at **PRG**`$58000 + <Font Offset>`, so we use `$058000 + <Table Offset>` to get the Graphics Offset
    * Finally the Address is found by adding the Graphics Offset with `$058000`, which gives us the exact **PRG** address for the start of each respective character
    * Image is the 1bpp format tile extracted using a tile editor, for your viewing pleasure

### Font Offset Table

This table starts at exactly **PRG**`$058000` and only contains three entries, which correspond to each style of font (indicated by the control code read at the beginning of the text chunk)

| Index | Font Offset | Style | Code |
|-------|-------------|-------|------|
| `$00` | `$0006`     | [8x8](#8x8-text-table)         | `$01`|
| `$01` | `$01E6`     | [Half](#half-width-text-table) | `$02`|
| `$02` | `$03C6`     | [Full](#full-width-text-table) | `$03`|

The Font Offset is the Offset of the Lookup Table for that font, not for the font graphics itself

### 8x8 Text Table

| Index | Table Offset | Graphics Offset | Address   | Image | Character |
|-------|--------------|-----------------|-----------|-------|-----------|
| `$10` | `$0006`      | `$0FA6`         | `$058FA6` | ![](images/8x8/blank.png) |
| `$11` | `$0008`      | `$0FAE`         | `$058FAE` | ![](images/8x8/0x11.png) |
| `$12` | `$000A`      | `$0FB6`         | `$058FB6` | ![](images/8x8/0x12.png) |
| `$13` | `$000C`      | `$0FBE`         | `$058FBE` | ![](images/8x8/0x13.png) |
| `$14` | `$000E`      | `$0FC6`         | `$058FC6` | ![](images/8x8/0x14.png) |
| `$15` | `$0010`      | `$0FCE`         | `$058FCE` | ![](images/8x8/0x15.png) |
| `$16` | `$0012`      | `$0FD6`         | `$058FD6` | ![](images/8x8/0x16.png) |
| `$17` | `$0014`      | `$0FDE`         | `$058FDE` | ![](images/8x8/0x17.png) |
| `$18` | `$0016`      | `$0FE6`         | `$058FE6` | ![](images/8x8/0x18.png) |
| `$19` | `$0018`      | `$0FEE`         | `$058FEE` | ![](images/8x8/0x19.png) |
| `$1A` | `$001A`      | `$0FF6`         | `$058FF6` | ![](images/8x8/0x1A.png) |
| `$1D` | `$0020`      | `$0FFE`         | `$058FFE` | ![](images/8x8/0x1D.png) |
| `$1F` | `$0024`      | `$1006`         | `$059006` | ![](images/8x8/0x1F.png) |
| `$22` | `$002A`      | `$100E`         | `$05900E` | ![](images/8x8/0x22.png) |
| `$26` | `$0032`      | `$1016`         | `$059016` | ![](images/8x8/0x26.png) |
| `$27` | `$0034`      | `$101E`         | `$05901E` | ![](images/8x8/0x27.png) |
| `$30` | `$0046`      | `$1026`         | `$059026` | ![](images/8x8/0x30.png) |
| `$35` | `$0050`      | `$102E`         | `$05902E` | ![](images/8x8/0x35.png) |
| `$36` | `$0052`      | `$1036`         | `$059036` | ![](images/8x8/0x36.png) |
| `$37` | `$0054`      | `$103E`         | `$05903E` | ![](images/8x8/0x37.png) |
| `$38` | `$0056`      | `$1046`         | `$059046` | ![](images/8x8/0x38.png) |
| `$39` | `$0058`      | `$104E`         | `$05904E` | ![](images/8x8/0x39.png) |
| `$3A` | `$005A`      | `$1056`         | `$059056` | ![](images/8x8/0x3A.png) |
| `$3B` | `$005C`      | `$105E`         | `$05905E` | ![](images/8x8/0x3B.png) |
| `$3C` | `$005E`      | `$1066`         | `$059066` | ![](images/8x8/0x3C.png) |
| `$3D` | `$0060`      | `$106E`         | `$05906E` | ![](images/8x8/0x3D.png) |
| `$3E` | `$0062`      | `$1076`         | `$059076` | ![](images/8x8/0x3E.png) |
| `$3F` | `$0064`      | `$107E`         | `$05907E` | ![](images/8x8/0x3F.png) |
| `$40` | `$0066`      | `$1086`         | `$059086` | ![](images/8x8/0x40.png) |
| `$41` | `$0068`      | `$108E`         | `$05908E` | ![](images/8x8/0x41.png) |
| `$42` | `$006A`      | `$1096`         | `$059096` | ![](images/8x8/0x42.png) |
| `$43` | `$006C`      | `$109E`         | `$05909E` | ![](images/8x8/0x43.png) |
| `$44` | `$006E`      | `$10A6`         | `$0590A6` | ![](images/8x8/0x44.png) |
| `$45` | `$0070`      | `$10AE`         | `$0590AE` | ![](images/8x8/0x45.png) |
| `$46` | `$0072`      | `$10B6`         | `$0590B6` | ![](images/8x8/0x46.png) |
| `$47` | `$0074`      | `$10BE`         | `$0590BE` | ![](images/8x8/0x47.png) |
| `$48` | `$0076`      | `$10C6`         | `$0590C6` | ![](images/8x8/0x48.png) |
| `$49` | `$0078`      | `$10CE`         | `$0590CE` | ![](images/8x8/0x49.png) |
| `$4A` | `$007A`      | `$10D6`         | `$0590D6` | ![](images/8x8/0x4A.png) |
| `$4B` | `$007C`      | `$10DE`         | `$0590DE` | ![](images/8x8/0x4B.png) |
| `$4C` | `$007E`      | `$10E6`         | `$0590E6` | ![](images/8x8/0x4C.png) |
| `$4D` | `$0080`      | `$10EE`         | `$0590EE` | ![](images/8x8/0x4D.png) |
| `$4E` | `$0082`      | `$10F6`         | `$0590F6` | ![](images/8x8/0x4E.png) |
| `$4F` | `$0084`      | `$10FE`         | `$0590FE` | ![](images/8x8/0x4F.png) |
| `$50` | `$0086`      | `$1106`         | `$059106` | ![](images/8x8/0x50.png) |
| `$51` | `$0088`      | `$110E`         | `$05910E` | ![](images/8x8/0x51.png) |
| `$52` | `$008A`      | `$1116`         | `$059116` | ![](images/8x8/0x52.png) |
| `$53` | `$008C`      | `$111E`         | `$05911E` | ![](images/8x8/0x53.png) |
| `$54` | `$008E`      | `$1126`         | `$059126` | ![](images/8x8/0x54.png) |
| `$55` | `$0090`      | `$112E`         | `$05912E` | ![](images/8x8/0x55.png) |
| `$56` | `$0092`      | `$1136`         | `$059136` | ![](images/8x8/0x56.png) |
| `$57` | `$0094`      | `$113E`         | `$05913E` | ![](images/8x8/0x57.png) |
| `$58` | `$0096`      | `$1146`         | `$059146` | ![](images/8x8/0x58.png) |
| `$59` | `$0098`      | `$114E`         | `$05914E` | ![](images/8x8/0x59.png) |
| `$5A` | `$009A`      | `$1156`         | `$059156` | ![](images/8x8/0x5A.png) |
| `$5B` | `$009C`      | `$115E`         | `$05915E` | ![](images/8x8/0x5B.png) |
| `$5C` | `$009E`      | `$1166`         | `$059166` | ![](images/8x8/0x5C.png) |
| `$5D` | `$00A0`      | `$116E`         | `$05916E` | ![](images/8x8/0x5D.png) |
| `$5E` | `$00A2`      | `$1176`         | `$059176` | ![](images/8x8/0x5E.png) |
| `$5F` | `$00A4`      | `$117E`         | `$05917E` | ![](images/8x8/0x5F.png) |
| `$60` | `$00A6`      | `$1186`         | `$059186` | ![](images/8x8/0x60.png) |
| `$61` | `$00A8`      | `$118E`         | `$05918E` | ![](images/8x8/0x61.png) |
| `$62` | `$00AA`      | `$1196`         | `$059196` | ![](images/8x8/0x62.png) |
| `$68` | `$00B6`      | `$119E`         | `$05919E` | ![](images/8x8/0x68.png) |
| `$69` | `$00B8`      | `$11A6`         | `$0591A6` | ![](images/8x8/0x69.png) |
| `$6A` | `$00BA`      | `$11AE`         | `$0591AE` | ![](images/8x8/0x6A.png) |
| `$6B` | `$00BC`      | `$11B6`         | `$0591B6` | ![](images/8x8/0x6B.png) |
| `$6C` | `$00BE`      | `$11BE`         | `$0591BE` | ![](images/8x8/0x6C.png) |
| `$6D` | `$00C0`      | `$11C6`         | `$0591C6` | ![](images/8x8/0x6D.png) |
| `$6E` | `$00C2`      | `$11CE`         | `$0591CE` | ![](images/8x8/0x6E.png) |
| `$6F` | `$00C4`      | `$11D6`         | `$0591D6` | ![](images/8x8/0x6F.png) |
| `$70` | `$00C6`      | `$11DE`         | `$0591DE` | ![](images/8x8/0x70.png) |
| `$71` | `$00C8`      | `$11E6`         | `$0591E6` | ![](images/8x8/0x71.png) |
| `$72` | `$00CA`      | `$11EE`         | `$0591EE` | ![](images/8x8/0x72.png) |
| `$73` | `$00CC`      | `$11F6`         | `$0591F6` | ![](images/8x8/0x73.png) |
| `$74` | `$00CE`      | `$11FE`         | `$0591FE` | ![](images/8x8/0x74.png) |
| `$75` | `$00D0`      | `$1206`         | `$059206` | ![](images/8x8/0x75.png) |
| `$76` | `$00D2`      | `$120E`         | `$05920E` | ![](images/8x8/0x76.png) |
| `$77` | `$00D4`      | `$1216`         | `$059216` | ![](images/8x8/0x77.png) |
| `$78` | `$00D6`      | `$121E`         | `$05921E` | ![](images/8x8/0x78.png) |
| `$79` | `$00D8`      | `$1226`         | `$059226` | ![](images/8x8/0x79.png) |
| `$7A` | `$00DA`      | `$122E`         | `$05922E` | ![](images/8x8/0x7A.png) |
| `$7B` | `$00DC`      | `$1236`         | `$059236` | ![](images/8x8/0x7B.png) |
| `$7C` | `$00DE`      | `$123E`         | `$05923E` | ![](images/8x8/0x7C.png) |
| `$7D` | `$00E0`      | `$1246`         | `$059246` | ![](images/8x8/0x7D.png) |
| `$7E` | `$00E2`      | `$124E`         | `$05924E` | ![](images/8x8/0x7E.png) |
| `$7F` | `$00E4`      | `$1256`         | `$059256` | ![](images/8x8/0x7F.png) |
| `$80` | `$00E6`      | `$125E`         | `$05925E` | ![](images/8x8/0x80.png) |
| `$8A` | `$00FA`      | `$1266`         | `$059266` | ![](images/8x8/0x8A.png) |
| `$AE` | `$0142`      | `$126E`         | `$05926E` | ![](images/8x8/0xAE.png) |
| `$DA` | `$019A`      | `$1276`         | `$059276` | ![](images/8x8/0xDA.png) |
| `$DE` | `$01A2`      | `$127E`         | `$05927E` | ![](images/8x8/0xDE.png) |
| `$E0` | `$01A6`      | `$1286`         | `$059286` | ![](images/8x8/0xE0.png) |
| `$E1` | `$01A8`      | `$128E`         | `$05928E` | ![](images/8x8/0xE1.png) |
| `$E3` | `$01AC`      | `$1296`         | `$059296` | ![](images/8x8/0xE3.png) |
| `$E6` | `$01B2`      | `$129E`         | `$05929E` | ![](images/8x8/0xE6.png) |
| `$E7` | `$01B4`      | `$12A6`         | `$0592A6` | ![](images/8x8/0xE7.png) |
| `$E8` | `$01B6`      | `$12AE`         | `$0592AE` | ![](images/8x8/0xE8.png) |
| `$E9` | `$01B8`      | `$12B6`         | `$0592B6` | ![](images/8x8/0xE9.png) |
| `$EA` | `$01BA`      | `$12BE`         | `$0592BE` | ![](images/8x8/0xEA.png) |

* Character tiles here are 8x8 pixels, 1bpp format, and 8 bytes each
* Empty entries in this table were removed for readability, since more than half were unused, and in the graphics data there are no unmapped but still present tiles

### Half Width Text Table

| Index | Table Offset | Graphics Offset | Address   | Image | Character |
|-------|--------------|-----------------|-----------|-------|-----------|
| `$10` | `$01E8`      | `$12C6`         | `$0592D2` | ![](images/half_width/blank.png) |
| `$11` | `$01E8`      | `$12D2`         | `$0592D2` | ![](images/half_width/0x11.png) |
| `$12` | `$01EA`      | `$12DE`         | `$0592DE` | ![](images/half_width/0x12.png) |
| `$13` | `$01EC`      | `$12EA`         | `$0592EA` | ![](images/half_width/0x13.png) |
| `$14` | `$01EE`      | `$12F6`         | `$0592F6` | ![](images/half_width/0x14.png) |
| `$15` | `$01F0`      | `$1302`         | `$059302` | ![](images/half_width/0x15.png) |
| `$16` | `$01F2`      | `$130E`         | `$05930E` | ![](images/half_width/0x16.png) |
| `$17` | `$01F4`      | `$131A`         | `$05931A` | ![](images/half_width/0x17.png) |
| `$18` | `$01F6`      | `$1326`         | `$059326` | ![](images/half_width/0x18.png) |
| `$19` | `$01F8`      | `$1332`         | `$059332` | ![](images/half_width/0x19.png) |
| `$1A` | `$01FA`      | `$133E`         | `$05933E` | ![](images/half_width/0x1A.png) |
| `$1B` | `$01FC`      | `$134A`         | `$05934A` | ![](images/half_width/0x1B.png) |
| `$1C` | `$01FE`      | `$1356`         | `$059356` | ![](images/half_width/0x1C.png) |
| `$1D` | `$0200`      | `$1362`         | `$059362` | ![](images/half_width/0x1D.png) |
| `$1E` | `$0202`      | `$136E`         | `$05936E` | ![](images/half_width/0x1E.png) |
| `$1F` | `$0204`      | `$137A`         | `$05937A` | ![](images/half_width/0x1F.png) |
| `$20` | `$0206`      | `$1386`         | `$059386` | ![](images/half_width/0x20.png) |
| `$21` | `$0208`      | `$1392`         | `$059392` | ![](images/half_width/0x21.png) |
| `$22` | `$020A`      | `$139E`         | `$05939E` | ![](images/half_width/0x22.png) |
| `$23` | `$020C`      | `$13AA`         | `$0593AA` | ![](images/half_width/0x23.png) |
| `$24` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/0x24.png) *** |
| `$25` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/0x25.png) *** |
| `$26` | `$0212`      | `$13CE`         | `$0593CE` | ![](images/half_width/0x26.png) |
| `$27` | `$0214`      | `$13DA`         | `$0593DA` | ![](images/half_width/0x27.png) |
| `$28` | `$0216`      | `$13E6`         | `$0593E6` | ![](images/half_width/0x28.png) |
| `$29` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/0x29.png) *** |
| `$2A` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/0x2A.png) *** |
| `$2B` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/0x2B.png) *** |
| `$2C` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/0x2C.png) *** |
| `$2D` | `$0220`      | `$1422`         | `$059422` | ![](images/half_width/0x2D.png) |
| `$2E` | `$0222`      | `$142E`         | `$05942E` | ![](images/half_width/0x2E.png) |
| `$2F` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/0x2F.png) *** |
| `$30` | `$0226`      | `$1446`         | `$059446` | ![](images/half_width/0x30.png) |
| `$31` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/0x31.png) *** |
| `$32` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/0x32.png) *** |
| `$33` | `$022C`      | `$146A`         | `$05946A` | ![](images/half_width/0x33.png) |
| `$34` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/0x34.png) *** |
| `$35` | `$0230`      | `$1482`         | `$059482` | ![](images/half_width/0x35.png) |
| `$36` | `$0232`      | `$148E`         | `$05948E` | ![](images/half_width/0x36.png) |
| `$37` | `$0234`      | `$149A`         | `$05949A` | ![](images/half_width/0x37.png) |
| `$38` | `$0236`      | `$14A6`         | `$0594A6` | ![](images/half_width/0x38.png) |
| `$39` | `$0238`      | `$14B2`         | `$0594B2` | ![](images/half_width/0x39.png) |
| `$3A` | `$023A`      | `$14BE`         | `$0594BE` | ![](images/half_width/0x3A.png) |
| `$3B` | `$023C`      | `$14CA`         | `$0594CA` | ![](images/half_width/0x3B.png) |
| `$3C` | `$023E`      | `$14D6`         | `$0594D6` | ![](images/half_width/0x3C.png) |
| `$3D` | `$0240`      | `$14E2`         | `$0594E2` | ![](images/half_width/0x3D.png) |
| `$3E` | `$0242`      | `$14EE`         | `$0594EE` | ![](images/half_width/0x3E.png) |
| `$3F` | `$0244`      | `$14FA`         | `$0594FA` | ![](images/half_width/0x3F.png) |
| `$40` | `$0246`      | `$1506`         | `$059506` | ![](images/half_width/0x40.png) |
| `$41` | `$0248`      | `$1512`         | `$059512` | ![](images/half_width/0x41.png) |
| `$42` | `$024A`      | `$151E`         | `$05951E` | ![](images/half_width/0x42.png) |
| `$43` | `$024C`      | `$152A`         | `$05952A` | ![](images/half_width/0x43.png) |
| `$44` | `$024E`      | `$1536`         | `$059536` | ![](images/half_width/0x44.png) |
| `$45` | `$0250`      | `$1542`         | `$059542` | ![](images/half_width/0x45.png) |
| `$46` | `$0252`      | `$154E`         | `$05954E` | ![](images/half_width/0x46.png) |
| `$47` | `$0254`      | `$155A`         | `$05955A` | ![](images/half_width/0x47.png) |
| `$48` | `$0256`      | `$1566`         | `$059566` | ![](images/half_width/0x48.png) |
| `$49` | `$0258`      | `$1572`         | `$059572` | ![](images/half_width/0x49.png) |
| `$4A` | `$025A`      | `$157E`         | `$05957E` | ![](images/half_width/0x4A.png) |
| `$4B` | `$025C`      | `$158A`         | `$05958A` | ![](images/half_width/0x4B.png) |
| `$4C` | `$025E`      | `$1596`         | `$059596` | ![](images/half_width/0x4C.png) |
| `$4D` | `$0260`      | `$15A2`         | `$0595A2` | ![](images/half_width/0x4D.png) |
| `$4E` | `$0262`      | `$15AE`         | `$0595AE` | ![](images/half_width/0x4E.png) |
| `$4F` | `$0264`      | `$15BA`         | `$0595BA` | ![](images/half_width/0x4F.png) |
| `$50` | `$0266`      | `$15C6`         | `$0595C6` | ![](images/half_width/0x50.png) |
| `$51` | `$0268`      | `$15D2`         | `$0595D2` | ![](images/half_width/0x51.png) |
| `$52` | `$026A`      | `$15DE`         | `$0595DE` | ![](images/half_width/0x52.png) |
| `$53` | `$026C`      | `$15EA`         | `$0595EA` | ![](images/half_width/0x53.png) |
| `$54` | `$026E`      | `$15F6`         | `$0595F6` | ![](images/half_width/0x54.png) |
| `$55` | `$0270`      | `$1602`         | `$059602` | ![](images/half_width/0x55.png) |
| `$56` | `$0272`      | `$160E`         | `$05960E` | ![](images/half_width/0x56.png) |
| `$57` | `$0274`      | `$161A`         | `$05961A` | ![](images/half_width/0x57.png) |
| `$58` | `$0276`      | `$1626`         | `$059626` | ![](images/half_width/0x58.png) |
| `$59` | `$0278`      | `$1632`         | `$059632` | ![](images/half_width/0x59.png) |
| `$5A` | `$027A`      | `$163E`         | `$05963E` | ![](images/half_width/0x5A.png) |
| `$5B` | `$027C`      | `$164A`         | `$05964A` | ![](images/half_width/0x5B.png) |
| `$5C` | `$027E`      | `$1656`         | `$059656` | ![](images/half_width/0x5C.png) |
| `$5D` | `$0280`      | `$1662`         | `$059662` | ![](images/half_width/0x5D.png) |
| `$5E` | `$0282`      | `$166E`         | `$05966E` | ![](images/half_width/0x5E.png) |
| `$5F` | `$0284`      | `$167A`         | `$05967A` | ![](images/half_width/0x5F.png) |
| `$60` | `$0286`      | `$1686`         | `$059686` | ![](images/half_width/0x60.png) |
| `$61` | `$0288`      | `$1692`         | `$059692` | ![](images/half_width/0x61.png) |
| `$62` | `$028A`      | `$169E`         | `$05969E` | ![](images/half_width/0x62.png) |
| `$63` | `$028C`      | `$16AA`         | `$0596AA` | ![](images/half_width/0x63.png) |
| `$64` | `$028E`      | `$16B6`         | `$0596B6` | ![](images/half_width/0x64.png) |
| `$65` | `$0290`      | `$16C2`         | `$0596C2` | ![](images/half_width/0x65.png) |
| `$66` | `$0292`      | `$16CE`         | `$0596CE` | ![](images/half_width/0x66.png) |
| `$67` | `$0294`      | `$16DA`         | `$0596DA` | ![](images/half_width/0x67.png) |
| `$68` | `$0296`      | `$16E6`         | `$0596E6` | ![](images/half_width/0x68.png) |
| `$69` | `$0298`      | `$16F2`         | `$0596F2` | ![](images/half_width/0x69.png) |
| `$6A` | `$029A`      | `$16FE`         | `$0596FE` | ![](images/half_width/0x6A.png) |
| `$6B` | `$029C`      | `$170A`         | `$05970A` | ![](images/half_width/0x6B.png) |
| `$6C` | `$029E`      | `$1716`         | `$059716` | ![](images/half_width/0x6C.png) |
| `$6D` | `$02A0`      | `$1722`         | `$059722` | ![](images/half_width/0x6D.png) |
| `$6E` | `$02A2`      | `$172E`         | `$05972E` | ![](images/half_width/0x6E.png) |
| `$6F` | `$02A4`      | `$173A`         | `$05973A` | ![](images/half_width/0x6F.png) |
| `$70` | `$02A6`      | `$1746`         | `$059746` | ![](images/half_width/0x70.png) |
| `$71` | `$02A8`      | `$1752`         | `$059752` | ![](images/half_width/0x71.png) |
| `$72` | `$02AA`      | `$175E`         | `$05975E` | ![](images/half_width/0x72.png) |
| `$73` | `$02AC`      | `$176A`         | `$05976A` | ![](images/half_width/0x73.png) |
| `$74` | `$02AE`      | `$1776`         | `$059776` | ![](images/half_width/0x74.png) |
| `$75` | `$02B0`      | `$1782`         | `$059782` | ![](images/half_width/0x75.png) |
| `$76` | `$02B2`      | `$178E`         | `$05978E` | ![](images/half_width/0x76.png) |
| `$77` | `$02B4`      | `$179A`         | `$05979A` | ![](images/half_width/0x77.png) |
| `$78` | `$02B6`      | `$17A6`         | `$0597A6` | ![](images/half_width/0x78.png) |
| `$79` | `$02B8`      | `$17B2`         | `$0597B2` | ![](images/half_width/0x79.png) |
| `$7A` | `$02BA`      | `$17BE`         | `$0597BE` | ![](images/half_width/0x7A.png) |
| `$7B` | `$02BC`      | `$17CA`         | `$0597CA` | ![](images/half_width/0x7B.png) |
| `$7C` | `$02BE`      | `$17D6`         | `$0597D6` | ![](images/half_width/0x7C.png) |
| `$7D` | `$02C0`      | `$17E2`         | `$0597E2` | ![](images/half_width/0x7D.png) |
| `$7E` | `$02C2`      | `$17EE`         | `$0597EE` | ![](images/half_width/0x7E.png) |
| `$7F` | `$02C4`      | `$17FA`         | `$0597FA` | ![](images/half_width/0x7F.png) |
| `$80` | `$02C6`      | `$1806`         | `$059806` | ![](images/half_width/0x80.png) |
| `$81` | `$02C8`      | `$1812`         | `$059812` | ![](images/half_width/0x81.png) |
| `$82` | `$02CA`      | `$181E`         | `$05981E` | ![](images/half_width/0x82.png) |
| `$83` | `$02CC`      | `$182A`         | `$05982A` | ![](images/half_width/0x83.png) |
| `$84` | `$02CE`      | `$1836`         | `$059836` | ![](images/half_width/0x84.png) |
| `$85` | `$02D0`      | `$1842`         | `$059842` | ![](images/half_width/0x85.png) |
| `$86` | `$02D2`      | `$184E`         | `$05984E` | ![](images/half_width/0x86.png) |
| `$87` | `$02D4`      | `$185A`         | `$05985A` | ![](images/half_width/0x87.png) |
| `$88` | `$02D6`      | `$1866`         | `$059866` | ![](images/half_width/0x88.png) |
| `$89` | `$02D8`      | `$1872`         | `$059872` | ![](images/half_width/0x89.png) |
| `$8A` | `$02DA`      | `$187E`         | `$05987E` | ![](images/half_width/0x8A.png) |
| `$8B` | `$02DC`      | `$188A`         | `$05988A` | ![](images/half_width/0x8B.png) |
| `$8C` | `$02DE`      | `$1896`         | `$059896` | ![](images/half_width/0x8C.png) |
| `$8D` | `$02E0`      | `$18A2`         | `$0598A2` | ![](images/half_width/0x8D.png) |
| `$8E` | `$02E2`      | `$18AE`         | `$0598AE` | ![](images/half_width/0x8E.png) |
| `$8F` | `$02E4`      | `$18BA`         | `$0598BA` | ![](images/half_width/0x8F.png) |
| `$90` | `$02E6`      | `$18C6`         | `$0598C6` | ![](images/half_width/0x90.png) |
| `$91` | `$02E8`      | `$18D2`         | `$0598D2` | ![](images/half_width/0x91.png) |
| `$92` | `$02EA`      | `$18DE`         | `$0598DE` | ![](images/half_width/0x92.png) |
| `$93` | `$02EC`      | `$18EA`         | `$0598EA` | ![](images/half_width/0x93.png) |
| `$94` | `$02EE`      | `$18F6`         | `$0598F6` | ![](images/half_width/0x94.png) |
| `$95` | `$02F0`      | `$1902`         | `$059902` | ![](images/half_width/0x95.png) |
| `$96` | `$02F2`      | `$190E`         | `$05990E` | ![](images/half_width/0x96.png) |
| `$97` | `$02F4`      | `$191A`         | `$05991A` | ![](images/half_width/0x97.png) |
| `$98` | `$02F6`      | `$1926`         | `$059926` | ![](images/half_width/0x98.png) |
| `$99` | `$02F8`      | `$1932`         | `$059932` | ![](images/half_width/0x99.png) |
| `$9A` | `$02FA`      | `$193E`         | `$05993E` | ![](images/half_width/0x9A.png) |
| `$9B` | `$02FC`      | `$194A`         | `$05994A` | ![](images/half_width/0x9B.png) |
| `$9C` | `$02FE`      | `$1956`         | `$059956` | ![](images/half_width/0x9C.png) |
| `$9D` | `$0300`      | `$1962`         | `$059962` | ![](images/half_width/0x9D.png) |
| `$9E` | `$0302`      | `$196E`         | `$05996E` | ![](images/half_width/0x9E.png) |
| `$9F` | `$0304`      | `$197A`         | `$05997A` | ![](images/half_width/0x9F.png) |
| `$A0` | `$0306`      | `$1986`         | `$059986` | ![](images/half_width/0xA0.png) |
| `$A1` | `$0308`      | `$1992`         | `$059992` | ![](images/half_width/0xA1.png) |
| `$A2` | `$030A`      | `$199E`         | `$05999E` | ![](images/half_width/0xA2.png) |
| `$A3` | `$030C`      | `$19AA`         | `$0599AA` | ![](images/half_width/0xA3.png) |
| `$A4` | `$030E`      | `$19B6`         | `$0599B6` | ![](images/half_width/0xA4.png) |
| `$A5` | `$0310`      | `$19C2`         | `$0599C2` | ![](images/half_width/0xA5.png) |
| `$A6` | `$0312`      | `$19CE`         | `$0599CE` | ![](images/half_width/0xA6.png) |
| `$A7` | `$0314`      | `$19DA`         | `$0599DA` | ![](images/half_width/0xA7.png) |
| `$A8` | `$0316`      | `$19E6`         | `$0599E6` | ![](images/half_width/0xA8.png) |
| `$A9` | `$0318`      | `$19F2`         | `$0599F2` | ![](images/half_width/0xA9.png) |
| `$AA` | `$031A`      | `$19FE`         | `$0599FE` | ![](images/half_width/0xAA.png) |
| `$AB` | `$031C`      | `$1A0A`         | `$059A0A` | ![](images/half_width/0xAB.png) |
| `$AC` | `$031E`      | `$1A16`         | `$059A16` | ![](images/half_width/0xAC.png) |
| `$AD` | `$0320`      | `$1A22`         | `$059A22` | ![](images/half_width/0xAD.png) |
| `$AE` | `$0322`      | `$1A2E`         | `$059A2E` | ![](images/half_width/0xAE.png) |
| `$AF` | `$0324`      | `$1A3A`         | `$059A3A` | ![](images/half_width/0xAF.png) |
| `$B0` | `$0326`      | `$1A46`         | `$059A46` | ![](images/half_width/0xB0.png) |
| `$B1` | `$0328`      | `$1A52`         | `$059A52` | ![](images/half_width/0xB1.png) |
| `$B2` | `$032A`      | `$1A5E`         | `$059A5E` | ![](images/half_width/0xB2.png) |
| `$B3` | `$032C`      | `$1A6A`         | `$059A6A` | ![](images/half_width/0xB3.png) |
| `$B4` | `$032E`      | `$1A76`         | `$059A76` | ![](images/half_width/0xB4.png) |
| `$B5` | `$0330`      | `$1A82`         | `$059A82` | ![](images/half_width/0xB5.png) |
| `$B6` | `$0332`      | `$1A8E`         | `$059A8E` | ![](images/half_width/0xB6.png) |
| `$B7` | `$0334`      | `$1A9A`         | `$059A9A` | ![](images/half_width/0xB7.png) |
| `$B8` | `$0336`      | `$1AA6`         | `$059AA6` | ![](images/half_width/0xB8.png) |
| `$B9` | `$0338`      | `$1AB2`         | `$059AB2` | ![](images/half_width/0xB9.png) |
| `$BA` | `$033A`      | `$1ABE`         | `$059ABE` | ![](images/half_width/0xBA.png) |
| `$BB` | `$033C`      | `$1ACA`         | `$059ACA` | ![](images/half_width/0xBB.png) |
| `$BC` | `$033E`      | `$1AD6`         | `$059AD6` | ![](images/half_width/0xBC.png) |
| `$BD` | `$0340`      | `$1AE2`         | `$059AE2` | ![](images/half_width/0xBD.png) |
| `$BE` | `$0342`      | `$1AEE`         | `$059AEE` | ![](images/half_width/0xBE.png) |
| `$BF` | `$0344`      | `$1AFA`         | `$059AFA` | ![](images/half_width/0xBF.png) |
| `$C0` | `$0346`      | `$1B06`         | `$059B06` | ![](images/half_width/0xC0.png) |
| `$C1` | `$0348`      | `$1B12`         | `$059B12` | ![](images/half_width/0xC1.png) |
| `$C2` | `$034A`      | `$1B1E`         | `$059B1E` | ![](images/half_width/0xC2.png) |
| `$C3` | `$034C`      | `$1B2A`         | `$059B2A` | ![](images/half_width/0xC3.png) |
| `$C4` | `$034E`      | `$1B36`         | `$059B36` | ![](images/half_width/0xC4.png) |
| `$C5` | `$0350`      | `$1B42`         | `$059B42` | ![](images/half_width/0xC5.png) |
| `$C6` | `$0352`      | `$1B4E`         | `$059B4E` | ![](images/half_width/0xC6.png) |
| `$C7` | `$0354`      | `$1B5A`         | `$059B5A` | ![](images/half_width/0xC7.png) |
| `$C8` | `$0356`      | `$1B66`         | `$059B66` | ![](images/half_width/0xC8.png) |
| `$C9` | `$0358`      | `$1B72`         | `$059B72` | ![](images/half_width/0xC9.png) |
| `$CA` | `$035A`      | `$1B7E`         | `$059B7E` | ![](images/half_width/0xCA.png) |
| `$CB` | `$035C`      | `$1B8A`         | `$059B8A` | ![](images/half_width/0xCB.png) |
| `$CC` | `$035E`      | `$1B96`         | `$059B96` | ![](images/half_width/0xCC.png) |
| `$CD` | `$0360`      | `$1BA2`         | `$059BA2` | ![](images/half_width/0xCD.png) |
| `$CE` | `$0362`      | `$1BAE`         | `$059BAE` | ![](images/half_width/0xCE.png) |
| `$CF` | `$0364`      | `$1BBA`         | `$059BBA` | ![](images/half_width/0xCF.png) |
| `$D0` | `$0366`      | `$1BC6`         | `$059BC6` | ![](images/half_width/0xD0.png) |
| `$D1` | `$0368`      | `$1BD2`         | `$059BD2` | ![](images/half_width/0xD1.png) |
| `$D2` | `$036A`      | `$1BDE`         | `$059BDE` | ![](images/half_width/0xD2.png) |
| `$D3` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$D4` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$D5` | `$0370`      | `$1BEA`         | `$059BEA` | ![](images/half_width/0xD5.png) |
| `$D6` | `$0372`      | `$1BF6`         | `$059BF6` | ![](images/half_width/0xD6.png) |
| `$D7` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$D8` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$D9` | `$0378`      | `$1C02`         | `$059C02` | ![](images/half_width/0xD9.png) |
| `$DA` | `$037A`      | `$1C0E`         | `$059C0E` | ![](images/half_width/0xDA.png) |
| `$DB` | `$037C`      | `$1C1A`         | `$059C1A` | ![](images/half_width/0xDB.png) |
| `$DC` | `$037E`      | `$1C26`         | `$059C26` | ![](images/half_width/0xDC.png) |
| `$DD` | `$0380`      | `$1C32`         | `$059C32` | ![](images/half_width/0xDD.png) |
| `$DE` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$DF` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$E0` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$E1` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$E2` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$E3` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$E4` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$E5` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$E6` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$E7` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$E8` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$E9` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$EA` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$EB` | `$039C`      | `$1C3E`         | `$059C3E` | ![](images/half_width/0xEB.png) |
| `$EC` | `$039E`      | `$1C4A`         | `$059C4A` | ![](images/half_width/0xEC.png) |
| `$ED` | `$03A0`      | `$1C56`         | `$059C56` | ![](images/half_width/0xED.png) |
| `$EE` | `$03A2`      | `$1C62`         | `$059C62` | ![](images/half_width/0xEE.png) |
| `$EF` | `$03A4`      | `$1C6E`         | `$059C6E` | ![](images/half_width/0xEF.png) |
| `$F0` | `$03A6`      | `$1C7A`         | `$059C7A` | ![](images/half_width/0xF0.png) |
| `$F1` | `$03A8`      | `$1C86`         | `$059C86` | ![](images/half_width/0xF1.png) |
| `$F2` | `$03AA`      | `$1C92`         | `$059C92` | ![](images/half_width/0xF2.png) |
| `$F3` | `$03AC`      | `$1C9E`         | `$059C9E` | ![](images/half_width/0xF3.png) |
| `$F4` | `$03AE`      | `$1CAA`         | `$059CAA` | ![](images/half_width/0xF4.png) |
| `$F5` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$F6` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$F7` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$F8` | `$03B6`      | `$1CB6`         | `$059CB6` | ![](images/half_width/0xF8.png) |
| `$F9` | `$03B8`      | `$1CC2`         | `$059CC2` | ![](images/half_width/0xF9.png) |
| `$FA` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$FB` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$FC` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$FD` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$FE` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |
| `$FF` | `$0000`      | `$0000`         | `N/A`     | ![](images/half_width/blank.png) |

*** *Tile data is present in ROM, but is not mapped by the Table*

* Character tiles here are 8x12 pixels, 1bpp format, and 12 bytes each

### Full Width Text Table

| Index | Table Offset | Graphics Offset | Address   | Image | Character |
|-------|--------------|-----------------|-----------|-------|-----------|
| `$10` | `$03C6`      | `$1CCE`         | `$059CCE` | ![](images/full_width_regular/blank.png)|   |
| `$11` | `$03C8`      | `$1CE6`         | `$059CE6` | ![](images/full_width_regular/0x11.png) | <span style="font-size:1.75em;">0</span> |
| `$12` | `$03CA`      | `$1CFE`         | `$059CFE` | ![](images/full_width_regular/0x12.png) |
| `$13` | `$03CC`      | `$1D16`         | `$059D16` | ![](images/full_width_regular/0x13.png) |
| `$14` | `$03CE`      | `$1D2E`         | `$059D2E` | ![](images/full_width_regular/0x14.png) |
| `$15` | `$03D0`      | `$1D46`         | `$059D46` | ![](images/full_width_regular/0x15.png) |
| `$16` | `$03D2`      | `$1D5E`         | `$059D5E` | ![](images/full_width_regular/0x16.png) |
| `$17` | `$03D4`      | `$1D76`         | `$059D76` | ![](images/full_width_regular/0x17.png) |
| `$18` | `$03D6`      | `$1D8E`         | `$059D8E` | ![](images/full_width_regular/0x18.png) |
| `$19` | `$03D8`      | `$1DA6`         | `$059DA6` | ![](images/full_width_regular/0x19.png) |
| `$1A` | `$03DA`      | `$1DBE`         | `$059DBE` | ![](images/full_width_regular/0x1A.png) |
| `$1B` | `$03DC`      | `$1DD6`         | `$059DD6` | ![](images/full_width_regular/0x1B.png) |
| `$1C` | `$03DE`      | `$1DEE`         | `$059DEE` | ![](images/full_width_regular/0x1C.png) |
| `$1D` | `$03E0`      | `$1E06`         | `$059E06` | ![](images/full_width_regular/0x1D.png) |
| `$1E` | `$03E2`      | `$1E1E`         | `$059E1E` | ![](images/full_width_regular/0x1E.png) |
| `$1F` | `$03E4`      | `$1E36`         | `$059E36` | ![](images/full_width_regular/0x1F.png) |
| `$20` | `$03E6`      | `$1E4E`         | `$059E4E` | ![](images/full_width_regular/0x20.png) |
| `$21` | `$03E8`      | `$1E66`         | `$059E66` | ![](images/full_width_regular/0x21.png) |
| `$22` | `$03EA`      | `$1E7E`         | `$059E7E` | ![](images/full_width_regular/0x22.png) |
| `$23` | `$03EC`      | `$1E96`         | `$059E96` | ![](images/full_width_regular/0x23.png) |
| `$24` | `$0000`      | `$0000`         | `$059EAE` | ![](images/full_width_regular/0x24.png) *** |
| `$25` | `$0000`      | `$0000`         | `$059EC6` | ![](images/full_width_regular/0x25.png) *** |
| `$26` | `$03F2`      | `$1EDE`         | `$059EDE` | ![](images/full_width_regular/0x26.png) |
| `$27` | `$03F4`      | `$1EF6`         | `$059EF6` | ![](images/full_width_regular/0x27.png) |
| `$28` | `$03F6`      | `$1F0E`         | `$059F0E` | ![](images/full_width_regular/0x28.png) |
| `$29` | `$0000`      | `$0000`         | `$059F26` | ![](images/full_width_regular/0x29.png) *** |
| `$2A` | `$0000`      | `$0000`         | `$059F3E` | ![](images/full_width_regular/0x2A.png) *** |
| `$2B` | `$0000`      | `$0000`         | `$059F56` | ![](images/full_width_regular/0x2B.png) *** |
| `$2C` | `$0000`      | `$0000`         | `$059F6E` | ![](images/full_width_regular/0x2C.png) *** |
| `$2D` | `$0400`      | `$1F86`         | `$059F86` | ![](images/full_width_regular/0x2D.png) |
| `$2E` | `$0402`      | `$1F9E`         | `$059F9E` | ![](images/full_width_regular/0x2E.png) |
| `$2F` | `$0000`      | `$0000`         | `$059FB6` | ![](images/full_width_regular/0x2F.png) *** |
| `$30` | `$0406`      | `$1FCE`         | `$059FCE` | ![](images/full_width_regular/0x30.png) |
| `$31` | `$0000`      | `$0000`         | `$059FE6` | ![](images/full_width_regular/0x31.png) *** |
| `$32` | `$0000`      | `$0000`         | `$059FFE` | ![](images/full_width_regular/0x32.png) *** |
| `$33` | `$040C`      | `$2016`         | `$05A016` | ![](images/full_width_regular/0x33.png) |
| `$34` | `$0000`      | `$0000`         | `$05A02E` | ![](images/full_width_regular/0x34.png) *** |
| `$35` | `$0410`      | `$2046`         | `$05A046` | ![](images/full_width_regular/0x35.png) |
| `$36` | `$0412`      | `$205E`         | `$05A05E` | ![](images/full_width_regular/0x36.png) |
| `$37` | `$0414`      | `$2076`         | `$05A076` | ![](images/full_width_regular/0x37.png) |
| `$38` | `$0416`      | `$208E`         | `$05A08E` | ![](images/full_width_regular/0x38.png) |
| `$39` | `$0418`      | `$20A6`         | `$05A0A6` | ![](images/full_width_regular/0x39.png) |
| `$3A` | `$041A`      | `$20BE`         | `$05A0BE` | ![](images/full_width_regular/0x3A.png) |
| `$3B` | `$041C`      | `$20D6`         | `$05A0D6` | ![](images/full_width_regular/0x3B.png) |
| `$3C` | `$041E`      | `$20EE`         | `$05A0EE` | ![](images/full_width_regular/0x3C.png) |
| `$3D` | `$0420`      | `$2106`         | `$05A106` | ![](images/full_width_regular/0x3D.png) |
| `$3E` | `$0422`      | `$211E`         | `$05A11E` | ![](images/full_width_regular/0x3E.png) |
| `$3F` | `$0424`      | `$2136`         | `$05A136` | ![](images/full_width_regular/0x3F.png) |
| `$40` | `$0426`      | `$214E`         | `$05A14E` | ![](images/full_width_regular/0x40.png) |
| `$41` | `$0428`      | `$2166`         | `$05A166` | ![](images/full_width_regular/0x41.png) |
| `$42` | `$042A`      | `$217E`         | `$05A17E` | ![](images/full_width_regular/0x42.png) |
| `$43` | `$042C`      | `$2196`         | `$05A196` | ![](images/full_width_regular/0x43.png) |
| `$44` | `$042E`      | `$21AE`         | `$05A1AE` | ![](images/full_width_regular/0x44.png) |
| `$45` | `$0430`      | `$21C6`         | `$05A1C6` | ![](images/full_width_regular/0x45.png) |
| `$46` | `$0432`      | `$21DE`         | `$05A1DE` | ![](images/full_width_regular/0x46.png) |
| `$47` | `$0434`      | `$21F6`         | `$05A1F6` | ![](images/full_width_regular/0x47.png) |
| `$48` | `$0436`      | `$220E`         | `$05A20E` | ![](images/full_width_regular/0x48.png) |
| `$49` | `$0438`      | `$2226`         | `$05A226` | ![](images/full_width_regular/0x49.png) |
| `$4A` | `$043A`      | `$223E`         | `$05A23E` | ![](images/full_width_regular/0x4A.png) |
| `$4B` | `$043C`      | `$2256`         | `$05A256` | ![](images/full_width_regular/0x4B.png) |
| `$4C` | `$043E`      | `$226E`         | `$05A26E` | ![](images/full_width_regular/0x4C.png) |
| `$4D` | `$0440`      | `$2286`         | `$05A286` | ![](images/full_width_regular/0x4D.png) |
| `$4E` | `$0442`      | `$229E`         | `$05A29E` | ![](images/full_width_regular/0x4E.png) |
| `$4F` | `$0444`      | `$22B6`         | `$05A2B6` | ![](images/full_width_regular/0x4F.png) |
| `$50` | `$0446`      | `$22CE`         | `$05A2CE` | ![](images/full_width_regular/0x50.png) |
| `$51` | `$0448`      | `$22E6`         | `$05A2E6` | ![](images/full_width_regular/0x51.png) |
| `$52` | `$044A`      | `$22FE`         | `$05A2FE` | ![](images/full_width_regular/0x52.png) |
| `$53` | `$044C`      | `$2316`         | `$05A316` | ![](images/full_width_regular/0x53.png) |
| `$54` | `$044E`      | `$232E`         | `$05A32E` | ![](images/full_width_regular/0x54.png) |
| `$55` | `$0450`      | `$2346`         | `$05A346` | ![](images/full_width_regular/0x55.png) |
| `$56` | `$0452`      | `$235E`         | `$05A35E` | ![](images/full_width_regular/0x56.png) |
| `$57` | `$0454`      | `$2376`         | `$05A376` | ![](images/full_width_regular/0x57.png) |
| `$58` | `$0456`      | `$238E`         | `$05A38E` | ![](images/full_width_regular/0x58.png) |
| `$59` | `$0458`      | `$23A6`         | `$05A3A6` | ![](images/full_width_regular/0x59.png) |
| `$5A` | `$045A`      | `$23BE`         | `$05A3BE` | ![](images/full_width_regular/0x5A.png) |
| `$5B` | `$045C`      | `$23D6`         | `$05A3D6` | ![](images/full_width_regular/0x5B.png) |
| `$5C` | `$045E`      | `$23EE`         | `$05A3EE` | ![](images/full_width_regular/0x5C.png) |
| `$5D` | `$0460`      | `$2406`         | `$05A406` | ![](images/full_width_regular/0x5D.png) |
| `$5E` | `$0462`      | `$241E`         | `$05A41E` | ![](images/full_width_regular/0x5E.png) |
| `$5F` | `$0464`      | `$2436`         | `$05A436` | ![](images/full_width_regular/0x5F.png) |
| `$60` | `$0466`      | `$244E`         | `$05A44E` | ![](images/full_width_regular/0x60.png) |
| `$61` | `$0468`      | `$2466`         | `$05A466` | ![](images/full_width_regular/0x61.png) |
| `$62` | `$046A`      | `$247E`         | `$05A47E` | ![](images/full_width_regular/0x62.png) |
| `$63` | `$046C`      | `$2496`         | `$05A496` | ![](images/full_width_regular/0x63.png) |
| `$64` | `$046E`      | `$24AE`         | `$05A4AE` | ![](images/full_width_regular/0x64.png) |
| `$65` | `$0470`      | `$24C6`         | `$05A4C6` | ![](images/full_width_regular/0x65.png) |
| `$66` | `$0472`      | `$24DE`         | `$05A4DE` | ![](images/full_width_regular/0x66.png) |
| `$67` | `$0474`      | `$24F6`         | `$05A4F6` | ![](images/full_width_regular/0x67.png) |
| `$68` | `$0476`      | `$250E`         | `$05A50E` | ![](images/full_width_regular/0x68.png) |
| `$69` | `$0478`      | `$2526`         | `$05A526` | ![](images/full_width_regular/0x69.png) |
| `$6A` | `$047A`      | `$253E`         | `$05A53E` | ![](images/full_width_regular/0x6A.png) |
| `$6B` | `$047C`      | `$2556`         | `$05A556` | ![](images/full_width_regular/0x6B.png) |
| `$6C` | `$047E`      | `$256E`         | `$05A56E` | ![](images/full_width_regular/0x6C.png) |
| `$6D` | `$0480`      | `$2586`         | `$05A586` | ![](images/full_width_regular/0x6D.png) |
| `$6E` | `$0482`      | `$259E`         | `$05A59E` | ![](images/full_width_regular/0x6E.png) |
| `$6F` | `$0484`      | `$25B6`         | `$05A5B6` | ![](images/full_width_regular/0x6F.png) |
| `$70` | `$0486`      | `$25CE`         | `$05A5CE` | ![](images/full_width_regular/0x70.png) |
| `$71` | `$0488`      | `$25E6`         | `$05A5E6` | ![](images/full_width_regular/0x71.png) |
| `$72` | `$048A`      | `$25FE`         | `$05A5FE` | ![](images/full_width_regular/0x72.png) |
| `$73` | `$048C`      | `$2616`         | `$05A616` | ![](images/full_width_regular/0x73.png) |
| `$74` | `$048E`      | `$262E`         | `$05A62E` | ![](images/full_width_regular/0x74.png) |
| `$75` | `$0490`      | `$2646`         | `$05A646` | ![](images/full_width_regular/0x75.png) |
| `$76` | `$0492`      | `$265E`         | `$05A65E` | ![](images/full_width_regular/0x76.png) |
| `$77` | `$0494`      | `$2676`         | `$05A676` | ![](images/full_width_regular/0x77.png) |
| `$78` | `$0496`      | `$268E`         | `$05A68E` | ![](images/full_width_regular/0x78.png) |
| `$79` | `$0498`      | `$26A6`         | `$05A6A6` | ![](images/full_width_regular/0x79.png) |
| `$7A` | `$049A`      | `$26BE`         | `$05A6BE` | ![](images/full_width_regular/0x7A.png) |
| `$7B` | `$049C`      | `$26D6`         | `$05A6D6` | ![](images/full_width_regular/0x7B.png) |
| `$7C` | `$049E`      | `$26EE`         | `$05A6EE` | ![](images/full_width_regular/0x7C.png) |
| `$7D` | `$04A0`      | `$2706`         | `$05A706` | ![](images/full_width_regular/0x7D.png) |
| `$7E` | `$04A2`      | `$271E`         | `$05A71E` | ![](images/full_width_regular/0x7E.png) |
| `$7F` | `$04A4`      | `$2736`         | `$05A736` | ![](images/full_width_regular/0x7F.png) |
| `$80` | `$04A6`      | `$274E`         | `$05A74E` | ![](images/full_width_regular/0x80.png) |
| `$81` | `$04A8`      | `$2766`         | `$05A766` | ![](images/full_width_regular/0x81.png) |
| `$82` | `$04AA`      | `$277E`         | `$05A77E` | ![](images/full_width_regular/0x82.png) |
| `$83` | `$04AC`      | `$2796`         | `$05A796` | ![](images/full_width_regular/0x83.png) |
| `$84` | `$04AE`      | `$27AE`         | `$05A7AE` | ![](images/full_width_regular/0x84.png) |
| `$85` | `$04B0`      | `$27C6`         | `$05A7C6` | ![](images/full_width_regular/0x85.png) |
| `$86` | `$04B2`      | `$27DE`         | `$05A7DE` | ![](images/full_width_regular/0x86.png) |
| `$87` | `$04B4`      | `$27F6`         | `$05A7F6` | ![](images/full_width_regular/0x87.png) |
| `$88` | `$04B6`      | `$280E`         | `$05A80E` | ![](images/full_width_regular/0x88.png) |
| `$89` | `$04B8`      | `$2826`         | `$05A826` | ![](images/full_width_regular/0x89.png) |
| `$8A` | `$04BA`      | `$283E`         | `$05A83E` | ![](images/full_width_regular/0x8A.png) |
| `$8B` | `$04BC`      | `$2856`         | `$05A856` | ![](images/full_width_regular/0x8B.png) |
| `$8C` | `$04BE`      | `$286E`         | `$05A86E` | ![](images/full_width_regular/0x8C.png) |
| `$8D` | `$04C0`      | `$2886`         | `$05A886` | ![](images/full_width_regular/0x8D.png) |
| `$8E` | `$04C2`      | `$289E`         | `$05A89E` | ![](images/full_width_regular/0x8E.png) |
| `$8F` | `$04C4`      | `$28B6`         | `$05A8B6` | ![](images/full_width_regular/0x8F.png) |
| `$90` | `$04C6`      | `$28CE`         | `$05A8CE` | ![](images/full_width_regular/0x90.png) |
| `$91` | `$04C8`      | `$28E6`         | `$05A8E6` | ![](images/full_width_regular/0x91.png) |
| `$92` | `$04CA`      | `$28FE`         | `$05A8FE` | ![](images/full_width_regular/0x92.png) |
| `$93` | `$04CC`      | `$2916`         | `$05A916` | ![](images/full_width_regular/0x93.png) |
| `$94` | `$04CE`      | `$292E`         | `$05A92E` | ![](images/full_width_regular/0x94.png) |
| `$95` | `$04D0`      | `$2946`         | `$05A946` | ![](images/full_width_regular/0x95.png) |
| `$96` | `$04D2`      | `$295E`         | `$05A95E` | ![](images/full_width_regular/0x96.png) |
| `$97` | `$04D4`      | `$2976`         | `$05A976` | ![](images/full_width_regular/0x97.png) |
| `$98` | `$04D6`      | `$298E`         | `$05A98E` | ![](images/full_width_regular/0x98.png) |
| `$99` | `$04D8`      | `$29A6`         | `$05A9A6` | ![](images/full_width_regular/0x99.png) |
| `$9A` | `$04DA`      | `$29BE`         | `$05A9BE` | ![](images/full_width_regular/0x9A.png) |
| `$9B` | `$04DC`      | `$29D6`         | `$05A9D6` | ![](images/full_width_regular/0x9B.png) |
| `$9C` | `$04DE`      | `$29EE`         | `$05A9EE` | ![](images/full_width_regular/0x9C.png) |
| `$9D` | `$04E0`      | `$2A06`         | `$05AA06` | ![](images/full_width_regular/0x9D.png) |
| `$9E` | `$04E2`      | `$2A1E`         | `$05AA1E` | ![](images/full_width_regular/0x9E.png) |
| `$9F` | `$04E4`      | `$2A36`         | `$05AA36` | ![](images/full_width_regular/0x9F.png) |
| `$A0` | `$04E6`      | `$2A4E`         | `$05AA4E` | ![](images/full_width_regular/0xA0.png) |
| `$A1` | `$04E8`      | `$2A66`         | `$05AA66` | ![](images/full_width_regular/0xA1.png) |
| `$A2` | `$04EA`      | `$2A7E`         | `$05AA7E` | ![](images/full_width_regular/0xA2.png) |
| `$A3` | `$04EC`      | `$2A96`         | `$05AA96` | ![](images/full_width_regular/0xA3.png) |
| `$A4` | `$04EE`      | `$2AAE`         | `$05AAAE` | ![](images/full_width_regular/0xA4.png) |
| `$A5` | `$04F0`      | `$2AC6`         | `$05AAC6` | ![](images/full_width_regular/0xA5.png) |
| `$A6` | `$04F2`      | `$2ADE`         | `$05AADE` | ![](images/full_width_regular/0xA6.png) |
| `$A7` | `$04F4`      | `$2AF6`         | `$05AAF6` | ![](images/full_width_regular/0xA7.png) |
| `$A8` | `$04F6`      | `$2B0E`         | `$05AB0E` | ![](images/full_width_regular/0xA8.png) |
| `$A9` | `$04F8`      | `$2B26`         | `$05AB26` | ![](images/full_width_regular/0xA9.png) |
| `$AA` | `$04FA`      | `$2B3E`         | `$05AB3E` | ![](images/full_width_regular/0xAA.png) |
| `$AB` | `$04FC`      | `$2B56`         | `$05AB56` | ![](images/full_width_regular/0xAB.png) |
| `$AC` | `$04FE`      | `$2B6E`         | `$05AB6E` | ![](images/full_width_regular/0xAC.png) |
| `$AD` | `$0500`      | `$2B86`         | `$05AB86` | ![](images/full_width_regular/0xAD.png) |
| `$AE` | `$0502`      | `$2B9E`         | `$05AB9E` | ![](images/full_width_regular/0xAE.png) |
| `$AF` | `$0504`      | `$2BB6`         | `$05ABB6` | ![](images/full_width_regular/0xAF.png) |
| `$B0` | `$0506`      | `$2BCE`         | `$05ABCE` | ![](images/full_width_regular/0xB0.png) |
| `$B1` | `$0508`      | `$2BE6`         | `$05ABE6` | ![](images/full_width_regular/0xB1.png) |
| `$B2` | `$050A`      | `$2BFE`         | `$05ABFE` | ![](images/full_width_regular/0xB2.png) |
| `$B3` | `$050C`      | `$2C16`         | `$05AC16` | ![](images/full_width_regular/0xB3.png) |
| `$B4` | `$050E`      | `$2C2E`         | `$05AC2E` | ![](images/full_width_regular/0xB4.png) |
| `$B5` | `$0510`      | `$2C46`         | `$05AC46` | ![](images/full_width_regular/0xB5.png) |
| `$B6` | `$0512`      | `$2C5E`         | `$05AC5E` | ![](images/full_width_regular/0xB6.png) |
| `$B7` | `$0514`      | `$2C76`         | `$05AC76` | ![](images/full_width_regular/0xB7.png) |
| `$B8` | `$0516`      | `$2C8E`         | `$05AC8E` | ![](images/full_width_regular/0xB8.png) |
| `$B9` | `$0518`      | `$2CA6`         | `$05ACA6` | ![](images/full_width_regular/0xB9.png) |
| `$BA` | `$051A`      | `$2CBE`         | `$05ACBE` | ![](images/full_width_regular/0xBA.png) |
| `$BB` | `$051C`      | `$2CD6`         | `$05ACD6` | ![](images/full_width_regular/0xBB.png) |
| `$BC` | `$051E`      | `$2CEE`         | `$05ACEE` | ![](images/full_width_regular/0xBC.png) |
| `$BD` | `$0520`      | `$2D06`         | `$05AD06` | ![](images/full_width_regular/0xBD.png) |
| `$BE` | `$0522`      | `$2D1E`         | `$05AD1E` | ![](images/full_width_regular/0xBE.png) |
| `$BF` | `$0524`      | `$2D36`         | `$05AD36` | ![](images/full_width_regular/0xBF.png) |
| `$C0` | `$0526`      | `$2D4E`         | `$05AD4E` | ![](images/full_width_regular/0xC0.png) |
| `$C1` | `$0528`      | `$2D66`         | `$05AD66` | ![](images/full_width_regular/0xC1.png) |
| `$C2` | `$052A`      | `$2D7E`         | `$05AD7E` | ![](images/full_width_regular/0xC2.png) |
| `$C3` | `$052C`      | `$2D96`         | `$05AD96` | ![](images/full_width_regular/0xC3.png) |
| `$C4` | `$052E`      | `$2DAE`         | `$05ADAE` | ![](images/full_width_regular/0xC4.png) |
| `$C5` | `$0530`      | `$2DC6`         | `$05ADC6` | ![](images/full_width_regular/0xC5.png) |
| `$C6` | `$0532`      | `$2DDE`         | `$05ADDE` | ![](images/full_width_regular/0xC6.png) |
| `$C7` | `$0534`      | `$2DF6`         | `$05ADF6` | ![](images/full_width_regular/0xC7.png) |
| `$C8` | `$0536`      | `$2E0E`         | `$05AE0E` | ![](images/full_width_regular/0xC8.png) |
| `$C9` | `$0538`      | `$2E26`         | `$05AE26` | ![](images/full_width_regular/0xC9.png) |
| `$CA` | `$053A`      | `$2E3E`         | `$05AE3E` | ![](images/full_width_regular/0xCA.png) |
| `$CB` | `$053C`      | `$2E56`         | `$05AE56` | ![](images/full_width_regular/0xCB.png) |
| `$CC` | `$053E`      | `$2E6E`         | `$05AE6E` | ![](images/full_width_regular/0xCC.png) |
| `$CD` | `$0540`      | `$2E86`         | `$05AE86` | ![](images/full_width_regular/0xCD.png) |
| `$CE` | `$0542`      | `$2E9E`         | `$05AE9E` | ![](images/full_width_regular/0xCE.png) |
| `$CF` | `$0544`      | `$2EB6`         | `$05AEB6` | ![](images/full_width_regular/0xCF.png) |
| `$D0` | `$0546`      | `$2ECE`         | `$05AECE` | ![](images/full_width_regular/0xD0.png) |
| `$D1` | `$0548`      | `$2EE6`         | `$05AEE6` | ![](images/full_width_regular/0xD1.png) |
| `$D2` | `$054A`      | `$2EFE`         | `$05AEFE` | ![](images/full_width_regular/0xD2.png) |
| `$D3` | `$054C`      | `$2F16`         | `$05AF16` | ![](images/full_width_regular/0xD3.png) |
| `$D4` | `$054E`      | `$2F2E`         | `$05AF2E` | ![](images/full_width_regular/0xD4.png) |
| `$D5` | `$0550`      | `$2F46`         | `$05AF46` | ![](images/full_width_regular/0xD5.png) |
| `$D6` | `$0552`      | `$2F5E`         | `$05AF5E` | ![](images/full_width_regular/0xD6.png) |
| `$D7` | `$0554`      | `$2F76`         | `$05AF76` | ![](images/full_width_regular/0xD7.png) |
| `$D8` | `$0556`      | `$2F8E`         | `$05AF8E` | ![](images/full_width_regular/0xD8.png) |
| `$D9` | `$0558`      | `$2FA6`         | `$05AFA6` | ![](images/full_width_regular/0xD9.png) |
| `$DA` | `$055A`      | `$2FBE`         | `$05AFBE` | ![](images/full_width_regular/0xDA.png) |
| `$DB` | `$055C`      | `$2FD6`         | `$05AFD6` | ![](images/full_width_regular/0xDB.png) |
| `$DC` | `$055E`      | `$2FEE`         | `$05AFEE` | ![](images/full_width_regular/0xDC.png) |
| `$DD` | `$0560`      | `$3006`         | `$05B006` | ![](images/full_width_regular/0xDD.png) |
| `$DE` | `$0562`      | `$301E`         | `$05B01E` | ![](images/full_width_regular/0xDE.png) |
| `$DF` | `$0564`      | `$3036`         | `$05B036` | ![](images/full_width_regular/0xDF.png) |
| `$E0` | `$0566`      | `$304E`         | `$05B04E` | ![](images/full_width_regular/0xE0.png) |
| `$E1` | `$0568`      | `$3066`         | `$05B066` | ![](images/full_width_regular/0xE1.png) |
| `$E2` | `$056A`      | `$307E`         | `$05B07E` | ![](images/full_width_regular/0xE2.png) |
| `$E3` | `$056C`      | `$3096`         | `$05B096` | ![](images/full_width_regular/0xE3.png) |
| `$E4` | `$056E`      | `$30AE`         | `$05B0AE` | ![](images/full_width_regular/0xE4.png) |
| `$E5` | `$0570`      | `$30C6`         | `$05B0C6` | ![](images/full_width_regular/0xE5.png) |
| `$E6` | `$0572`      | `$30DE`         | `$05B0DE` | ![](images/full_width_regular/0xE6.png) |
| `$E7` | `$0574`      | `$30F6`         | `$05B0F6` | ![](images/full_width_regular/0xE7.png) |
| `$E8` | `$0576`      | `$310E`         | `$05B10E` | ![](images/full_width_regular/0xE8.png) |
| `$E9` | `$0578`      | `$3126`         | `$05B126` | ![](images/full_width_regular/0xE9.png) |
| `$EA` | `$057A`      | `$313E`         | `$05B13E` | ![](images/full_width_regular/0xEA.png) |
| `$EB` | `$057C`      | `$3156`         | `$05B156` | ![](images/full_width_regular/0xEB.png) |
| `$EC` | `$057E`      | `$316E`         | `$05B16E` | ![](images/full_width_regular/0xEC.png) |
| `$ED` | `$0000`      | `$0000`         | `N/A`     | ![](images/full_width_regular/blank.png) |
| `$EE` | `$0000`      | `$0000`         | `N/A`     | ![](images/full_width_regular/blank.png) |
| `$EF` | `$0000`      | `$0000`         | `N/A`     | ![](images/full_width_regular/blank.png) |
| `$F0` | `$0586`      | `$3186`         | `$05B186` | ![](images/full_width_regular/0xF0.png) |
| `$F1` | `$0588`      | `$319E`         | `$05B19E` | ![](images/full_width_regular/0xF1.png) |
| `$F2` | `$058A`      | `$31B6`         | `$05B1B6` | ![](images/full_width_regular/0xF2.png) |
| `$F3` | `$0000`      | `$0000`         | `N/A`     | ![](images/full_width_regular/blank.png) |
| `$F4` | `$0000`      | `$0000`         | `N/A`     | ![](images/full_width_regular/blank.png) |
| `$F5` | `$0590`      | `$31CE`         | `$05B1CE` | ![](images/full_width_regular/0xF5.png) |
| `$F6` | `$0592`      | `$31E6`         | `$05B1E6` | ![](images/full_width_regular/0xF6.png) |
| `$F7` | `$0594`      | `$31FE`         | `$05B1FE` | ![](images/full_width_regular/0xF7.png) |
| `$F8` | `$0000`      | `$0000`         | `N/A`     | ![](images/full_width_regular/blank.png) |
| `$F9` | `$0000`      | `$0000`         | `N/A`     | ![](images/full_width_regular/blank.png) |
| `$FA` | `$0000`      | `$0000`         | `N/A`     | ![](images/full_width_regular/blank.png) |
| `$FB` | `$0000`      | `$0000`         | `N/A`     | ![](images/full_width_regular/blank.png) |
| `$FC` | `$0000`      | `$0000`         | `N/A`     | ![](images/full_width_regular/blank.png) |
| `$FD` | `$05A0`      | `$09A6`         | `$0589A6` | ![](images/full_width_regular/blank.png) |
| `$FE` | `$05A2`      | `$0BA6`         | `$058BA6` | ![](images/full_width_regular/blank.png) |
| `$FF` | `$05A4`      | `$0DA6`         | `$058DA6` | ![](images/full_width_regular/blank.png) |

*** *Tile data is present in ROM, but is not mapped by the Table*

* Character tiles here are 16x12 pixels, 1bpp format, and 24 bytes each
* Observation: The empty entries line up with the bytes listed in [the TBD table](#tbd-table) |
* The last three rows are the bytes that correspond to Kanji/Pascal strings, so this is probably used in those lookups as well