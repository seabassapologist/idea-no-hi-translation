# Lookup Tables

These seem to be loaded using offset values stored starting at **PRG**`$117DCA`/**loROM**`$A2FDCA`, and the index of this "pre-lookup-table" is determined by a check made after a character byte is loaded. 

From here, each of these lookup tables and and offsets are relative to **PRG**`$117DCA`/**loROM**`$A2FDCA`


* **PRG**`$117DCA`/**loROM**`$A2FDCA` loads `$0006`, which points to table at **loROM**`$117DD0`
    * This happens when loading printable, non-kanji characters are found
* **PRG**`$117DCC`/**loROM**`$A2FDCC` loads `$002E`, which points to table at **loROM**`$117DF8`
    * This is happens if the byte is `$FD`, `$FE`, or `$FF` (aka it's a Kanji character or pascal string)
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


### Pascal String Table

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

* Format: Each string starts with 1 byte to indicate the number of bytes that make up the string, and the rest is the actual text data (corresponding to both regular and kanji)
    * Index and offset data is stored between  **PRG**:`$117DF8-$117E90`/**loROM**`$A2FDF8-$A2FE90`
    * The string data for the above table is stored between **PRG**`$117EC3-$117FFF`/ **loROM**`$A2FEC3-$A2FFFF`
        * This is at the end of the `$A2` bank so it will definitely need to be relocated to somewhere else with more space when the time comes :/
* As an example `$E8` prints two characters "博士" (the first two characters of dialogue in the script) which themselves are both kanji, meaning the string requires 4 bytes 
* Per the romhacking forum notes, `$FD` contains pascal strings in addition to Kanji

### Regular Text Table

| Index | Offset | Address   | Image |
|-------|--------|-----------|-------|
| `$11` | `$1CE6`| `$059CE6` | ![](images/full_width_regular/0x11.png)
| `$12` | `$1CFE`| `$059CFE` | ![](images/full_width_regular/0x12.png)
| `$13` | `$1D16`| `$059D16` | ![](images/full_width_regular/0x13.png)
| `$14` | `$1D2E`| `$059D2E` | ![](images/full_width_regular/0x14.png)
| `$15` | `$1D46`| `$059D46` | ![](images/full_width_regular/0x15.png)
| `$16` | `$1D5E`| `$059D5E` | ![](images/full_width_regular/0x16.png)
| `$17` | `$1D76`| `$059D76` | ![](images/full_width_regular/0x17.png)
| `$18` | `$1D8E`| `$059D8E` | ![](images/full_width_regular/0x18.png)
| `$19` | `$1DA6`| `$059DA6` | ![](images/full_width_regular/0x19.png)
| `$1A` | `$1DBE`| `$059DBE` | ![](images/full_width_regular/0x1A.png)
| `$1B` | `$1DD6`| `$059DD6` | ![](images/full_width_regular/0x1B.png)
| `$1C` | `$1DEE`| `$059DEE` | ![](images/full_width_regular/0x1C.png)
| `$1D` | `$1E06`| `$059E06` | ![](images/full_width_regular/0x1D.png)
| `$1E` | `$1E1E`| `$059E1E` | ![](images/full_width_regular/0x1E.png)
| `$1F` | `$1E36`| `$059E36` | ![](images/full_width_regular/0x1F.png)
| `$20` | `$1E4E`| `$059E4E` | ![](images/full_width_regular/0x20.png)
| `$21` | `$1E66`| `$059E66` | ![](images/full_width_regular/0x21.png)
| `$22` | `$1E7E`| `$059E7E` | ![](images/full_width_regular/0x22.png)
| `$23` | `$1E96`| `$059E96` | ![](images/full_width_regular/0x23.png)
| `$24` | `$0000`| `N/A` | ![](images/full_width_regular/blank.png)
| `$25` | `$0000`| `N/A` | ![](images/full_width_regular/blank.png)
| `$26` | `$1EDE`| `$059EDE` | ![](images/full_width_regular/0x26.png)
| `$27` | `$1EF6`| `$059EF6` | ![](images/full_width_regular/0x27.png)
| `$28` | `$1F0E`| `$059F0E` | ![](images/full_width_regular/0x28.png)
| `$29` | `$0000`| `N/A` | ![](images/full_width_regular/blank.png)
| `$2A` | `$0000`| `N/A` | ![](images/full_width_regular/blank.png)
| `$2B` | `$0000`| `N/A` | ![](images/full_width_regular/blank.png)
| `$2C` | `$0000`| `N/A` | ![](images/full_width_regular/blank.png)
| `$2D` | `$1F86`| `$059F86` | ![](images/full_width_regular/0x2D.png)
| `$2E` | `$1F9E`| `$059F9E` | ![](images/full_width_regular/0x2E.png)
| `$2F` | `$0000`| `N/A` | ![](images/full_width_regular/blank.png)
| `$30` | `$1FCE`| `$059FCE` | ![](images/full_width_regular/0x30.png)
| `$31` | `$0000`| `N/A` | ![](images/full_width_regular/blank.png)
| `$32` | `$0000`| `N/A` | ![](images/full_width_regular/blank.png)
| `$33` | `$2016`| `$05A016` | ![](images/full_width_regular/0x33.png)
| `$34` | `$0000`| `N/A` | ![](images/full_width_regular/blank.png)
| `$35` | `$2046`| `$05A046` | ![](images/full_width_regular/0x35.png)
| `$36` | `$205E`| `$05A05E` | ![](images/full_width_regular/0x36.png)
| `$37` | `$2076`| `$05A076` | ![](images/full_width_regular/0x37.png)
| `$38` | `$208E`| `$05A08E` | ![](images/full_width_regular/0x38.png)
| `$39` | `$20A6`| `$05A0A6` | ![](images/full_width_regular/0x39.png)
| `$3A` | `$20BE`| `$05A0BE` | ![](images/full_width_regular/0x3A.png)
| `$3B` | `$20D6`| `$05A0D6` | ![](images/full_width_regular/0x3B.png)
| `$3C` | `$20EE`| `$05A0EE` | ![](images/full_width_regular/0x3C.png)
| `$3D` | `$2106`| `$05A106` | ![](images/full_width_regular/0x3D.png)
| `$3E` | `$211E`| `$05A11E` | ![](images/full_width_regular/0x3E.png)
| `$3F` | `$2136`| `$05A136` | ![](images/full_width_regular/0x3F.png)
| `$40` | `$214E`| `$05A14E` | ![](images/full_width_regular/0x40.png)
| `$41` | `$2166`| `$05A166` | ![](images/full_width_regular/0x41.png)
| `$42` | `$217E`| `$05A17E` | ![](images/full_width_regular/0x42.png)
| `$43` | `$2196`| `$05A196` | ![](images/full_width_regular/0x43.png)
| `$44` | `$21AE`| `$05A1AE` | ![](images/full_width_regular/0x44.png)
| `$45` | `$21C6`| `$05A1C6` | ![](images/full_width_regular/0x45.png)
| `$46` | `$21DE`| `$05A1DE` | ![](images/full_width_regular/0x46.png)
| `$47` | `$21F6`| `$05A1F6` | ![](images/full_width_regular/0x47.png)
| `$48` | `$220E`| `$05A20E` | ![](images/full_width_regular/0x48.png)
| `$49` | `$2226`| `$05A226` | ![](images/full_width_regular/0x49.png)
| `$4A` | `$223E`| `$05A23E` | ![](images/full_width_regular/0x4A.png)
| `$4B` | `$2256`| `$05A256` | ![](images/full_width_regular/0x4B.png)
| `$4C` | `$226E`| `$05A26E` | ![](images/full_width_regular/0x4C.png)
| `$4D` | `$2286`| `$05A286` | ![](images/full_width_regular/0x4D.png)
| `$4E` | `$229E`| `$05A29E` | ![](images/full_width_regular/0x4E.png)
| `$4F` | `$22B6`| `$05A2B6` | ![](images/full_width_regular/0x4F.png)
| `$50` | `$22CE`| `$05A2CE` | ![](images/full_width_regular/0x50.png)
| `$51` | `$22E6`| `$05A2E6` | ![](images/full_width_regular/0x51.png)
| `$52` | `$22FE`| `$05A2FE` | ![](images/full_width_regular/0x52.png)
| `$53` | `$2316`| `$05A316` | ![](images/full_width_regular/0x53.png)
| `$54` | `$232E`| `$05A32E` | ![](images/full_width_regular/0x54.png)
| `$55` | `$2346`| `$05A346` | ![](images/full_width_regular/0x55.png)
| `$56` | `$235E`| `$05A35E` | ![](images/full_width_regular/0x56.png)
| `$57` | `$2376`| `$05A376` | ![](images/full_width_regular/0x57.png)
| `$58` | `$238E`| `$05A38E` | ![](images/full_width_regular/0x58.png)
| `$59` | `$23A6`| `$05A3A6` | ![](images/full_width_regular/0x59.png)
| `$5A` | `$23BE`| `$05A3BE` | ![](images/full_width_regular/0x5A.png)
| `$5B` | `$23D6`| `$05A3D6` | ![](images/full_width_regular/0x5B.png)
| `$5C` | `$23EE`| `$05A3EE` | ![](images/full_width_regular/0x5C.png)
| `$5D` | `$2406`| `$05A406` | ![](images/full_width_regular/0x5D.png)
| `$5E` | `$241E`| `$05A41E` | ![](images/full_width_regular/0x5E.png)
| `$5F` | `$2436`| `$05A436` | ![](images/full_width_regular/0x5F.png)
| `$60` | `$244E`| `$05A44E` | ![](images/full_width_regular/0x60.png)
| `$61` | `$2466`| `$05A466` | ![](images/full_width_regular/0x61.png)
| `$62` | `$247E`| `$05A47E` | ![](images/full_width_regular/0x62.png)
| `$63` | `$2496`| `$05A496` | ![](images/full_width_regular/0x63.png)
| `$64` | `$24AE`| `$05A4AE` | ![](images/full_width_regular/0x64.png)
| `$65` | `$24C6`| `$05A4C6` | ![](images/full_width_regular/0x65.png)
| `$66` | `$24DE`| `$05A4DE` | ![](images/full_width_regular/0x66.png)
| `$67` | `$24F6`| `$05A4F6` | ![](images/full_width_regular/0x67.png)
| `$68` | `$250E`| `$05A50E` | ![](images/full_width_regular/0x68.png)
| `$69` | `$2526`| `$05A526` | ![](images/full_width_regular/0x69.png)
| `$6A` | `$253E`| `$05A53E` | ![](images/full_width_regular/0x6A.png)
| `$6B` | `$2556`| `$05A556` | ![](images/full_width_regular/0x6B.png)
| `$6C` | `$256E`| `$05A56E` | ![](images/full_width_regular/0x6C.png)
| `$6D` | `$2586`| `$05A586` | ![](images/full_width_regular/0x6D.png)
| `$6E` | `$259E`| `$05A59E` | ![](images/full_width_regular/0x6E.png)
| `$6F` | `$25B6`| `$05A5B6` | ![](images/full_width_regular/0x6F.png)
| `$70` | `$25CE`| `$05A5CE` | ![](images/full_width_regular/0x70.png)
| `$71` | `$25E6`| `$05A5E6` | ![](images/full_width_regular/0x71.png)
| `$72` | `$25FE`| `$05A5FE` | ![](images/full_width_regular/0x72.png)
| `$73` | `$2616`| `$05A616` | ![](images/full_width_regular/0x73.png)
| `$74` | `$262E`| `$05A62E` | ![](images/full_width_regular/0x74.png)
| `$75` | `$2646`| `$05A646` | ![](images/full_width_regular/0x75.png)
| `$76` | `$265E`| `$05A65E` | ![](images/full_width_regular/0x76.png)
| `$77` | `$2676`| `$05A676` | ![](images/full_width_regular/0x77.png)
| `$78` | `$268E`| `$05A68E` | ![](images/full_width_regular/0x78.png)
| `$79` | `$26A6`| `$05A6A6` | ![](images/full_width_regular/0x79.png)
| `$7A` | `$26BE`| `$05A6BE` | ![](images/full_width_regular/0x7A.png)
| `$7B` | `$26D6`| `$05A6D6` | ![](images/full_width_regular/0x7B.png)
| `$7C` | `$26EE`| `$05A6EE` | ![](images/full_width_regular/0x7C.png)
| `$7D` | `$2706`| `$05A706` | ![](images/full_width_regular/0x7D.png)
| `$7E` | `$271E`| `$05A71E` | ![](images/full_width_regular/0x7E.png)
| `$7F` | `$2736`| `$05A736` | ![](images/full_width_regular/0x7F.png)
| `$80` | `$274E`| `$05A74E` | ![](images/full_width_regular/0x80.png)
| `$81` | `$2766`| `$05A766` | ![](images/full_width_regular/0x81.png)
| `$82` | `$277E`| `$05A77E` | ![](images/full_width_regular/0x82.png)
| `$83` | `$2796`| `$05A796` | ![](images/full_width_regular/0x83.png)
| `$84` | `$27AE`| `$05A7AE` | ![](images/full_width_regular/0x84.png)
| `$85` | `$27C6`| `$05A7C6` | ![](images/full_width_regular/0x85.png)
| `$86` | `$27DE`| `$05A7DE` | ![](images/full_width_regular/0x86.png)
| `$87` | `$27F6`| `$05A7F6` | ![](images/full_width_regular/0x87.png)
| `$88` | `$280E`| `$05A80E` | ![](images/full_width_regular/0x88.png)
| `$89` | `$2826`| `$05A826` | ![](images/full_width_regular/0x89.png)
| `$8A` | `$283E`| `$05A83E` | ![](images/full_width_regular/0x8A.png)
| `$8B` | `$2856`| `$05A856` | ![](images/full_width_regular/0x8B.png)
| `$8C` | `$286E`| `$05A86E` | ![](images/full_width_regular/0x8C.png)
| `$8D` | `$2886`| `$05A886` | ![](images/full_width_regular/0x8D.png)
| `$8E` | `$289E`| `$05A89E` | ![](images/full_width_regular/0x8E.png)
| `$8F` | `$28B6`| `$05A8B6` | ![](images/full_width_regular/0x8F.png)
| `$90` | `$28CE`| `$05A8CE` | ![](images/full_width_regular/0x90.png)
| `$91` | `$28E6`| `$05A8E6` | ![](images/full_width_regular/0x91.png)
| `$92` | `$28FE`| `$05A8FE` | ![](images/full_width_regular/0x92.png)
| `$93` | `$2916`| `$05A916` | ![](images/full_width_regular/0x93.png)
| `$94` | `$292E`| `$05A92E` | ![](images/full_width_regular/0x94.png)
| `$95` | `$2946`| `$05A946` | ![](images/full_width_regular/0x95.png)
| `$96` | `$295E`| `$05A95E` | ![](images/full_width_regular/0x96.png)
| `$97` | `$2976`| `$05A976` | ![](images/full_width_regular/0x97.png)
| `$98` | `$298E`| `$05A98E` | ![](images/full_width_regular/0x98.png)
| `$99` | `$29A6`| `$05A9A6` | ![](images/full_width_regular/0x99.png)
| `$9A` | `$29BE`| `$05A9BE` | ![](images/full_width_regular/0x9A.png)
| `$9B` | `$29D6`| `$05A9D6` | ![](images/full_width_regular/0x9B.png)
| `$9C` | `$29EE`| `$05A9EE` | ![](images/full_width_regular/0x9C.png)
| `$9D` | `$2A06`| `$05AA06` | ![](images/full_width_regular/0x9D.png)
| `$9E` | `$2A1E`| `$05AA1E` | ![](images/full_width_regular/0x9E.png)
| `$9F` | `$2A36`| `$05AA36` | ![](images/full_width_regular/0x9F.png)
| `$A0` | `$2A4E`| `$05AA4E` | ![](images/full_width_regular/0xA0.png)
| `$A1` | `$2A66`| `$05AA66` | ![](images/full_width_regular/0xA1.png)
| `$A2` | `$2A7E`| `$05AA7E` | ![](images/full_width_regular/0xA2.png)
| `$A3` | `$2A96`| `$05AA96` | ![](images/full_width_regular/0xA3.png)
| `$A4` | `$2AAE`| `$05AAAE` | ![](images/full_width_regular/0xA4.png)
| `$A5` | `$2AC6`| `$05AAC6` | ![](images/full_width_regular/0xA5.png)
| `$A6` | `$2ADE`| `$05AADE` | ![](images/full_width_regular/0xA6.png)
| `$A7` | `$2AF6`| `$05AAF6` | ![](images/full_width_regular/0xA7.png)
| `$A8` | `$2B0E`| `$05AB0E` | ![](images/full_width_regular/0xA8.png)
| `$A9` | `$2B26`| `$05AB26` | ![](images/full_width_regular/0xA9.png)
| `$AA` | `$2B3E`| `$05AB3E` | ![](images/full_width_regular/0xAA.png)
| `$AB` | `$2B56`| `$05AB56` | ![](images/full_width_regular/0xAB.png)
| `$AC` | `$2B6E`| `$05AB6E` | ![](images/full_width_regular/0xAC.png)
| `$AD` | `$2B86`| `$05AB86` | ![](images/full_width_regular/0xAD.png)
| `$AE` | `$2B9E`| `$05AB9E` | ![](images/full_width_regular/0xAE.png)
| `$AF` | `$2BB6`| `$05ABB6` | ![](images/full_width_regular/0xAF.png)
| `$B0` | `$2BCE`| `$05ABCE` | ![](images/full_width_regular/0xB0.png)
| `$B1` | `$2BE6`| `$05ABE6` | ![](images/full_width_regular/0xB1.png)
| `$B2` | `$2BFE`| `$05ABFE` | ![](images/full_width_regular/0xB2.png)
| `$B3` | `$2C16`| `$05AC16` | ![](images/full_width_regular/0xB3.png)
| `$B4` | `$2C2E`| `$05AC2E` | ![](images/full_width_regular/0xB4.png)
| `$B5` | `$2C46`| `$05AC46` | ![](images/full_width_regular/0xB5.png)
| `$B6` | `$2C5E`| `$05AC5E` | ![](images/full_width_regular/0xB6.png)
| `$B7` | `$2C76`| `$05AC76` | ![](images/full_width_regular/0xB7.png)
| `$B8` | `$2C8E`| `$05AC8E` | ![](images/full_width_regular/0xB8.png)
| `$B9` | `$2CA6`| `$05ACA6` | ![](images/full_width_regular/0xB9.png)
| `$BA` | `$2CBE`| `$05ACBE` | ![](images/full_width_regular/0xBA.png)
| `$BB` | `$2CD6`| `$05ACD6` | ![](images/full_width_regular/0xBB.png)
| `$BC` | `$2CEE`| `$05ACEE` | ![](images/full_width_regular/0xBC.png)
| `$BD` | `$2D06`| `$05AD06` | ![](images/full_width_regular/0xBD.png)
| `$BE` | `$2D1E`| `$05AD1E` | ![](images/full_width_regular/0xBE.png)
| `$BF` | `$2D36`| `$05AD36` | ![](images/full_width_regular/0xBF.png)
| `$C0` | `$2D4E`| `$05AD4E` | ![](images/full_width_regular/0xC0.png)
| `$C1` | `$2D66`| `$05AD66` | ![](images/full_width_regular/0xC1.png)
| `$C2` | `$2D7E`| `$05AD7E` | ![](images/full_width_regular/0xC2.png)
| `$C3` | `$2D96`| `$05AD96` | ![](images/full_width_regular/0xC3.png)
| `$C4` | `$2DAE`| `$05ADAE` | ![](images/full_width_regular/0xC4.png)
| `$C5` | `$2DC6`| `$05ADC6` | ![](images/full_width_regular/0xC5.png)
| `$C6` | `$2DDE`| `$05ADDE` | ![](images/full_width_regular/0xC6.png)
| `$C7` | `$2DF6`| `$05ADF6` | ![](images/full_width_regular/0xC7.png)
| `$C8` | `$2E0E`| `$05AE0E` | ![](images/full_width_regular/0xC8.png)
| `$C9` | `$2E26`| `$05AE26` | ![](images/full_width_regular/0xC9.png)
| `$CA` | `$2E3E`| `$05AE3E` | ![](images/full_width_regular/0xCA.png)
| `$CB` | `$2E56`| `$05AE56` | ![](images/full_width_regular/0xCB.png)
| `$CC` | `$2E6E`| `$05AE6E` | ![](images/full_width_regular/0xCC.png)
| `$CD` | `$2E86`| `$05AE86` | ![](images/full_width_regular/0xCD.png)
| `$CE` | `$2E9E`| `$05AE9E` | ![](images/full_width_regular/0xCE.png)
| `$CF` | `$2EB6`| `$05AEB6` | ![](images/full_width_regular/0xCF.png)
| `$D0` | `$2ECE`| `$05AECE` | ![](images/full_width_regular/0xD0.png)
| `$D1` | `$2EE6`| `$05AEE6` | ![](images/full_width_regular/0xD1.png)
| `$D2` | `$2EFE`| `$05AEFE` | ![](images/full_width_regular/0xD2.png)
| `$D3` | `$2F16`| `$05AF16` | ![](images/full_width_regular/0xD3.png)
| `$D4` | `$2F2E`| `$05AF2E` | ![](images/full_width_regular/0xD4.png)
| `$D5` | `$2F46`| `$05AF46` | ![](images/full_width_regular/0xD5.png)
| `$D6` | `$2F5E`| `$05AF5E` | ![](images/full_width_regular/0xD6.png)
| `$D7` | `$2F76`| `$05AF76` | ![](images/full_width_regular/0xD7.png)
| `$D8` | `$2F8E`| `$05AF8E` | ![](images/full_width_regular/0xD8.png)
| `$D9` | `$2FA6`| `$05AFA6` | ![](images/full_width_regular/0xD9.png)
| `$DA` | `$2FBE`| `$05AFBE` | ![](images/full_width_regular/0xDA.png)
| `$DB` | `$2FD6`| `$05AFD6` | ![](images/full_width_regular/0xDB.png)
| `$DC` | `$2FEE`| `$05AFEE` | ![](images/full_width_regular/0xDC.png)
| `$DD` | `$3006`| `$05B006` | ![](images/full_width_regular/0xDD.png)
| `$DE` | `$301E`| `$05B01E` | ![](images/full_width_regular/0xDE.png)
| `$DF` | `$3036`| `$05B036` | ![](images/full_width_regular/0xDF.png)
| `$E0` | `$304E`| `$05B04E` | ![](images/full_width_regular/0xE0.png)
| `$E1` | `$3066`| `$05B066` | ![](images/full_width_regular/0xE1.png)
| `$E2` | `$307E`| `$05B07E` | ![](images/full_width_regular/0xE2.png)
| `$E3` | `$3096`| `$05B096` | ![](images/full_width_regular/0xE3.png)
| `$E4` | `$30AE`| `$05B0AE` | ![](images/full_width_regular/0xE4.png)
| `$E5` | `$30C6`| `$05B0C6` | ![](images/full_width_regular/0xE5.png)
| `$E6` | `$30DE`| `$05B0DE` | ![](images/full_width_regular/0xE6.png)
| `$E7` | `$30F6`| `$05B0F6` | ![](images/full_width_regular/0xE7.png)
| `$E8` | `$310E`| `$05B10E` | ![](images/full_width_regular/0xE8.png)
| `$E9` | `$3126`| `$05B126` | ![](images/full_width_regular/0xE9.png)
| `$EA` | `$313E`| `$05B13E` | ![](images/full_width_regular/0xEA.png)
| `$EB` | `$3156`| `$05B156` | ![](images/full_width_regular/0xEB.png)
| `$EC` | `$316E`| `$05B16E` | ![](images/full_width_regular/0xEC.png)
| `$ED` | `$0000`| `N/A` | ![](images/full_width_regular/blank.png)
| `$EE` | `$0000`| `N/A` | ![](images/full_width_regular/blank.png)
| `$EF` | `$0000`| `N/A` | ![](images/full_width_regular/blank.png)
| `$F0` | `$3186`| `$05B186` | ![](images/full_width_regular/0xF0.png)
| `$F1` | `$319E`| `$05B19E` | ![](images/full_width_regular/0xF1.png)
| `$F2` | `$31B6`| `$05B1B6` | ![](images/full_width_regular/0xF2.png)
| `$F3` | `$0000`| `N/A` | ![](images/full_width_regular/blank.png)
| `$F4` | `$0000`| `N/A` | ![](images/full_width_regular/blank.png)
| `$F5` | `$31CE`| `$05B1CE` | ![](images/full_width_regular/0xF5.png)
| `$F6` | `$31E6`| `$05B1E6` | ![](images/full_width_regular/0xF6.png)
| `$F7` | `$31FE`| `$05B1FE` | ![](images/full_width_regular/0xF7.png)
| `$FD` | `$09A6`| `$0589A6` | ![](images/full_width_regular/blank.png)
| `$FE` | `$0BA6`| `$058BA6` | ![](images/full_width_regular/blank.png)
| `$FF` | `$0DA6`| `$058DA6` | ![](images/full_width_regular/blank.png)

* Format: Index corresponds to the character byte in the script and the the Offset just the offset relative to **PRG**`$058000`, and Address is the beginning of the tile data for that character in ROM
* Observation: The empty entries line up with the bytes listed in [the TBD table](#tbd-table)
* The last three rows are the bytes that correspond to Kanji/Pascal strings, so this is probably used in those lookups as well 
* The missing capital english letters actually do exist in ROM (and are included in the images folder) but go unused