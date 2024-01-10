# Lookup Tables

These seem to be loaded using offset values stored starting at **PRG**`$117DCA`/**loROM**`$A2FDCA, and the index of this "pre-lookup-table" is determined by a check made after a character byte is loaded. 

From here, each of these lookup tables are relative to **PRG**`$117DCA`/**loROM**`$A2FDCA`

Each tables consists of an index, followed by two bytes for a reference value

* **PGR**`$117DCA`/**loROM**`$A2FDCA` loads `$0006`, which points to table at **loROM**`$117DD0`
    * This happens when loading non-kanji text
* * **PGR**`$117DCC`/**loROM**`$A2FDCC` loads `$002E`, which points to table at **loROM**`$117DF8`
    * This is happens if the byte is `$FD`, `$FE`, or `$FF` (aka it's a Kanji character)
* **PRG**`$117DCE`/**loROM**`$A2FDCE` loads `$00C8` which points to a table at **PRG**`$117E92`/**loROM**`$A2FE92`
    * Seems to be in a different format that the other two tables, need to investigate further

Stored at **PRG**`$117DD0`/**loROM**`$A2FDD0`

| Index | Data   |
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


Kanji Table (starts at **PRG**:`$117DF8`):
| Index | Data   |
|-------|--------|
| `$FF` | `$00F9`|
| `$FE` | `$010E`|
| `$FD` | `$0114`|
| `$FC` | `$011A`|
| `$FB` | `$0123`|
| `$FA` | `$0138`|
| `$F9` | `$013D`|
| `$F8` | `$0141`|
| `$F7` | `$0147`|
| `$F6` | `$014C`|
| `$F5` | `$0151`|
| `$F4` | `$0156`|
| `$F3` | `$015D`|
| `$F2` | `$0161`|
| `$F1` | `$016A`|
| `$F0` | `$016F`|
| `$EF` | `$0173`|
| `$EE` | `$0177`|
| `$ED` | `$017E`|
| `$EC` | `$0185`|
| `$EB` | `$018C`|
| `$EA` | `$0192`|
| `$E9` | `$0197`|
| `$E8` | `$019F`|
| `$E7` | `$01A4`|
| `$E6` | `$01AA`|
| `$E5` | `$01B1`|
| `$E4` | `$01BA`|
| `$E3` | `$01BF`|
| `$E2` | `$01C3`|
| `$E1` | `$01C7`|
| `$E0` | `$01CB`|
| `$DF` | `$01D0`|
| `$DE` | `$01D5`|
| `$DD` | `$01DA`|
| `$DC` | `$01DF`|
| `$DB` | `$01E5`|
| `$DA` | `$01EC`|
| `$D9` | `$01F1`|
| `$D8` | `$01F6`|
| `$D7` | `$01FB`|
| `$D6` | `$0204`|
| `$D5` | `$0209`|
| `$D4` | `$020D`|
| `$D3` | `$0212`|
| `$D2` | `$0216`|
| `$D1` | `$021B`|
| `$D0` | `$021F`|
| `$CF` | `$0223`|
| `$CE` | `$0227`|
| `$CD` | `$022C`|

* Per the romhacking forum notes, this table may also store some of the dictionary string
    * For example `$E8` actually appears to print two characters "博士" (the first two characters of dialogue in the script) which themselves are both kanji. 
        * TODO map this table out better, because the above table seems to just be a reference to another table possibly