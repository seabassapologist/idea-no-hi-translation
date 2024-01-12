# Lookup Tables

These seem to be loaded using offset values stored starting at **PRG**`$117DCA`/**loROM**`$A2FDCA`, and the index of this "pre-lookup-table" is determined by a check made after a character byte is loaded. 

From here, each of these lookup tables and and offsets are relative to **PRG**`$117DCA`/**loROM**`$A2FDCA`


* **PGR**`$117DCA`/**loROM**`$A2FDCA` loads `$0006`, which points to table at **loROM**`$117DD0`
    * This happens when loading printable, non-kanji characters are found
* **PGR**`$117DCC`/**loROM**`$A2FDCC` loads `$002E`, which points to table at **loROM**`$117DF8`
    * This is happens if the byte is `$FD`, `$FE`, or `$FF` (aka it's a Kanji character or dictionary string)
* **PRG**`$117DCE`/**loROM**`$A2FDCE` loads `$00C8` which points to a table at **PRG**`$117E92`/**loROM**`$A2FE92`
    * Seems to be in a different format that the other two tables, and is also loaded in a different section of code need to investigate further

### TBD Table

Stored at **PRG**`$117DD0`/**loROM**`$A2FDD0`

| Index | Offset |
|-------|--------|
| `$24` | `$00CE`|
| `$25` | `$00D1`|
| `$29` | `$00D5`|
| `$2A` | `$00D8`|
| `$2B` | `$00DB`|
| `$2C` | `$00DE`|
| `$2F` | `$00E1`|
| `$31` | `$00E4`|
| `$32` | `$00E7`|
| `$34` | `$00EA`|
| `$FA` | `$00ED`|
| `$FB` | `$00F1`|
| `$FC` | `$00F4`|


### Dictionary String Table

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
    6. From here the string seems to be processed in the same way as regular script text, by doing a `JRS` to **loROM**`$818C2C`
        * Before the `JSL` it does check if the current byte is a `$FD` or higher (aka it's Kanji) and decrements the Length counter once more to indicate that two bytes were processed by the following routine. 
        * The Kanji processing routine _SHOULD_ also increment the pointer at **WRAM**`$00006` again as well, so that by the time the subroutine returns it's now pointing at the next byte after the Kanji bytes
    7. Once that subroutine finishes, execution is looped back to **loROM**`$818A78` where the Length counter is check again, and the next byte in the string is loaded if the counter is not 0. 
    8. Rinse repeat until string has been printed out fully!

* Format: Each string starts with 1 byte to indicate the number of bytes (in hex!) that make up the string, and the rest is the actual text data (corresponding to both regular and kanji)
    * Index and offset data is stored between  **PRG**:`$117DF8-$117E90`/**loROM**`$A2FDF8-$A2FE90`
    * The string data for the above table is stored between **PRG**`$117EC3-$117FFF`/ **loROM**`$A2FEC3-$A2FFFF`
        * This is at the end of the `$A2` bank so it will definitely need to be relocated to somewhere else with more space when the time comes :/
* As an example `$E8` prints two characters "博士" (the first two characters of dialogue in the script) which themselves are both kanji, meaning the string requires 4 bytes 
* Per the romhacking forum notes, `$FD` contains dictionary strings in addition to Kanji

