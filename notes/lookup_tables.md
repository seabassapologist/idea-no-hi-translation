# Lookup Tables

## Pascal String Tables

These are loaded using offset values stored starting at **PRG**`$117DCA`/**loROM**`$A2FDCA`, and the index of this "pre-lookup-table" is determined by a check made after a character byte is loaded.

From here, each of these lookup tables and and offsets are relative to **PRG**`$117DCA`/**loROM**`$A2FDCA`

* **PRG**`$117DCA`/**loROM**`$A2FDCA` loads `$0006`, which points to table at **loROM**`$117DD0`
  * This happens when loading printable characters are found, and kicks off the lookup routine for [Pascal String Table 2](#pascal-string-table-part-2)
* **PRG**`$117DCC`/**loROM**`$A2FDCC` loads `$002E`, which points to table at **loROM**`$117DF8`
  * This is happens if the byte is `$FD`, which kicks off the lookup routine for [Pascal String Table 3](#pascal-string-table-part-3)
* **PRG**`$117DCE`/**loROM**`$A2FDCE` loads `$00C8` which points to a table at **PRG**`$117E92`/**loROM**`$A2FE92`
  * loaded when the character byte is `$0F`, which loads [Pascal String Table 3](#pascal-string-table-part-1)
* These three tables are contiguous in ROM, but are separated because they are loaded differently

### Pascal String Table Part 1

| Index | Offset | Length| String |
|:-----:|:------:|:-----:|:------:|
| `$0F` | `$00C8`| `$05` | `D4 00 03 D2 D3`|

* This string is interesting, it prints `」[End][Full]*「`
* Current theory: This is related to handling generic NPC or "non-speaking" dialogue box text. These instances have a * character in place of the character name. So it would make sense that this could be used to string together dialogue chunks more efficiently

### Pascal String Table Part 2

Stored at **PRG**`$117DD0`/**loROM**`$A2FDD0`

| Index | Offset | Length| String |
|:-----:|:------:|:-----:|--------|
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
|:-----:|:------:|:-----:|--------|
| `$FF` | `$00F9`| `$14` | `FE 7B FF 73 D3 3F D7 FF DC FF B5 10 FE 58 FF 74 41 5D 4D 4E` |
| `$FE` | `$010E`| `$05` | `35 5C 68 48 37` |
| `$FD` | `$0114`| `$05` | `FF D2 3D FF E3` |
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
| `$D6` | `$0204`| `$04` | `FF 77 FF 6D` |
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
    4. The Offset value is used again by incrementing it once and the adding `#$FDCA` to it's value and that resulting value is stored at **WRAM**`$00006`, aka the variable that's used to track where in a blob of text is currently being read from
        * A this point, the value at **WRAM**`$00006` is now configured to be a pointer to the beginning of the text data in the string
    5. The Length byte is checked if it's zero, and if not, decremented, and is used as a counter for reading in the remaining text bytes
    6. From here the string seems to be processed in the same way as regular script text, by doing a `JSR` to **loROM**`$818C2C`
        * Before the `JSR` it does check if the current byte is a `$FD` or higher (aka it's Kanji) and decrements the Length counter once more to indicate that two bytes are processed by the following routine.
        * The Kanji processing routine increments the pointer at **WRAM**`$00006` again as well, so that by the time the subroutine returns it's now pointing at the next byte after the Kanji bytes
    7. Once that subroutine finishes, execution is looped back to **loROM**`$818A78` where the Length counter is check again, and the next byte in the string is loaded if the counter is not 0.
    8. Rinse repeat until string has been printed out fully!

* Format: Each string starts with 1 byte to indicate the number of bytes that make up the string, and the rest is the actual text data (corresponding to both regular and kanji)
  * Index and offset data is stored between  **PRG**:`$117DF8-$117E90`/**loROM**`$A2FDF8-$A2FE90`
  * The string data for the above table is stored between **PRG**`$117EC3-$117FFF`/ **loROM**`$A2FEC3-$A2FFFF`
    * This is at the end of the `$A2` bank so it will definitely need to be relocated to somewhere else with more space when the time comes :/
* As an example `$E8` prints two characters "博士" (the first two characters of dialogue in the script) which themselves are both kanji, meaning the string requires 4 bytes

## Graphics Lookup Tables

* All Tables and Offsets in this section are relative to **PRG**`$058000`. Both the lookup tables and the graphics data itself live in this region of ROM
* Each table is allocated 239 bytes in ROM, but not all of them are fully used. This is so that the smaller fonts still line up with the same character bytes used in the Full Width table

* Table Format:
  * Index corresponds to a character byte in the script
  * Table Offset is the location within the table, that contains the Graphics Offset value for that character. This is calculated by taking the Index, subtracting `$10`, then doubling the value, and adding it with the corresponding Font Offset
    * For those curious why: The first 16 bytes of script bytes are all control codes, meaning there's no graphics data for them, so we subtract `$10` from the index, so that the table indexing lines up with the first drawable character. We then double it because each entry is two bytes, and the Font Offset comes from the Font Offset table (see [Font Offset Table](#font-offset-table))
  * The Graphics Offset for each index is stored in a table starting at **PRG**`$58000 + [Font Offset]`, so we use `$058000 + [Table Offset]` to get the Graphics Offset
  * Finally the Address is found by adding the Graphics Offset with `$058000`, which gives us the exact **PRG** address for the start of each respective character
  * Image is the 1bpp format tile extracted using a tile editor, for your viewing pleasure

### Font Offset Table

This table starts at exactly **PRG**`$058000` and only contains three entries, which correspond to each style of font (indicated by the control code read at the beginning of the text chunk)

| Index | Font Offset | Style | Code |
|:-----:|:-----------:|:-----:|:----:|
| `$00` | `$0006`     | [8x8](#8x8-text-table)         | `$01`|
| `$01` | `$01E6`     | [Half](#half-width-text-table) | `$02`|
| `$02` | `$03C6`     | [Full](#full-width-text-table) | `$03`|

The Font Offset is the Offset of the Lookup Table for that font, not for the font graphics itself

### 8x8 Text Table

| Index | Table Offset | Graphics Offset | Address   | Image | Character | Note |
|:-----:|:------------:|:---------------:|:---------:|:-----:|:---------:|:----:|
| `$10` | `$0006`      | `$0FA6`         | `$058FA6` | ![blank](/images/8x8/blank.png) | | |
| `$11` | `$0008`      | `$0FAE`         | `$058FAE` | ![0x11](/images/8x8/0x11.png) | ０ | |
| `$12` | `$000A`      | `$0FB6`         | `$058FB6` | ![0x12](/images/8x8/0x12.png) | １ | |
| `$13` | `$000C`      | `$0FBE`         | `$058FBE` | ![0x13](/images/8x8/0x13.png) | ２ | |
| `$14` | `$000E`      | `$0FC6`         | `$058FC6` | ![0x14](/images/8x8/0x14.png) | ３ | |
| `$15` | `$0010`      | `$0FCE`         | `$058FCE` | ![0x15](/images/8x8/0x15.png) | ４ | |
| `$16` | `$0012`      | `$0FD6`         | `$058FD6` | ![0x16](/images/8x8/0x16.png) | ５ | |
| `$17` | `$0014`      | `$0FDE`         | `$058FDE` | ![0x17](/images/8x8/0x17.png) | ６ | |
| `$18` | `$0016`      | `$0FE6`         | `$058FE6` | ![0x18](/images/8x8/0x18.png) | ７ | |
| `$19` | `$0018`      | `$0FEE`         | `$058FEE` | ![0x19](/images/8x8/0x19.png) | ８ | |
| `$1A` | `$001A`      | `$0FF6`         | `$058FF6` | ![0x1A](/images/8x8/0x1A.png) | ９ | |
| `$1D` | `$0020`      | `$0FFE`         | `$058FFE` | ![0x1D](/images/8x8/0x1D.png) | Ｃ | |
| `$1F` | `$0024`      | `$1006`         | `$059006` | ![0x1F](/images/8x8/0x1F.png) | Ｅ | |
| `$22` | `$002A`      | `$100E`         | `$05900E` | ![0x22](/images/8x8/0x22.png) | Ｈ | |
| `$26` | `$0032`      | `$1016`         | `$059016` | ![0x26](/images/8x8/0x26.png) | Ｌ | |
| `$27` | `$0034`      | `$101E`         | `$05901E` | ![0x27](/images/8x8/0x27.png) | Ｍ | |
| `$30` | `$0046`      | `$1026`         | `$059026` | ![0x30](/images/8x8/0x30.png) | Ｖ | |
| `$35` | `$0050`      | `$102E`         | `$05902E` | ![0x35](/images/8x8/0x35.png) | あ | |
| `$36` | `$0052`      | `$1036`         | `$059036` | ![0x36](/images/8x8/0x36.png) | い | |
| `$37` | `$0054`      | `$103E`         | `$05903E` | ![0x37](/images/8x8/0x37.png) | う | |
| `$38` | `$0056`      | `$1046`         | `$059046` | ![0x38](/images/8x8/0x38.png) | え | |
| `$39` | `$0058`      | `$104E`         | `$05904E` | ![0x39](/images/8x8/0x39.png) | お | |
| `$3A` | `$005A`      | `$1056`         | `$059056` | ![0x3A](/images/8x8/0x3A.png) | か | |
| `$3B` | `$005C`      | `$105E`         | `$05905E` | ![0x3B](/images/8x8/0x3B.png) | き | |
| `$3C` | `$005E`      | `$1066`         | `$059066` | ![0x3C](/images/8x8/0x3C.png) | く | |
| `$3D` | `$0060`      | `$106E`         | `$05906E` | ![0x3D](/images/8x8/0x3D.png) | け | |
| `$3E` | `$0062`      | `$1076`         | `$059076` | ![0x3E](/images/8x8/0x3E.png) | こ | |
| `$3F` | `$0064`      | `$107E`         | `$05907E` | ![0x3F](/images/8x8/0x3F.png) | さ | |
| `$40` | `$0066`      | `$1086`         | `$059086` | ![0x40](/images/8x8/0x40.png) | し | |
| `$41` | `$0068`      | `$108E`         | `$05908E` | ![0x41](/images/8x8/0x41.png) | す | |
| `$42` | `$006A`      | `$1096`         | `$059096` | ![0x42](/images/8x8/0x42.png) | せ | |
| `$43` | `$006C`      | `$109E`         | `$05909E` | ![0x43](/images/8x8/0x43.png) | そ | |
| `$44` | `$006E`      | `$10A6`         | `$0590A6` | ![0x44](/images/8x8/0x44.png) | た | |
| `$45` | `$0070`      | `$10AE`         | `$0590AE` | ![0x45](/images/8x8/0x45.png) | ち | |
| `$46` | `$0072`      | `$10B6`         | `$0590B6` | ![0x46](/images/8x8/0x46.png) | つ | |
| `$47` | `$0074`      | `$10BE`         | `$0590BE` | ![0x47](/images/8x8/0x47.png) | て | |
| `$48` | `$0076`      | `$10C6`         | `$0590C6` | ![0x48](/images/8x8/0x48.png) | と | |
| `$49` | `$0078`      | `$10CE`         | `$0590CE` | ![0x49](/images/8x8/0x49.png) | な | |
| `$4A` | `$007A`      | `$10D6`         | `$0590D6` | ![0x4A](/images/8x8/0x4A.png) | に | |
| `$4B` | `$007C`      | `$10DE`         | `$0590DE` | ![0x4B](/images/8x8/0x4B.png) | ぬ | |
| `$4C` | `$007E`      | `$10E6`         | `$0590E6` | ![0x4C](/images/8x8/0x4C.png) | ね | |
| `$4D` | `$0080`      | `$10EE`         | `$0590EE` | ![0x4D](/images/8x8/0x4D.png) | の | |
| `$4E` | `$0082`      | `$10F6`         | `$0590F6` | ![0x4E](/images/8x8/0x4E.png) | は | |
| `$4F` | `$0084`      | `$10FE`         | `$0590FE` | ![0x4F](/images/8x8/0x4F.png) | ひ | |
| `$50` | `$0086`      | `$1106`         | `$059106` | ![0x50](/images/8x8/0x50.png) | ふ | |
| `$51` | `$0088`      | `$110E`         | `$05910E` | ![0x51](/images/8x8/0x51.png) | へ | |
| `$52` | `$008A`      | `$1116`         | `$059116` | ![0x52](/images/8x8/0x52.png) | ほ | |
| `$53` | `$008C`      | `$111E`         | `$05911E` | ![0x53](/images/8x8/0x53.png) | ま | |
| `$54` | `$008E`      | `$1126`         | `$059126` | ![0x54](/images/8x8/0x54.png) | み | |
| `$55` | `$0090`      | `$112E`         | `$05912E` | ![0x55](/images/8x8/0x55.png) | む | |
| `$56` | `$0092`      | `$1136`         | `$059136` | ![0x56](/images/8x8/0x56.png) | め | |
| `$57` | `$0094`      | `$113E`         | `$05913E` | ![0x57](/images/8x8/0x57.png) | も | |
| `$58` | `$0096`      | `$1146`         | `$059146` | ![0x58](/images/8x8/0x58.png) | や | |
| `$59` | `$0098`      | `$114E`         | `$05914E` | ![0x59](/images/8x8/0x59.png) | ゆ | |
| `$5A` | `$009A`      | `$1156`         | `$059156` | ![0x5A](/images/8x8/0x5A.png) | よ | |
| `$5B` | `$009C`      | `$115E`         | `$05915E` | ![0x5B](/images/8x8/0x5B.png) | ら | |
| `$5C` | `$009E`      | `$1166`         | `$059166` | ![0x5C](/images/8x8/0x5C.png) | り | |
| `$5D` | `$00A0`      | `$116E`         | `$05916E` | ![0x5D](/images/8x8/0x5D.png) | る | |
| `$5E` | `$00A2`      | `$1176`         | `$059176` | ![0x5E](/images/8x8/0x5E.png) | れ | |
| `$5F` | `$00A4`      | `$117E`         | `$05917E` | ![0x5F](/images/8x8/0x5F.png) | ろ | |
| `$60` | `$00A6`      | `$1186`         | `$059186` | ![0x60](/images/8x8/0x60.png) | わ | |
| `$61` | `$00A8`      | `$118E`         | `$05918E` | ![0x61](/images/8x8/0x61.png) | を | |
| `$62` | `$00AA`      | `$1196`         | `$059196` | ![0x62](/images/8x8/0x62.png) | ん | |
| `$68` | `$00B6`      | `$119E`         | `$05919E` | ![0x68](/images/8x8/0x68.png) | が | |
| `$69` | `$00B8`      | `$11A6`         | `$0591A6` | ![0x69](/images/8x8/0x69.png) | ぎ | |
| `$6A` | `$00BA`      | `$11AE`         | `$0591AE` | ![0x6A](/images/8x8/0x6A.png) | ぐ | |
| `$6B` | `$00BC`      | `$11B6`         | `$0591B6` | ![0x6B](/images/8x8/0x6B.png) | げ | |
| `$6C` | `$00BE`      | `$11BE`         | `$0591BE` | ![0x6C](/images/8x8/0x6C.png) | ご | |
| `$6D` | `$00C0`      | `$11C6`         | `$0591C6` | ![0x6D](/images/8x8/0x6D.png) | ざ | |
| `$6E` | `$00C2`      | `$11CE`         | `$0591CE` | ![0x6E](/images/8x8/0x6E.png) | じ | |
| `$6F` | `$00C4`      | `$11D6`         | `$0591D6` | ![0x6F](/images/8x8/0x6F.png) | ず | |
| `$70` | `$00C6`      | `$11DE`         | `$0591DE` | ![0x70](/images/8x8/0x70.png) | ぜ | |
| `$71` | `$00C8`      | `$11E6`         | `$0591E6` | ![0x71](/images/8x8/0x71.png) | ぞ | |
| `$72` | `$00CA`      | `$11EE`         | `$0591EE` | ![0x72](/images/8x8/0x72.png) | だ | |
| `$73` | `$00CC`      | `$11F6`         | `$0591F6` | ![0x73](/images/8x8/0x73.png) | ぢ | |
| `$74` | `$00CE`      | `$11FE`         | `$0591FE` | ![0x74](/images/8x8/0x74.png) | づ | |
| `$75` | `$00D0`      | `$1206`         | `$059206` | ![0x75](/images/8x8/0x75.png) | で | |
| `$76` | `$00D2`      | `$120E`         | `$05920E` | ![0x76](/images/8x8/0x76.png) | ど | |
| `$77` | `$00D4`      | `$1216`         | `$059216` | ![0x77](/images/8x8/0x77.png) | ば | |
| `$78` | `$00D6`      | `$121E`         | `$05921E` | ![0x78](/images/8x8/0x78.png) | び | |
| `$79` | `$00D8`      | `$1226`         | `$059226` | ![0x79](/images/8x8/0x79.png) | ぶ | |
| `$7A` | `$00DA`      | `$122E`         | `$05922E` | ![0x7A](/images/8x8/0x7A.png) | べ | |
| `$7B` | `$00DC`      | `$1236`         | `$059236` | ![0x7B](/images/8x8/0x7B.png) | ぼ | |
| `$7C` | `$00DE`      | `$123E`         | `$05923E` | ![0x7C](/images/8x8/0x7C.png) | ぱ | |
| `$7D` | `$00E0`      | `$1246`         | `$059246` | ![0x7D](/images/8x8/0x7D.png) | ぴ | |
| `$7E` | `$00E2`      | `$124E`         | `$05924E` | ![0x7E](/images/8x8/0x7E.png) | ぷ | |
| `$7F` | `$00E4`      | `$1256`         | `$059256` | ![0x7F](/images/8x8/0x7F.png) | ぺ | |
| `$80` | `$00E6`      | `$125E`         | `$05925E` | ![0x80](/images/8x8/0x80.png) | ぽ | |
| `$8A` | `$00FA`      | `$1266`         | `$059266` | ![0x8A](/images/8x8/0x8A.png) | コ | |
| `$AE` | `$0142`      | `$126E`         | `$05926E` | ![0xAE](/images/8x8/0xAE.png) | ン | |
| `$DA` | `$019A`      | `$1276`         | `$059276` | ![0xDA](/images/8x8/0xDA.png) | ： | |
| `$DE` | `$01A2`      | `$127E`         | `$05927E` | ![0xDE](/images/8x8/0xDE.png) | \[Star\] | |
| `$E0` | `$01A6`      | `$1286`         | `$059286` | ![0xE0](/images/8x8/0xE0.png) | \[ConCircle\] | |
| `$E1` | `$01A8`      | `$128E`         | `$05928E` | ![0xE1](/images/8x8/0xE1.png) | \[Circle\] | |
| `$E3` | `$01AC`      | `$1296`         | `$059296` | ![0xE3](/images/8x8/0xE3.png) | \[Triangle\] | |
| `$E6` | `$01B2`      | `$129E`         | `$05929E` | ![0xE6](/images/8x8/0xE6.png) | \[Cross\] | |
| `$E7` | `$01B4`      | `$12A6`         | `$0592A6` | ![0xE7](/images/8x8/0xE7.png) | \[UpArrow\] | |
| `$E8` | `$01B6`      | `$12AE`         | `$0592AE` | ![0xE8](/images/8x8/0xE8.png) | \[DownArrow\] | |
| `$E9` | `$01B8`      | `$12B6`         | `$0592B6` | ![0xE9](/images/8x8/0xE9.png) | \[LeftArrow\] | |
| `$EA` | `$01BA`      | `$12BE`         | `$0592BE` | ![0xEA](/images/8x8/0xEA.png) | \[RightArrow\] | |

* Character tiles here are 8x8 pixels, 1bpp format, and 8 bytes each
* Empty entries in this table were removed for readability, since more than half were unused, and in the graphics data there are no unmapped but still present tiles

### Half Width Text Table

| Index | Table Offset | Graphics Offset | Address   | Image | Character | Note |
|:-----:|:------------:|:---------------:|:---------:|:-----:|:---------:|:----:|
| `$10` | `$01E8`      | `$12C6`         | `$0592D2` | ![blank](/images/half_width/blank.png)| | |
| `$11` | `$01E8`      | `$12D2`         | `$0592D2` | ![0x11](/images/half_width/0x11.png) | ０ | |
| `$12` | `$01EA`      | `$12DE`         | `$0592DE` | ![0x12](/images/half_width/0x12.png) | １ | |
| `$13` | `$01EC`      | `$12EA`         | `$0592EA` | ![0x13](/images/half_width/0x13.png) | ２ | |
| `$14` | `$01EE`      | `$12F6`         | `$0592F6` | ![0x14](/images/half_width/0x14.png) | ３ | |
| `$15` | `$01F0`      | `$1302`         | `$059302` | ![0x15](/images/half_width/0x15.png) | ４ | |
| `$16` | `$01F2`      | `$130E`         | `$05930E` | ![0x16](/images/half_width/0x16.png) | ５ | |
| `$17` | `$01F4`      | `$131A`         | `$05931A` | ![0x17](/images/half_width/0x17.png) | ６ | |
| `$18` | `$01F6`      | `$1326`         | `$059326` | ![0x18](/images/half_width/0x18.png) | ７ | |
| `$19` | `$01F8`      | `$1332`         | `$059332` | ![0x19](/images/half_width/0x19.png) | ８ | |
| `$1A` | `$01FA`      | `$133E`         | `$05933E` | ![0x1A](/images/half_width/0x1A.png) | ９ | |
| `$1B` | `$01FC`      | `$134A`         | `$05934A` | ![0x1B](/images/half_width/0x1B.png) | Ａ | |
| `$1C` | `$01FE`      | `$1356`         | `$059356` | ![0x1C](/images/half_width/0x1C.png) | Ｂ | |
| `$1D` | `$0200`      | `$1362`         | `$059362` | ![0x1D](/images/half_width/0x1D.png) | Ｃ | |
| `$1E` | `$0202`      | `$136E`         | `$05936E` | ![0x1E](/images/half_width/0x1E.png) | Ｄ | |
| `$1F` | `$0204`      | `$137A`         | `$05937A` | ![0x1F](/images/half_width/0x1F.png) | Ｅ | |
| `$20` | `$0206`      | `$1386`         | `$059386` | ![0x20](/images/half_width/0x20.png) | Ｆ | |
| `$21` | `$0208`      | `$1392`         | `$059392` | ![0x21](/images/half_width/0x21.png) | Ｇ | |
| `$22` | `$020A`      | `$139E`         | `$05939E` | ![0x22](/images/half_width/0x22.png) | Ｈ | |
| `$23` | `$020C`      | `$13AA`         | `$0593AA` | ![0x23](/images/half_width/0x23.png) | Ｉ | |
| `$24` | `$0000`      | `$0000`         | `N/A`     | ![0x24](/images/half_width/0x24.png) | Ｊ | *** |
| `$25` | `$0000`      | `$0000`         | `N/A`     | ![0x25](/images/half_width/0x25.png) | Ｋ | *** |
| `$26` | `$0212`      | `$13CE`         | `$0593CE` | ![0x26](/images/half_width/0x26.png) | Ｌ | |
| `$27` | `$0214`      | `$13DA`         | `$0593DA` | ![0x27](/images/half_width/0x27.png) | Ｍ | |
| `$28` | `$0216`      | `$13E6`         | `$0593E6` | ![0x28](/images/half_width/0x28.png) | Ｎ | |
| `$29` | `$0000`      | `$0000`         | `N/A`     | ![0x29](/images/half_width/0x29.png) | Ｏ | *** |
| `$2A` | `$0000`      | `$0000`         | `N/A`     | ![0x2A](/images/half_width/0x2A.png) | Ｐ | *** |
| `$2B` | `$0000`      | `$0000`         | `N/A`     | ![0x2B](/images/half_width/0x2B.png) | Ｑ | *** |
| `$2C` | `$0000`      | `$0000`         | `N/A`     | ![0x2C](/images/half_width/0x2C.png) | Ｒ | *** |
| `$2D` | `$0220`      | `$1422`         | `$059422` | ![0x2D](/images/half_width/0x2D.png) | Ｓ | |
| `$2E` | `$0222`      | `$142E`         | `$05942E` | ![0x2E](/images/half_width/0x2E.png) | Ｔ | |
| `$2F` | `$0000`      | `$0000`         | `N/A`     | ![0x2F](/images/half_width/0x2F.png) | Ｕ | *** |
| `$30` | `$0226`      | `$1446`         | `$059446` | ![0x30](/images/half_width/0x30.png) | Ｖ | |
| `$31` | `$0000`      | `$0000`         | `N/A`     | ![0x31](/images/half_width/0x31.png) | Ｗ | *** |
| `$32` | `$0000`      | `$0000`         | `N/A`     | ![0x32](/images/half_width/0x32.png) | Ｘ | *** |
| `$33` | `$022C`      | `$146A`         | `$05946A` | ![0x33](/images/half_width/0x33.png) | Ｙ | |
| `$34` | `$0000`      | `$0000`         | `N/A`     | ![0x34](/images/half_width/0x34.png) | Ｚ | *** |
| `$35` | `$0230`      | `$1482`         | `$059482` | ![0x35](/images/half_width/0x35.png) | あ | |
| `$36` | `$0232`      | `$148E`         | `$05948E` | ![0x36](/images/half_width/0x36.png) | い | |
| `$37` | `$0234`      | `$149A`         | `$05949A` | ![0x37](/images/half_width/0x37.png) | う | |
| `$38` | `$0236`      | `$14A6`         | `$0594A6` | ![0x38](/images/half_width/0x38.png) | え | |
| `$39` | `$0238`      | `$14B2`         | `$0594B2` | ![0x39](/images/half_width/0x39.png) | お | |
| `$3A` | `$023A`      | `$14BE`         | `$0594BE` | ![0x3A](/images/half_width/0x3A.png) | か | |
| `$3B` | `$023C`      | `$14CA`         | `$0594CA` | ![0x3B](/images/half_width/0x3B.png) | き | |
| `$3C` | `$023E`      | `$14D6`         | `$0594D6` | ![0x3C](/images/half_width/0x3C.png) | く | |
| `$3D` | `$0240`      | `$14E2`         | `$0594E2` | ![0x3D](/images/half_width/0x3D.png) | け | |
| `$3E` | `$0242`      | `$14EE`         | `$0594EE` | ![0x3E](/images/half_width/0x3E.png) | こ | |
| `$3F` | `$0244`      | `$14FA`         | `$0594FA` | ![0x3F](/images/half_width/0x3F.png) | さ | |
| `$40` | `$0246`      | `$1506`         | `$059506` | ![0x40](/images/half_width/0x40.png) | し | |
| `$41` | `$0248`      | `$1512`         | `$059512` | ![0x41](/images/half_width/0x41.png) | す | |
| `$42` | `$024A`      | `$151E`         | `$05951E` | ![0x42](/images/half_width/0x42.png) | せ | |
| `$43` | `$024C`      | `$152A`         | `$05952A` | ![0x43](/images/half_width/0x43.png) | そ | |
| `$44` | `$024E`      | `$1536`         | `$059536` | ![0x44](/images/half_width/0x44.png) | た | |
| `$45` | `$0250`      | `$1542`         | `$059542` | ![0x45](/images/half_width/0x45.png) | ち | |
| `$46` | `$0252`      | `$154E`         | `$05954E` | ![0x46](/images/half_width/0x46.png) | つ | |
| `$47` | `$0254`      | `$155A`         | `$05955A` | ![0x47](/images/half_width/0x47.png) | て | |
| `$48` | `$0256`      | `$1566`         | `$059566` | ![0x48](/images/half_width/0x48.png) | と | |
| `$49` | `$0258`      | `$1572`         | `$059572` | ![0x49](/images/half_width/0x49.png) | な | |
| `$4A` | `$025A`      | `$157E`         | `$05957E` | ![0x4A](/images/half_width/0x4A.png) | に | |
| `$4B` | `$025C`      | `$158A`         | `$05958A` | ![0x4B](/images/half_width/0x4B.png) | ぬ | |
| `$4C` | `$025E`      | `$1596`         | `$059596` | ![0x4C](/images/half_width/0x4C.png) | ね | |
| `$4D` | `$0260`      | `$15A2`         | `$0595A2` | ![0x4D](/images/half_width/0x4D.png) | の | |
| `$4E` | `$0262`      | `$15AE`         | `$0595AE` | ![0x4E](/images/half_width/0x4E.png) | は | |
| `$4F` | `$0264`      | `$15BA`         | `$0595BA` | ![0x4F](/images/half_width/0x4F.png) | ひ | |
| `$50` | `$0266`      | `$15C6`         | `$0595C6` | ![0x50](/images/half_width/0x50.png) | ふ | |
| `$51` | `$0268`      | `$15D2`         | `$0595D2` | ![0x51](/images/half_width/0x51.png) | へ | |
| `$52` | `$026A`      | `$15DE`         | `$0595DE` | ![0x52](/images/half_width/0x52.png) | ほ | |
| `$53` | `$026C`      | `$15EA`         | `$0595EA` | ![0x53](/images/half_width/0x53.png) | ま | |
| `$54` | `$026E`      | `$15F6`         | `$0595F6` | ![0x54](/images/half_width/0x54.png) | み | |
| `$55` | `$0270`      | `$1602`         | `$059602` | ![0x55](/images/half_width/0x55.png) | む | |
| `$56` | `$0272`      | `$160E`         | `$05960E` | ![0x56](/images/half_width/0x56.png) | め | |
| `$57` | `$0274`      | `$161A`         | `$05961A` | ![0x57](/images/half_width/0x57.png) | も | |
| `$58` | `$0276`      | `$1626`         | `$059626` | ![0x58](/images/half_width/0x58.png) | や | |
| `$59` | `$0278`      | `$1632`         | `$059632` | ![0x59](/images/half_width/0x59.png) | ゆ | |
| `$5A` | `$027A`      | `$163E`         | `$05963E` | ![0x5A](/images/half_width/0x5A.png) | よ | |
| `$5B` | `$027C`      | `$164A`         | `$05964A` | ![0x5B](/images/half_width/0x5B.png) | ら | |
| `$5C` | `$027E`      | `$1656`         | `$059656` | ![0x5C](/images/half_width/0x5C.png) | り | |
| `$5D` | `$0280`      | `$1662`         | `$059662` | ![0x5D](/images/half_width/0x5D.png) | る | |
| `$5E` | `$0282`      | `$166E`         | `$05966E` | ![0x5E](/images/half_width/0x5E.png) | れ | |
| `$5F` | `$0284`      | `$167A`         | `$05967A` | ![0x5F](/images/half_width/0x5F.png) | ろ | |
| `$60` | `$0286`      | `$1686`         | `$059686` | ![0x60](/images/half_width/0x60.png) | わ | |
| `$61` | `$0288`      | `$1692`         | `$059692` | ![0x61](/images/half_width/0x61.png) | を | |
| `$62` | `$028A`      | `$169E`         | `$05969E` | ![0x62](/images/half_width/0x62.png) | ん | |
| `$63` | `$028C`      | `$16AA`         | `$0596AA` | ![0x63](/images/half_width/0x63.png) | ぁ | |
| `$64` | `$028E`      | `$16B6`         | `$0596B6` | ![0x64](/images/half_width/0x64.png) | っ | |
| `$65` | `$0290`      | `$16C2`         | `$0596C2` | ![0x65](/images/half_width/0x65.png) | ゃ | |
| `$66` | `$0292`      | `$16CE`         | `$0596CE` | ![0x66](/images/half_width/0x66.png) | ゅ | |
| `$67` | `$0294`      | `$16DA`         | `$0596DA` | ![0x67](/images/half_width/0x67.png) | ょ | |
| `$68` | `$0296`      | `$16E6`         | `$0596E6` | ![0x68](/images/half_width/0x68.png) | が | |
| `$69` | `$0298`      | `$16F2`         | `$0596F2` | ![0x69](/images/half_width/0x69.png) | ぎ | |
| `$6A` | `$029A`      | `$16FE`         | `$0596FE` | ![0x6A](/images/half_width/0x6A.png) | ぐ | |
| `$6B` | `$029C`      | `$170A`         | `$05970A` | ![0x6B](/images/half_width/0x6B.png) | げ | |
| `$6C` | `$029E`      | `$1716`         | `$059716` | ![0x6C](/images/half_width/0x6C.png) | ご | |
| `$6D` | `$02A0`      | `$1722`         | `$059722` | ![0x6D](/images/half_width/0x6D.png) | ざ | |
| `$6E` | `$02A2`      | `$172E`         | `$05972E` | ![0x6E](/images/half_width/0x6E.png) | じ | |
| `$6F` | `$02A4`      | `$173A`         | `$05973A` | ![0x6F](/images/half_width/0x6F.png) | ず | |
| `$70` | `$02A6`      | `$1746`         | `$059746` | ![0x70](/images/half_width/0x70.png) | ぜ | |
| `$71` | `$02A8`      | `$1752`         | `$059752` | ![0x71](/images/half_width/0x71.png) | ぞ | |
| `$72` | `$02AA`      | `$175E`         | `$05975E` | ![0x72](/images/half_width/0x72.png) | だ | |
| `$73` | `$02AC`      | `$176A`         | `$05976A` | ![0x73](/images/half_width/0x73.png) | ぢ | |
| `$74` | `$02AE`      | `$1776`         | `$059776` | ![0x74](/images/half_width/0x74.png) | づ | |
| `$75` | `$02B0`      | `$1782`         | `$059782` | ![0x75](/images/half_width/0x75.png) | で | |
| `$76` | `$02B2`      | `$178E`         | `$05978E` | ![0x76](/images/half_width/0x76.png) | ど | |
| `$77` | `$02B4`      | `$179A`         | `$05979A` | ![0x77](/images/half_width/0x77.png) | ば | |
| `$78` | `$02B6`      | `$17A6`         | `$0597A6` | ![0x78](/images/half_width/0x78.png) | び | |
| `$79` | `$02B8`      | `$17B2`         | `$0597B2` | ![0x79](/images/half_width/0x79.png) | ぶ | |
| `$7A` | `$02BA`      | `$17BE`         | `$0597BE` | ![0x7A](/images/half_width/0x7A.png) | べ | |
| `$7B` | `$02BC`      | `$17CA`         | `$0597CA` | ![0x7B](/images/half_width/0x7B.png) | ぼ | |
| `$7C` | `$02BE`      | `$17D6`         | `$0597D6` | ![0x7C](/images/half_width/0x7C.png) | ぱ | |
| `$7D` | `$02C0`      | `$17E2`         | `$0597E2` | ![0x7D](/images/half_width/0x7D.png) | ぴ | |
| `$7E` | `$02C2`      | `$17EE`         | `$0597EE` | ![0x7E](/images/half_width/0x7E.png) | ぷ | |
| `$7F` | `$02C4`      | `$17FA`         | `$0597FA` | ![0x7F](/images/half_width/0x7F.png) | ぺ | |
| `$80` | `$02C6`      | `$1806`         | `$059806` | ![0x80](/images/half_width/0x80.png) | ぽ | |
| `$81` | `$02C8`      | `$1812`         | `$059812` | ![0x81](/images/half_width/0x81.png) | ア | |
| `$82` | `$02CA`      | `$181E`         | `$05981E` | ![0x82](/images/half_width/0x82.png) | イ | |
| `$83` | `$02CC`      | `$182A`         | `$05982A` | ![0x83](/images/half_width/0x83.png) | ウ | |
| `$84` | `$02CE`      | `$1836`         | `$059836` | ![0x84](/images/half_width/0x84.png) | エ | |
| `$85` | `$02D0`      | `$1842`         | `$059842` | ![0x85](/images/half_width/0x85.png) | オ | |
| `$86` | `$02D2`      | `$184E`         | `$05984E` | ![0x86](/images/half_width/0x86.png) | カ | |
| `$87` | `$02D4`      | `$185A`         | `$05985A` | ![0x87](/images/half_width/0x87.png) | キ | |
| `$88` | `$02D6`      | `$1866`         | `$059866` | ![0x88](/images/half_width/0x88.png) | ク | |
| `$89` | `$02D8`      | `$1872`         | `$059872` | ![0x89](/images/half_width/0x89.png) | ケ | |
| `$8A` | `$02DA`      | `$187E`         | `$05987E` | ![0x8A](/images/half_width/0x8A.png) | コ | |
| `$8B` | `$02DC`      | `$188A`         | `$05988A` | ![0x8B](/images/half_width/0x8B.png) | サ | |
| `$8C` | `$02DE`      | `$1896`         | `$059896` | ![0x8C](/images/half_width/0x8C.png) | シ | |
| `$8D` | `$02E0`      | `$18A2`         | `$0598A2` | ![0x8D](/images/half_width/0x8D.png) | ス | |
| `$8E` | `$02E2`      | `$18AE`         | `$0598AE` | ![0x8E](/images/half_width/0x8E.png) | セ | |
| `$8F` | `$02E4`      | `$18BA`         | `$0598BA` | ![0x8F](/images/half_width/0x8F.png) | ソ | |
| `$90` | `$02E6`      | `$18C6`         | `$0598C6` | ![0x90](/images/half_width/0x90.png) | タ | |
| `$91` | `$02E8`      | `$18D2`         | `$0598D2` | ![0x91](/images/half_width/0x91.png) | チ | |
| `$92` | `$02EA`      | `$18DE`         | `$0598DE` | ![0x92](/images/half_width/0x92.png) | ツ | |
| `$93` | `$02EC`      | `$18EA`         | `$0598EA` | ![0x93](/images/half_width/0x93.png) | テ | |
| `$94` | `$02EE`      | `$18F6`         | `$0598F6` | ![0x94](/images/half_width/0x94.png) | ト | |
| `$95` | `$02F0`      | `$1902`         | `$059902` | ![0x95](/images/half_width/0x95.png) | ナ | |
| `$96` | `$02F2`      | `$190E`         | `$05990E` | ![0x96](/images/half_width/0x96.png) | ニ | |
| `$97` | `$02F4`      | `$191A`         | `$05991A` | ![0x97](/images/half_width/0x97.png) | ヌ | |
| `$98` | `$02F6`      | `$1926`         | `$059926` | ![0x98](/images/half_width/0x98.png) | ネ | |
| `$99` | `$02F8`      | `$1932`         | `$059932` | ![0x99](/images/half_width/0x99.png) | ノ | |
| `$9A` | `$02FA`      | `$193E`         | `$05993E` | ![0x9A](/images/half_width/0x9A.png) | ハ | |
| `$9B` | `$02FC`      | `$194A`         | `$05994A` | ![0x9B](/images/half_width/0x9B.png) | ヒ | |
| `$9C` | `$02FE`      | `$1956`         | `$059956` | ![0x9C](/images/half_width/0x9C.png) | フ | |
| `$9D` | `$0300`      | `$1962`         | `$059962` | ![0x9D](/images/half_width/0x9D.png) | ヘ | |
| `$9E` | `$0302`      | `$196E`         | `$05996E` | ![0x9E](/images/half_width/0x9E.png) | ホ | |
| `$9F` | `$0304`      | `$197A`         | `$05997A` | ![0x9F](/images/half_width/0x9F.png) | マ | |
| `$A0` | `$0306`      | `$1986`         | `$059986` | ![0xA0](/images/half_width/0xA0.png) | ミ | |
| `$A1` | `$0308`      | `$1992`         | `$059992` | ![0xA1](/images/half_width/0xA1.png) | ム | |
| `$A2` | `$030A`      | `$199E`         | `$05999E` | ![0xA2](/images/half_width/0xA2.png) | メ | |
| `$A3` | `$030C`      | `$19AA`         | `$0599AA` | ![0xA3](/images/half_width/0xA3.png) | モ | |
| `$A4` | `$030E`      | `$19B6`         | `$0599B6` | ![0xA4](/images/half_width/0xA4.png) | ヤ | |
| `$A5` | `$0310`      | `$19C2`         | `$0599C2` | ![0xA5](/images/half_width/0xA5.png) | ユ | |
| `$A6` | `$0312`      | `$19CE`         | `$0599CE` | ![0xA6](/images/half_width/0xA6.png) | ヨ | |
| `$A7` | `$0314`      | `$19DA`         | `$0599DA` | ![0xA7](/images/half_width/0xA7.png) | ラ | |
| `$A8` | `$0316`      | `$19E6`         | `$0599E6` | ![0xA8](/images/half_width/0xA8.png) | リ | |
| `$A9` | `$0318`      | `$19F2`         | `$0599F2` | ![0xA9](/images/half_width/0xA9.png) | ル | |
| `$AA` | `$031A`      | `$19FE`         | `$0599FE` | ![0xAA](/images/half_width/0xAA.png) | レ | |
| `$AB` | `$031C`      | `$1A0A`         | `$059A0A` | ![0xAB](/images/half_width/0xAB.png) | ロ | |
| `$AC` | `$031E`      | `$1A16`         | `$059A16` | ![0xAC](/images/half_width/0xAC.png) | ワ | |
| `$AD` | `$0320`      | `$1A22`         | `$059A22` | ![0xAD](/images/half_width/0xAD.png) | ヲ | |
| `$AE` | `$0322`      | `$1A2E`         | `$059A2E` | ![0xAE](/images/half_width/0xAE.png) | ン | |
| `$AF` | `$0324`      | `$1A3A`         | `$059A3A` | ![0xAF](/images/half_width/0xAF.png) | ァ | |
| `$B0` | `$0326`      | `$1A46`         | `$059A46` | ![0xB0](/images/half_width/0xB0.png) | ィ | |
| `$B1` | `$0328`      | `$1A52`         | `$059A52` | ![0xB1](/images/half_width/0xB1.png) | ゥ | |
| `$B2` | `$032A`      | `$1A5E`         | `$059A5E` | ![0xB2](/images/half_width/0xB2.png) | ェ | |
| `$B3` | `$032C`      | `$1A6A`         | `$059A6A` | ![0xB3](/images/half_width/0xB3.png) | ォ | |
| `$B4` | `$032E`      | `$1A76`         | `$059A76` | ![0xB4](/images/half_width/0xB4.png) | ッ | |
| `$B5` | `$0330`      | `$1A82`         | `$059A82` | ![0xB5](/images/half_width/0xB5.png) | ャ | |
| `$B6` | `$0332`      | `$1A8E`         | `$059A8E` | ![0xB6](/images/half_width/0xB6.png) | ュ | |
| `$B7` | `$0334`      | `$1A9A`         | `$059A9A` | ![0xB7](/images/half_width/0xB7.png) | ョ | |
| `$B8` | `$0336`      | `$1AA6`         | `$059AA6` | ![0xB8](/images/half_width/0xB8.png) | ヴ | |
| `$B9` | `$0338`      | `$1AB2`         | `$059AB2` | ![0xB9](/images/half_width/0xB9.png) | ガ | |
| `$BA` | `$033A`      | `$1ABE`         | `$059ABE` | ![0xBA](/images/half_width/0xBA.png) | ギ | |
| `$BB` | `$033C`      | `$1ACA`         | `$059ACA` | ![0xBB](/images/half_width/0xBB.png) | グ | |
| `$BC` | `$033E`      | `$1AD6`         | `$059AD6` | ![0xBC](/images/half_width/0xBC.png) | ゲ | |
| `$BD` | `$0340`      | `$1AE2`         | `$059AE2` | ![0xBD](/images/half_width/0xBD.png) | ゴ | |
| `$BE` | `$0342`      | `$1AEE`         | `$059AEE` | ![0xBE](/images/half_width/0xBE.png) | ザ | |
| `$BF` | `$0344`      | `$1AFA`         | `$059AFA` | ![0xBF](/images/half_width/0xBF.png) | ジ | |
| `$C0` | `$0346`      | `$1B06`         | `$059B06` | ![0xC0](/images/half_width/0xC0.png) | ズ | |
| `$C1` | `$0348`      | `$1B12`         | `$059B12` | ![0xC1](/images/half_width/0xC1.png) | ゼ | |
| `$C2` | `$034A`      | `$1B1E`         | `$059B1E` | ![0xC2](/images/half_width/0xC2.png) | ゾ | |
| `$C3` | `$034C`      | `$1B2A`         | `$059B2A` | ![0xC3](/images/half_width/0xC3.png) | ダ | |
| `$C4` | `$034E`      | `$1B36`         | `$059B36` | ![0xC4](/images/half_width/0xC4.png) | ヂ | |
| `$C5` | `$0350`      | `$1B42`         | `$059B42` | ![0xC5](/images/half_width/0xC5.png) | ヅ | |
| `$C6` | `$0352`      | `$1B4E`         | `$059B4E` | ![0xC6](/images/half_width/0xC6.png) | デ | |
| `$C7` | `$0354`      | `$1B5A`         | `$059B5A` | ![0xC7](/images/half_width/0xC7.png) | ド | |
| `$C8` | `$0356`      | `$1B66`         | `$059B66` | ![0xC8](/images/half_width/0xC8.png) | バ | |
| `$C9` | `$0358`      | `$1B72`         | `$059B72` | ![0xC9](/images/half_width/0xC9.png) | ビ | |
| `$CA` | `$035A`      | `$1B7E`         | `$059B7E` | ![0xCA](/images/half_width/0xCA.png) | ブ | |
| `$CB` | `$035C`      | `$1B8A`         | `$059B8A` | ![0xCB](/images/half_width/0xCB.png) | ベ | |
| `$CC` | `$035E`      | `$1B96`         | `$059B96` | ![0xCC](/images/half_width/0xCC.png) | ボ | |
| `$CD` | `$0360`      | `$1BA2`         | `$059BA2` | ![0xCD](/images/half_width/0xCD.png) | パ | |
| `$CE` | `$0362`      | `$1BAE`         | `$059BAE` | ![0xCE](/images/half_width/0xCE.png) | ピ | |
| `$CF` | `$0364`      | `$1BBA`         | `$059BBA` | ![0xCF](/images/half_width/0xCF.png) | プ | |
| `$D0` | `$0366`      | `$1BC6`         | `$059BC6` | ![0xD0](/images/half_width/0xD0.png) | ペ | |
| `$D1` | `$0368`      | `$1BD2`         | `$059BD2` | ![0xD1](/images/half_width/0xD1.png) | ポ | |
| `$D2` | `$036A`      | `$1BDE`         | `$059BDE` | ![0xD2](/images/half_width/0xD2.png) | ＊ | |
| `$D3` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$D4` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$D5` | `$0370`      | `$1BEA`         | `$059BEA` | ![0xD5](/images/half_width/0xD5.png) | ！ | |
| `$D6` | `$0372`      | `$1BF6`         | `$059BF6` | ![0xD6](/images/half_width/0xD6.png) | ？ | |
| `$D7` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$D8` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$D9` | `$0378`      | `$1C02`         | `$059C02` | ![0xD9](/images/half_width/0xD9.png) | ・ | |
| `$DA` | `$037A`      | `$1C0E`         | `$059C0E` | ![0xDA](/images/half_width/0xDA.png) | ： | |
| `$DB` | `$037C`      | `$1C1A`         | `$059C1A` | ![0xDB](/images/half_width/0xDB.png) | ／ | |
| `$DC` | `$037E`      | `$1C26`         | `$059C26` | ![0xDC](/images/half_width/0xDC.png) | （ | |
| `$DD` | `$0380`      | `$1C32`         | `$059C32` | ![0xDD](/images/half_width/0xDD.png) | ） | |
| `$DE` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$DF` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$E0` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$E1` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$E2` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$E3` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$E4` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$E5` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$E6` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$E7` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$E8` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$E9` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$EA` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$EB` | `$039C`      | `$1C3E`         | `$059C3E` | ![0xEB](/images/half_width/0xEB.png) | ＋ | |
| `$EC` | `$039E`      | `$1C4A`         | `$059C4A` | ![0xEC](/images/half_width/0xEC.png) | － | |
| `$ED` | `$03A0`      | `$1C56`         | `$059C56` | ![0xED](/images/half_width/0xED.png) | \[AmmoArrow\] | |
| `$EE` | `$03A2`      | `$1C62`         | `$059C62` | ![0xEE](/images/half_width/0xEE.png) | \[AmmoUnk\] | |
| `$EF` | `$03A4`      | `$1C6E`         | `$059C6E` | ![0xEF](/images/half_width/0xEF.png) | \[ammobullet\] | |
| `$F0` | `$03A6`      | `$1C7A`         | `$059C7A` | ![0xF0](/images/half_width/0xF0.png) | ｒ． | |
| `$F1` | `$03A8`      | `$1C86`         | `$059C86` | ![0xF1](/images/half_width/0xF1.png) | ー | |
| `$F2` | `$03AA`      | `$1C92`         | `$059C92` | ![0xF2](/images/half_width/0xF2.png) | ＇ | |
| `$F3` | `$03AC`      | `$1C9E`         | `$059C9E` | ![0xF3](/images/half_width/0xF3.png) | \[FullRectangle\] | |
| `$F4` | `$03AE`      | `$1CAA`         | `$059CAA` | ![0xF4](/images/half_width/0xF4.png) | \[Rectangle\] | |
| `$F5` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$F6` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$F7` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png)| | |
| `$F8` | `$03B6`      | `$1CB6`         | `$059CB6` | ![0xF8](/images/half_width/0xF8.png)  |  ゛ | |
| `$F9` | `$03B8`      | `$1CC2`         | `$059CC2` | ![0xF9](/images/half_width/0xF9.png)  |  ゜ | |
| `$FA` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png) | | |
| `$FB` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png) | | |
| `$FC` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png) | | |
| `$FD` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png) | | |
| `$FE` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png) | | |
| `$FF` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/half_width/blank.png) | | |

*** *Tile data is present in ROM, but is not mapped by the Table*

* Character tiles here are 8x12 pixels, 1bpp format, and 12 bytes each
* Unlike the Full Width characters the missing english characters aren't used anywhere

### Full Width Text Table

| Index | Table Offset | Graphics Offset | Address   | Image | Character | Note |
|:-----:|:------------:|:---------------:|:---------:|:-----:|:---------:|:----:|
| `$10` | `$03C6`      | `$1CCE`         | `$059CCE` | ![blank](/images/full_width/blank.png)| | |
| `$11` | `$03C8`      | `$1CE6`         | `$059CE6` | ![0x11](/images/full_width/0x11.png) | ０ | |
| `$12` | `$03CA`      | `$1CFE`         | `$059CFE` | ![0x12](/images/full_width/0x12.png) | １ | |
| `$13` | `$03CC`      | `$1D16`         | `$059D16` | ![0x13](/images/full_width/0x13.png) | ２ | |
| `$14` | `$03CE`      | `$1D2E`         | `$059D2E` | ![0x14](/images/full_width/0x14.png) | ３ | |
| `$15` | `$03D0`      | `$1D46`         | `$059D46` | ![0x15](/images/full_width/0x15.png) | ４ | |
| `$16` | `$03D2`      | `$1D5E`         | `$059D5E` | ![0x16](/images/full_width/0x16.png) | ５ | |
| `$17` | `$03D4`      | `$1D76`         | `$059D76` | ![0x17](/images/full_width/0x17.png) | ６ | |
| `$18` | `$03D6`      | `$1D8E`         | `$059D8E` | ![0x18](/images/full_width/0x18.png) | ７ | |
| `$19` | `$03D8`      | `$1DA6`         | `$059DA6` | ![0x19](/images/full_width/0x19.png) | ８ | |
| `$1A` | `$03DA`      | `$1DBE`         | `$059DBE` | ![0x1A](/images/full_width/0x1A.png) | ９ | |
| `$1B` | `$03DC`      | `$1DD6`         | `$059DD6` | ![0x1B](/images/full_width/0x1B.png) | Ａ | |
| `$1C` | `$03DE`      | `$1DEE`         | `$059DEE` | ![0x1C](/images/full_width/0x1C.png) | Ｂ | |
| `$1D` | `$03E0`      | `$1E06`         | `$059E06` | ![0x1D](/images/full_width/0x1D.png) | Ｃ | |
| `$1E` | `$03E2`      | `$1E1E`         | `$059E1E` | ![0x1E](/images/full_width/0x1E.png) | Ｄ | |
| `$1F` | `$03E4`      | `$1E36`         | `$059E36` | ![0x1F](/images/full_width/0x1F.png) | Ｅ | |
| `$20` | `$03E6`      | `$1E4E`         | `$059E4E` | ![0x20](/images/full_width/0x20.png) | Ｆ | |
| `$21` | `$03E8`      | `$1E66`         | `$059E66` | ![0x21](/images/full_width/0x21.png) | Ｇ | |
| `$22` | `$03EA`      | `$1E7E`         | `$059E7E` | ![0x22](/images/full_width/0x22.png) | Ｈ | |
| `$23` | `$03EC`      | `$1E96`         | `$059E96` | ![0x23](/images/full_width/0x23.png) | Ｉ | |
| `$24` | `$0000`      | `$0000`         | `$059EAE` | ![0x24](/images/full_width/0x24.png) | Ｊ | *** |
| `$25` | `$0000`      | `$0000`         | `$059EC6` | ![0x25](/images/full_width/0x25.png) | Ｋ | *** |
| `$26` | `$03F2`      | `$1EDE`         | `$059EDE` | ![0x26](/images/full_width/0x26.png) | Ｌ | |
| `$27` | `$03F4`      | `$1EF6`         | `$059EF6` | ![0x27](/images/full_width/0x27.png) | Ｍ | |
| `$28` | `$03F6`      | `$1F0E`         | `$059F0E` | ![0x28](/images/full_width/0x28.png) | Ｎ | |
| `$29` | `$0000`      | `$0000`         | `$059F26` | ![0x29](/images/full_width/0x29.png) | Ｏ | *** |
| `$2A` | `$0000`      | `$0000`         | `$059F3E` | ![0x2A](/images/full_width/0x2A.png) | Ｐ | *** |
| `$2B` | `$0000`      | `$0000`         | `$059F56` | ![0x2B](/images/full_width/0x2B.png) | Ｑ | *** |
| `$2C` | `$0000`      | `$0000`         | `$059F6E` | ![0x2C](/images/full_width/0x2C.png) | Ｒ | *** |
| `$2D` | `$0400`      | `$1F86`         | `$059F86` | ![0x2D](/images/full_width/0x2D.png) | Ｓ | |
| `$2E` | `$0402`      | `$1F9E`         | `$059F9E` | ![0x2E](/images/full_width/0x2E.png) | Ｔ | |
| `$2F` | `$0000`      | `$0000`         | `$059FB6` | ![0x2F](/images/full_width/0x2F.png) | Ｕ | *** |
| `$30` | `$0406`      | `$1FCE`         | `$059FCE` | ![0x30](/images/full_width/0x30.png) | Ｖ | |
| `$31` | `$0000`      | `$0000`         | `$059FE6` | ![0x31](/images/full_width/0x31.png) | Ｗ | *** |
| `$32` | `$0000`      | `$0000`         | `$059FFE` | ![0x32](/images/full_width/0x32.png) | Ｘ | *** |
| `$33` | `$040C`      | `$2016`         | `$05A016` | ![0x33](/images/full_width/0x33.png) | Ｙ | |
| `$34` | `$0000`      | `$0000`         | `$05A02E` | ![0x34](/images/full_width/0x34.png) | Ｚ | *** |
| `$35` | `$0410`      | `$2046`         | `$05A046` | ![0x35](/images/full_width/0x35.png) | あ | |
| `$36` | `$0412`      | `$205E`         | `$05A05E` | ![0x36](/images/full_width/0x36.png) | い | |
| `$37` | `$0414`      | `$2076`         | `$05A076` | ![0x37](/images/full_width/0x37.png) | う | |
| `$38` | `$0416`      | `$208E`         | `$05A08E` | ![0x38](/images/full_width/0x38.png) | え | |
| `$39` | `$0418`      | `$20A6`         | `$05A0A6` | ![0x39](/images/full_width/0x39.png) | お | |
| `$3A` | `$041A`      | `$20BE`         | `$05A0BE` | ![0x3A](/images/full_width/0x3A.png) | か | |
| `$3B` | `$041C`      | `$20D6`         | `$05A0D6` | ![0x3B](/images/full_width/0x3B.png) | き | |
| `$3C` | `$041E`      | `$20EE`         | `$05A0EE` | ![0x3C](/images/full_width/0x3C.png) | く | |
| `$3D` | `$0420`      | `$2106`         | `$05A106` | ![0x3D](/images/full_width/0x3D.png) | け | |
| `$3E` | `$0422`      | `$211E`         | `$05A11E` | ![0x3E](/images/full_width/0x3E.png) | こ | |
| `$3F` | `$0424`      | `$2136`         | `$05A136` | ![0x3F](/images/full_width/0x3F.png) | さ | |
| `$40` | `$0426`      | `$214E`         | `$05A14E` | ![0x40](/images/full_width/0x40.png) | し | |
| `$41` | `$0428`      | `$2166`         | `$05A166` | ![0x41](/images/full_width/0x41.png) | す | |
| `$42` | `$042A`      | `$217E`         | `$05A17E` | ![0x42](/images/full_width/0x42.png) | せ | |
| `$43` | `$042C`      | `$2196`         | `$05A196` | ![0x43](/images/full_width/0x43.png) | そ | |
| `$44` | `$042E`      | `$21AE`         | `$05A1AE` | ![0x44](/images/full_width/0x44.png) | た | |
| `$45` | `$0430`      | `$21C6`         | `$05A1C6` | ![0x45](/images/full_width/0x45.png) | ち | |
| `$46` | `$0432`      | `$21DE`         | `$05A1DE` | ![0x46](/images/full_width/0x46.png) | つ | |
| `$47` | `$0434`      | `$21F6`         | `$05A1F6` | ![0x47](/images/full_width/0x47.png) | て | |
| `$48` | `$0436`      | `$220E`         | `$05A20E` | ![0x48](/images/full_width/0x48.png) | と | |
| `$49` | `$0438`      | `$2226`         | `$05A226` | ![0x49](/images/full_width/0x49.png) | な | |
| `$4A` | `$043A`      | `$223E`         | `$05A23E` | ![0x4A](/images/full_width/0x4A.png) | に | |
| `$4B` | `$043C`      | `$2256`         | `$05A256` | ![0x4B](/images/full_width/0x4B.png) | ぬ | |
| `$4C` | `$043E`      | `$226E`         | `$05A26E` | ![0x4C](/images/full_width/0x4C.png) | ね | |
| `$4D` | `$0440`      | `$2286`         | `$05A286` | ![0x4D](/images/full_width/0x4D.png) | の | |
| `$4E` | `$0442`      | `$229E`         | `$05A29E` | ![0x4E](/images/full_width/0x4E.png) | は | |
| `$4F` | `$0444`      | `$22B6`         | `$05A2B6` | ![0x4F](/images/full_width/0x4F.png) | ひ | |
| `$50` | `$0446`      | `$22CE`         | `$05A2CE` | ![0x50](/images/full_width/0x50.png) | ふ | |
| `$51` | `$0448`      | `$22E6`         | `$05A2E6` | ![0x51](/images/full_width/0x51.png) | へ | |
| `$52` | `$044A`      | `$22FE`         | `$05A2FE` | ![0x52](/images/full_width/0x52.png) | ほ | |
| `$53` | `$044C`      | `$2316`         | `$05A316` | ![0x53](/images/full_width/0x53.png) | ま | |
| `$54` | `$044E`      | `$232E`         | `$05A32E` | ![0x54](/images/full_width/0x54.png) | み | |
| `$55` | `$0450`      | `$2346`         | `$05A346` | ![0x55](/images/full_width/0x55.png) | む | |
| `$56` | `$0452`      | `$235E`         | `$05A35E` | ![0x56](/images/full_width/0x56.png) | め | |
| `$57` | `$0454`      | `$2376`         | `$05A376` | ![0x57](/images/full_width/0x57.png) | も | |
| `$58` | `$0456`      | `$238E`         | `$05A38E` | ![0x58](/images/full_width/0x58.png) | や | |
| `$59` | `$0458`      | `$23A6`         | `$05A3A6` | ![0x59](/images/full_width/0x59.png) | ゆ | |
| `$5A` | `$045A`      | `$23BE`         | `$05A3BE` | ![0x5A](/images/full_width/0x5A.png) | よ | |
| `$5B` | `$045C`      | `$23D6`         | `$05A3D6` | ![0x5B](/images/full_width/0x5B.png) | ら | |
| `$5C` | `$045E`      | `$23EE`         | `$05A3EE` | ![0x5C](/images/full_width/0x5C.png) | り | |
| `$5D` | `$0460`      | `$2406`         | `$05A406` | ![0x5D](/images/full_width/0x5D.png) | る | |
| `$5E` | `$0462`      | `$241E`         | `$05A41E` | ![0x5E](/images/full_width/0x5E.png) | れ | |
| `$5F` | `$0464`      | `$2436`         | `$05A436` | ![0x5F](/images/full_width/0x5F.png) | ろ | |
| `$60` | `$0466`      | `$244E`         | `$05A44E` | ![0x60](/images/full_width/0x60.png) | わ | |
| `$61` | `$0468`      | `$2466`         | `$05A466` | ![0x61](/images/full_width/0x61.png) | を | |
| `$62` | `$046A`      | `$247E`         | `$05A47E` | ![0x62](/images/full_width/0x62.png) | ん | |
| `$63` | `$046C`      | `$2496`         | `$05A496` | ![0x63](/images/full_width/0x63.png) | ぁ | |
| `$64` | `$046E`      | `$24AE`         | `$05A4AE` | ![0x64](/images/full_width/0x64.png) | っ | |
| `$65` | `$0470`      | `$24C6`         | `$05A4C6` | ![0x65](/images/full_width/0x65.png) | ゃ | |
| `$66` | `$0472`      | `$24DE`         | `$05A4DE` | ![0x66](/images/full_width/0x66.png) | ゅ | |
| `$67` | `$0474`      | `$24F6`         | `$05A4F6` | ![0x67](/images/full_width/0x67.png) | ょ | |
| `$68` | `$0476`      | `$250E`         | `$05A50E` | ![0x68](/images/full_width/0x68.png) | が | |
| `$69` | `$0478`      | `$2526`         | `$05A526` | ![0x69](/images/full_width/0x69.png) | ぎ | |
| `$6A` | `$047A`      | `$253E`         | `$05A53E` | ![0x6A](/images/full_width/0x6A.png) | ぐ | |
| `$6B` | `$047C`      | `$2556`         | `$05A556` | ![0x6B](/images/full_width/0x6B.png) | げ | |
| `$6C` | `$047E`      | `$256E`         | `$05A56E` | ![0x6C](/images/full_width/0x6C.png) | ご | |
| `$6D` | `$0480`      | `$2586`         | `$05A586` | ![0x6D](/images/full_width/0x6D.png) | ざ | |
| `$6E` | `$0482`      | `$259E`         | `$05A59E` | ![0x6E](/images/full_width/0x6E.png) | じ | |
| `$6F` | `$0484`      | `$25B6`         | `$05A5B6` | ![0x6F](/images/full_width/0x6F.png) | ず | |
| `$70` | `$0486`      | `$25CE`         | `$05A5CE` | ![0x70](/images/full_width/0x70.png) | ぜ | |
| `$71` | `$0488`      | `$25E6`         | `$05A5E6` | ![0x71](/images/full_width/0x71.png) | ぞ | |
| `$72` | `$048A`      | `$25FE`         | `$05A5FE` | ![0x72](/images/full_width/0x72.png) | だ | |
| `$73` | `$048C`      | `$2616`         | `$05A616` | ![0x73](/images/full_width/0x73.png) | ぢ | |
| `$74` | `$048E`      | `$262E`         | `$05A62E` | ![0x74](/images/full_width/0x74.png) | づ | |
| `$75` | `$0490`      | `$2646`         | `$05A646` | ![0x75](/images/full_width/0x75.png) | で | |
| `$76` | `$0492`      | `$265E`         | `$05A65E` | ![0x76](/images/full_width/0x76.png) | ど | |
| `$77` | `$0494`      | `$2676`         | `$05A676` | ![0x77](/images/full_width/0x77.png) | ば | |
| `$78` | `$0496`      | `$268E`         | `$05A68E` | ![0x78](/images/full_width/0x78.png) | び | |
| `$79` | `$0498`      | `$26A6`         | `$05A6A6` | ![0x79](/images/full_width/0x79.png) | ぶ | |
| `$7A` | `$049A`      | `$26BE`         | `$05A6BE` | ![0x7A](/images/full_width/0x7A.png) | べ | |
| `$7B` | `$049C`      | `$26D6`         | `$05A6D6` | ![0x7B](/images/full_width/0x7B.png) | ぼ | |
| `$7C` | `$049E`      | `$26EE`         | `$05A6EE` | ![0x7C](/images/full_width/0x7C.png) | ぱ | |
| `$7D` | `$04A0`      | `$2706`         | `$05A706` | ![0x7D](/images/full_width/0x7D.png) | ぴ | |
| `$7E` | `$04A2`      | `$271E`         | `$05A71E` | ![0x7E](/images/full_width/0x7E.png) | ぷ | |
| `$7F` | `$04A4`      | `$2736`         | `$05A736` | ![0x7F](/images/full_width/0x7F.png) | ぺ | |
| `$80` | `$04A6`      | `$274E`         | `$05A74E` | ![0x80](/images/full_width/0x80.png) | ぽ | |
| `$81` | `$04A8`      | `$2766`         | `$05A766` | ![0x81](/images/full_width/0x81.png) | ア | |
| `$82` | `$04AA`      | `$277E`         | `$05A77E` | ![0x82](/images/full_width/0x82.png) | イ | |
| `$83` | `$04AC`      | `$2796`         | `$05A796` | ![0x83](/images/full_width/0x83.png) | ウ | |
| `$84` | `$04AE`      | `$27AE`         | `$05A7AE` | ![0x84](/images/full_width/0x84.png) | エ | |
| `$85` | `$04B0`      | `$27C6`         | `$05A7C6` | ![0x85](/images/full_width/0x85.png) | オ | |
| `$86` | `$04B2`      | `$27DE`         | `$05A7DE` | ![0x86](/images/full_width/0x86.png) | カ | |
| `$87` | `$04B4`      | `$27F6`         | `$05A7F6` | ![0x87](/images/full_width/0x87.png) | キ | |
| `$88` | `$04B6`      | `$280E`         | `$05A80E` | ![0x88](/images/full_width/0x88.png) | ク | |
| `$89` | `$04B8`      | `$2826`         | `$05A826` | ![0x89](/images/full_width/0x89.png) | ケ | |
| `$8A` | `$04BA`      | `$283E`         | `$05A83E` | ![0x8A](/images/full_width/0x8A.png) | コ | |
| `$8B` | `$04BC`      | `$2856`         | `$05A856` | ![0x8B](/images/full_width/0x8B.png) | サ | |
| `$8C` | `$04BE`      | `$286E`         | `$05A86E` | ![0x8C](/images/full_width/0x8C.png) | シ | |
| `$8D` | `$04C0`      | `$2886`         | `$05A886` | ![0x8D](/images/full_width/0x8D.png) | ス | |
| `$8E` | `$04C2`      | `$289E`         | `$05A89E` | ![0x8E](/images/full_width/0x8E.png) | セ | |
| `$8F` | `$04C4`      | `$28B6`         | `$05A8B6` | ![0x8F](/images/full_width/0x8F.png) | ソ | |
| `$90` | `$04C6`      | `$28CE`         | `$05A8CE` | ![0x90](/images/full_width/0x90.png) | タ | |
| `$91` | `$04C8`      | `$28E6`         | `$05A8E6` | ![0x91](/images/full_width/0x91.png) | チ | |
| `$92` | `$04CA`      | `$28FE`         | `$05A8FE` | ![0x92](/images/full_width/0x92.png) | ツ | |
| `$93` | `$04CC`      | `$2916`         | `$05A916` | ![0x93](/images/full_width/0x93.png) | テ | |
| `$94` | `$04CE`      | `$292E`         | `$05A92E` | ![0x94](/images/full_width/0x94.png) | ト | |
| `$95` | `$04D0`      | `$2946`         | `$05A946` | ![0x95](/images/full_width/0x95.png) | ナ | |
| `$96` | `$04D2`      | `$295E`         | `$05A95E` | ![0x96](/images/full_width/0x96.png) | ニ | |
| `$97` | `$04D4`      | `$2976`         | `$05A976` | ![0x97](/images/full_width/0x97.png) | ヌ | |
| `$98` | `$04D6`      | `$298E`         | `$05A98E` | ![0x98](/images/full_width/0x98.png) | ネ | |
| `$99` | `$04D8`      | `$29A6`         | `$05A9A6` | ![0x99](/images/full_width/0x99.png) | ノ | |
| `$9A` | `$04DA`      | `$29BE`         | `$05A9BE` | ![0x9A](/images/full_width/0x9A.png) | ハ | |
| `$9B` | `$04DC`      | `$29D6`         | `$05A9D6` | ![0x9B](/images/full_width/0x9B.png) | ヒ | |
| `$9C` | `$04DE`      | `$29EE`         | `$05A9EE` | ![0x9C](/images/full_width/0x9C.png) | フ | |
| `$9D` | `$04E0`      | `$2A06`         | `$05AA06` | ![0x9D](/images/full_width/0x9D.png) | ヘ | |
| `$9E` | `$04E2`      | `$2A1E`         | `$05AA1E` | ![0x9E](/images/full_width/0x9E.png) | ホ | |
| `$9F` | `$04E4`      | `$2A36`         | `$05AA36` | ![0x9F](/images/full_width/0x9F.png) | マ | |
| `$A0` | `$04E6`      | `$2A4E`         | `$05AA4E` | ![0xA0](/images/full_width/0xA0.png) | ミ | |
| `$A1` | `$04E8`      | `$2A66`         | `$05AA66` | ![0xA1](/images/full_width/0xA1.png) | ム | |
| `$A2` | `$04EA`      | `$2A7E`         | `$05AA7E` | ![0xA2](/images/full_width/0xA2.png) | メ | |
| `$A3` | `$04EC`      | `$2A96`         | `$05AA96` | ![0xA3](/images/full_width/0xA3.png) | モ | |
| `$A4` | `$04EE`      | `$2AAE`         | `$05AAAE` | ![0xA4](/images/full_width/0xA4.png) | ヤ | |
| `$A5` | `$04F0`      | `$2AC6`         | `$05AAC6` | ![0xA5](/images/full_width/0xA5.png) | ユ | |
| `$A6` | `$04F2`      | `$2ADE`         | `$05AADE` | ![0xA6](/images/full_width/0xA6.png) | ヨ | |
| `$A7` | `$04F4`      | `$2AF6`         | `$05AAF6` | ![0xA7](/images/full_width/0xA7.png) | ラ | |
| `$A8` | `$04F6`      | `$2B0E`         | `$05AB0E` | ![0xA8](/images/full_width/0xA8.png) | リ | |
| `$A9` | `$04F8`      | `$2B26`         | `$05AB26` | ![0xA9](/images/full_width/0xA9.png) | ル | |
| `$AA` | `$04FA`      | `$2B3E`         | `$05AB3E` | ![0xAA](/images/full_width/0xAA.png) | レ | |
| `$AB` | `$04FC`      | `$2B56`         | `$05AB56` | ![0xAB](/images/full_width/0xAB.png) | ロ | |
| `$AC` | `$04FE`      | `$2B6E`         | `$05AB6E` | ![0xAC](/images/full_width/0xAC.png) | ワ | |
| `$AD` | `$0500`      | `$2B86`         | `$05AB86` | ![0xAD](/images/full_width/0xAD.png) | ヲ | |
| `$AE` | `$0502`      | `$2B9E`         | `$05AB9E` | ![0xAE](/images/full_width/0xAE.png) | ン | |
| `$AF` | `$0504`      | `$2BB6`         | `$05ABB6` | ![0xAF](/images/full_width/0xAF.png) | ァ | |
| `$B0` | `$0506`      | `$2BCE`         | `$05ABCE` | ![0xB0](/images/full_width/0xB0.png) | ィ | |
| `$B1` | `$0508`      | `$2BE6`         | `$05ABE6` | ![0xB1](/images/full_width/0xB1.png) | ゥ | |
| `$B2` | `$050A`      | `$2BFE`         | `$05ABFE` | ![0xB2](/images/full_width/0xB2.png) | ェ | |
| `$B3` | `$050C`      | `$2C16`         | `$05AC16` | ![0xB3](/images/full_width/0xB3.png) | ォ | |
| `$B4` | `$050E`      | `$2C2E`         | `$05AC2E` | ![0xB4](/images/full_width/0xB4.png) | ッ | |
| `$B5` | `$0510`      | `$2C46`         | `$05AC46` | ![0xB5](/images/full_width/0xB5.png) | ャ | |
| `$B6` | `$0512`      | `$2C5E`         | `$05AC5E` | ![0xB6](/images/full_width/0xB6.png) | ュ | |
| `$B7` | `$0514`      | `$2C76`         | `$05AC76` | ![0xB7](/images/full_width/0xB7.png) | ョ | |
| `$B8` | `$0516`      | `$2C8E`         | `$05AC8E` | ![0xB8](/images/full_width/0xB8.png) | ヴ | |
| `$B9` | `$0518`      | `$2CA6`         | `$05ACA6` | ![0xB9](/images/full_width/0xB9.png) | ガ | |
| `$BA` | `$051A`      | `$2CBE`         | `$05ACBE` | ![0xBA](/images/full_width/0xBA.png) | ギ | |
| `$BB` | `$051C`      | `$2CD6`         | `$05ACD6` | ![0xBB](/images/full_width/0xBB.png) | グ | |
| `$BC` | `$051E`      | `$2CEE`         | `$05ACEE` | ![0xBC](/images/full_width/0xBC.png) | ゲ | |
| `$BD` | `$0520`      | `$2D06`         | `$05AD06` | ![0xBD](/images/full_width/0xBD.png) | ゴ | |
| `$BE` | `$0522`      | `$2D1E`         | `$05AD1E` | ![0xBE](/images/full_width/0xBE.png) | ザ | |
| `$BF` | `$0524`      | `$2D36`         | `$05AD36` | ![0xBF](/images/full_width/0xBF.png) | ジ | |
| `$C0` | `$0526`      | `$2D4E`         | `$05AD4E` | ![0xC0](/images/full_width/0xC0.png) | ズ | |
| `$C1` | `$0528`      | `$2D66`         | `$05AD66` | ![0xC1](/images/full_width/0xC1.png) | ゼ | |
| `$C2` | `$052A`      | `$2D7E`         | `$05AD7E` | ![0xC2](/images/full_width/0xC2.png) | ゾ | |
| `$C3` | `$052C`      | `$2D96`         | `$05AD96` | ![0xC3](/images/full_width/0xC3.png) | ダ | |
| `$C4` | `$052E`      | `$2DAE`         | `$05ADAE` | ![0xC4](/images/full_width/0xC4.png) | ヂ | |
| `$C5` | `$0530`      | `$2DC6`         | `$05ADC6` | ![0xC5](/images/full_width/0xC5.png) | ヅ | |
| `$C6` | `$0532`      | `$2DDE`         | `$05ADDE` | ![0xC6](/images/full_width/0xC6.png) | デ | |
| `$C7` | `$0534`      | `$2DF6`         | `$05ADF6` | ![0xC7](/images/full_width/0xC7.png) | ド | |
| `$C8` | `$0536`      | `$2E0E`         | `$05AE0E` | ![0xC8](/images/full_width/0xC8.png) | バ | |
| `$C9` | `$0538`      | `$2E26`         | `$05AE26` | ![0xC9](/images/full_width/0xC9.png) | ビ | |
| `$CA` | `$053A`      | `$2E3E`         | `$05AE3E` | ![0xCA](/images/full_width/0xCA.png) | ブ | |
| `$CB` | `$053C`      | `$2E56`         | `$05AE56` | ![0xCB](/images/full_width/0xCB.png) | ベ | |
| `$CC` | `$053E`      | `$2E6E`         | `$05AE6E` | ![0xCC](/images/full_width/0xCC.png) | ボ | |
| `$CD` | `$0540`      | `$2E86`         | `$05AE86` | ![0xCD](/images/full_width/0xCD.png) | パ | |
| `$CE` | `$0542`      | `$2E9E`         | `$05AE9E` | ![0xCE](/images/full_width/0xCE.png) | ピ | |
| `$CF` | `$0544`      | `$2EB6`         | `$05AEB6` | ![0xCF](/images/full_width/0xCF.png) | プ | |
| `$D0` | `$0546`      | `$2ECE`         | `$05AECE` | ![0xD0](/images/full_width/0xD0.png) | ペ | |
| `$D1` | `$0548`      | `$2EE6`         | `$05AEE6` | ![0xD1](/images/full_width/0xD1.png) | ポ | |
| `$D2` | `$054A`      | `$2EFE`         | `$05AEFE` | ![0xD2](/images/full_width/0xD2.png) | ＊ | |
| `$D3` | `$054C`      | `$2F16`         | `$05AF16` | ![0xD3](/images/full_width/0xD3.png) | 「 | |
| `$D4` | `$054E`      | `$2F2E`         | `$05AF2E` | ![0xD4](/images/full_width/0xD4.png) | 」 | |
| `$D5` | `$0550`      | `$2F46`         | `$05AF46` | ![0xD5](/images/full_width/0xD5.png) | ！ | |
| `$D6` | `$0552`      | `$2F5E`         | `$05AF5E` | ![0xD6](/images/full_width/0xD6.png) | ？ | |
| `$D7` | `$0554`      | `$2F76`         | `$05AF76` | ![0xD7](/images/full_width/0xD7.png) | 〜 | |
| `$D8` | `$0556`      | `$2F8E`         | `$05AF8E` | ![0xD8](/images/full_width/0xD8.png) | 。| |
| `$D9` | `$0558`      | `$2FA6`         | `$05AFA6` | ![0xD9](/images/full_width/0xD9.png) | ・ | |
| `$DA` | `$055A`      | `$2FBE`         | `$05AFBE` | ![0xDA](/images/full_width/0xDA.png) | ： | |
| `$DB` | `$055C`      | `$2FD6`         | `$05AFD6` | ![0xDB](/images/full_width/0xDB.png) | ／ | |
| `$DC` | `$055E`      | `$2FEE`         | `$05AFEE` | ![0xDC](/images/full_width/0xDC.png) | （ | |
| `$DD` | `$0560`      | `$3006`         | `$05B006` | ![0xDD](/images/full_width/0xDD.png) | ） | |
| `$DE` | `$0562`      | `$301E`         | `$05B01E` | ![0xDE](/images/full_width/0xDE.png) | \[Star\] | |
| `$DF` | `$0564`      | `$3036`         | `$05B036` | ![0xDF](/images/full_width/0xDF.png) | \[Heart\] | |
| `$E0` | `$0566`      | `$304E`         | `$05B04E` | ![0xE0](/images/full_width/0xE0.png) | \[ConCircle\] | |
| `$E1` | `$0568`      | `$3066`         | `$05B066` | ![0xE1](/images/full_width/0xE1.png) | \[Circle\] | |
| `$E2` | `$056A`      | `$307E`         | `$05B07E` | ![0xE2](/images/full_width/0xE2.png) | \[FullCircle\] | |
| `$E3` | `$056C`      | `$3096`         | `$05B096` | ![0xE3](/images/full_width/0xE3.png) | \[Triangle\] | |
| `$E4` | `$056E`      | `$30AE`         | `$05B0AE` | ![0xE4](/images/full_width/0xE4.png) | \[FullTriangle\] | |
| `$E5` | `$0570`      | `$30C6`         | `$05B0C6` | ![0xE5](/images/full_width/0xE5.png) | \[Square\] | |
| `$E6` | `$0572`      | `$30DE`         | `$05B0DE` | ![0xE6](/images/full_width/0xE6.png) | \[Cross\] | |
| `$E7` | `$0574`      | `$30F6`         | `$05B0F6` | ![0xE7](/images/full_width/0xE7.png) | \[UpArrow\] | |
| `$E8` | `$0576`      | `$310E`         | `$05B10E` | ![0xE8](/images/full_width/0xE8.png) | \[DownArrow\] | |
| `$E9` | `$0578`      | `$3126`         | `$05B126` | ![0xE9](/images/full_width/0xE9.png) | \[LeftArrow\] | |
| `$EA` | `$057A`      | `$313E`         | `$05B13E` | ![0xEA](/images/full_width/0xEA.png) | \[RightArrow\] | |
| `$EB` | `$057C`      | `$3156`         | `$05B156` | ![0xEB](/images/full_width/0xEB.png) | ＋ | |
| `$EC` | `$057E`      | `$316E`         | `$05B16E` | ![0xEC](/images/full_width/0xEC.png) | － | |
| `$ED` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/full_width/blank.png) | | |
| `$EE` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/full_width/blank.png) | | |
| `$EF` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/full_width/blank.png) | | |
| `$F0` | `$0586`      | `$3186`         | `$05B186` | ![0xF0](/images/full_width/0xF0.png) | ｒ． | |
| `$F1` | `$0588`      | `$319E`         | `$05B19E` | ![0xF1](/images/full_width/0xF1.png) | ー | |
| `$F2` | `$058A`      | `$31B6`         | `$05B1B6` | ![0xF2](/images/full_width/0xF2.png) | ＇ | |
| `$F3` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/full_width/blank.png) | | |
| `$F4` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/full_width/blank.png) | | |
| `$F5` | `$0590`      | `$31CE`         | `$05B1CE` | ![0xF5](/images/full_width/0xF5.png) | 々 | |
| `$F6` | `$0592`      | `$31E6`         | `$05B1E6` | ![0xF6](/images/full_width/0xF6.png) | 『 | |
| `$F7` | `$0594`      | `$31FE`         | `$05B1FE` | ![0xF7](/images/full_width/0xF7.png) | 』 | |
| `$F8` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/full_width/blank.png) | | |
| `$F9` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/full_width/blank.png) | | |
| `$FA` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/full_width/blank.png) | | |
| `$FB` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/full_width/blank.png) | | |
| `$FC` | `$0000`      | `$0000`         | `N/A`     | ![blank](/images/full_width/blank.png) | | |
| `$FD` | `$05A0`      | `$09A6`         | `$0589A6` | ![blank](/images/full_width/blank.png) | | |
| `$FE` | `$05A2`      | `$0BA6`         | `$058BA6` | ![blank](/images/full_width/blank.png) | | |
| `$FF` | `$05A4`      | `$0DA6`         | `$058DA6` | ![blank](/images/full_width/blank.png) | | |

*** *Tile data is present in ROM, but is not mapped by the Table*

* Character tiles here are 16x12 pixels, 1bpp format, and 24 bytes each
* The last three rows are used for looking up the offsets of the [Kanji Tables](/notes/kanji_lookup_tables.md#kanji-table-lookup-table)
* The missing english characters are mapped by rows `$F6-$FF` in [Kanji Table FE](/notes/kanji_lookup_tables.md#kanji-table-fe)
