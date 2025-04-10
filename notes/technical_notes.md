# Technical Notes

## Housekeeping

Address prefixes, for sake of reader sanity:

* **loROM** - 24-bit memory mapped address
* **PRG** - Linear ROM address
* **WRAM** - Work RAM
* **REL** - Relative address
* **VRAM** - Video RAM

(Warning/Apology: these notes are very scattered currently. Once I work out the entire text printing process and encoding, I'll try to organize them)

## Disassembly Notes

* Game uses **loROM** mapping, a lot of the code execution seems to happen in the **loROM** banks `$80`-`$85`
* First dialogue blob lives at **PRG**`$060000` in the ROM and is mapped to **loROM** addresses, `$0C8000`, `$4C8000`, `$8C8000`, and `$CC8000`
  * Possibly ends at **PRG**`$067F90`, there's a bunch of `$FF` byte padding until the end of the bank, and this lines up with the four **loROM** mapping locations
* Another Dialogue blob lives at **PRG**`$070000`
  * TODO Figure out what triggers flipping to this set vs **PRG**`$060000`
    * The opening sequence seems to flip between the two for some reason
    * At **loROM**`$82F87A` there's a pointer loaded from **WRAM**`$0007D`
    * There seems to be quite a long string of Things that happen to get to that point. Setting *DB* to `$BD` is something to keep in mind, as it seems to be important when the above. My guess is that this is a table to assist in pointing where to load a dialogue blob from? Going to need some more investigation
  * At **loROM**`$81FCCD`, there's a hardcoded `LDA #$8E`
    * Next at **loROM**`$81FCDF` there's a hardcoded `LDX #$8000`
    * Next The accumulator value (currently `$8E`) is pushed to the stack, and then immediately pulled back into the *DB* register (in other words, it's explicitly changing execution to a new memory bank)
    * Between *X* = `$8000` and *DB* = `$8E` the upcoming `LDA $0000,X` is now pointing to **loROM**`$8E8000` or, **PRG**`$070000`!
      * So that's HOW it's set, still need to figure out WHY this gets set
* More potential Dialogue blobs to investigate
  * Between **loROM**`$81FCAD` to **loROM**`$81FD16` there's possibly other references to look into
  * **loROM**`$A8BF75` (**PRG**`$143F75`) set at **loROM**`$81FCFB,$81FCFD`
  * **loROM**`$A3F239` (**PRG**`$11F239`) set at **loROM**`$81FCE9,$81FCEC`
  * **loROM**`$8FF524` (**PRG**`$07F524`) set at **loROM**`$81FCF1,$81FCF3`
  * **loROM**`$97F524` (**PRG**`$0BF524`) set at **loROM**`$81FD05,$81FD07`
  * **loROM**`$8FA2A6` (**PRG**`$07A2A6`) set at **loROM**`$81FD05,$81FD07`
  * Vehek on RHDN mapped out some of the dialogue chunks here: <https://datacrystal.romhacking.net/wiki/Idea_no_Hi:ROM_map>
* **WRAM**`$00043` is a counter used to control text printing speed
  * When starting a new file you pick message speed 1-7, 1 sets the counter to `#$01` (fastest), 4 (default) sets the counter to `$07`, 7 sets the counter to `#$0D` (slowest)
  * Setting adjusts the counter in increments of `#$02`
  * Counter is decremented at **loROM**`$85C07B`
  * Counter value is reset at **loROM**`$818FFF`
  * At **loROM**`$819008`, there is a loop that might be for idling until *NMI*, to start the *VBLANK* routine
    * Loop ends if counter `$43` is set to 0 (zero flag set in *status* register)
    * Immediately after this loop **loROM**`$851876` is set to zero (why?)
    * *A*, *Y*, *X* register states are restored from the stack and returns from the subroutine
* **loROM**`$8186F0` appears to be the exact instruction that will read in a text byte from ROM
  * This is accomplished using a pointer stored at **WRAM**`$00006` (aka load the address stored at address **WRAM**`$00006`)
  * The address seems to be an offset relative to the current dialogue blob, and is used to track how far within a dialogue blob we are
    * ex. if reading from **loROM**`$8C8000` (**PRG**`$060000`), relative address `$8000` will be stored at **WRAM**`$000006`and incremented each time a byte is read
* **loROM**`$7F2600` (**WRAM**`$12600`) seems to be the designated region of WRAM where tile data for characters is chucked to before it's DMA'd to VRAM
  * Seems to always use DMA Channel 7 for text drawing
  * A -> B transfer where A is set to `$7F2600` and B is set to `$18`
  * Dialogue Boxes have 3 lines, and **VRAM**`$2600-$31DF` seems to be the area used for drawing text characters (during the opening sequence at least, if the dialogue box is somewhere else, will this change?)
  * Addresses used to store/load DMA parameters in **WRAM**
    * **WRAM**`$0002E` - VRAM destination address
    * **WRAM**`$00030` - A Bus Address
    * **WRAM**`$00032` - A Bus Bank
    * **WRAM**`$00033` - Transfer Size
    * **WRAM**`$00035` - Another VRAM destination address (what makes this one different?)
    * **WRAM**`$00037` - Another A Bus Address
    * **WRAM**`$00039` - Another A Bus Bank
    * **WRAM**`$0003A` - Another Transfer size
* Around **loROM**`$818065`, this may be a routine for setting up tile data for the dialogue boxes
  * It spends a lot of time filling in `$FF` bytes between **WRAM**`$12420,$133CF`. This lines up very well with where character data is plopped into
* **WRAM**`$000CE` may be use for flags of some sort?
* Keep an eye on **WRAM**`$0002D`, it's checked at **loROM**`$85C037` and
  * **WRAM**`$0002D` is manually set to `#$03` at **loROM**`$818155`
  * This may be some sort of flag to signal that it's time to initiate DMA
* At **loROM**`$818670` there's a data copying step, that seems to use some hardcoded settings
  * `$03FF` bytes of data are copied from **PRG**`$12C9AE` (**loROM**`$7FC9AE`) to **WRAM**`$10000`
  * Unclear if this is relevant to text drawing, but keeping an eye on it none the less
* NPC dialogue loading appears to be handled in an interesting way
  * At **loROM**`$81FC7B` is the routine that determines the dialogue block to start pointing to
  * When an NPC is interacted with however, rather than loading a hardcoded pointer, an NPC will have an index based on "string number" within the block, and an offset is built on the fly with this information
  * Lets use the old man in front of the inn in Hachiouji town as an example:
    * When talking to him, the value of `$2C` is loaded from **WRAM**`$00002` into the *Y* register. Which means that his dialogue is the 44th string in the 
    * Then, starting at **loROM**`$81FD44`, there is a looping routine that will start looping through the text bytes
    * Each time the code finds a `$00` byte it will decrement *Y* and for every byte loaded *X* (the current offset into the block) will be incremented
    * Once *Y* is zero, that means we've located the offset of that NPC's dialogue and from there the regular text printing routines are executed
    * This is pretty good actually, it means that the inserter won't have to muck around with pointers as much as expected
    * Still unclear exactly where these values come from. I believe that the entire data for a town is loaded into memory upon entering, and that there are tables there have this data

## Text Encoding Notes

* `$0D` is a control code, used to indicate a line break
* `$05`- Main character (default: Kamekichi)
  * When encountered, **WRAM**`$00006` will be loaded with pointer `$0100`, meaning that the user selection for his name stored starting at **WRAM**`$00100`
* `$FD`, `$FE`, and `$FF` are control codes which indicate a reference to either Kanji characters, or pascal strings
  * When one of these three bytes are loaded, the following happens
        1. When byte is determined to not be a control character, (aka greater than or equal to `$10`), push *A* to the stack to remember it's value
        2. Check if byte is greater than or equal to `#$FD` (at **loROM**`$818728`)
        3. If so, load the next byte, and store that value at **WRAM**`$018DA`
        4. Push *DB* (the current bank) to the stack, and switch *DB* to bank `$A2`
        5. Load the value at **loROM**`$A2FDCC` (**PRG**`$117DCC`) into *X*
        6. The value in *X* is use to load from an offset of **loROM**`$A2FDCA` (**PRG**`$117DF8`) into *A*
        7. If *A* happens to be `$00`, jump execution to **loROM**`$818788`
            *`$00` seems to indicate the end of the table, so this means nothing was found in the table?
        8. Otherwise compare it to **WRAM**`$018DA` (the byte that was immediately after `$FD` in this example), and if it's equal to that byte, jump execution to **loROM**`$81874A`
        9. If less than the stored byte, increment *X* three times, then jump back to Step 6, and repeat. This is the routine to check if the byte is an [FD pascal string](/notes/lookup_tables.md#pascal-string-table-part-3)
            * Each "row" is three bytes, first byte is the index, and the second two form the reference value
        10. Once a matching index byte is found, the reference value is loaded to **WRAM**`$018DC`
        11. Next, the previous bank value is pulled from the stack and loaded to *DB*, the Kanji Table control code is pulled from the stack into *A*
        12. Execution jumps to **loROM**`$818A5D`
        13. *DB* is changed to `$A2` again
        14. The reference value previously stored in **WRAM**`$018DC`is loaded to *X* and used as an offset to against another load to **loROM**`$A2FDCA` (another table?), and that value is stored in **WRAM**`$018DE`
        15. Then, the reference value from the table is incremented by 1, copied into *A*, and `#$FDCA` is added (with carry) to *A* (why?)
        16. This new value is stored at **WRAM**`$00006` (the value used to track offset in dialogue blob was copied to the stack earlier), this new value appears to be used to track where the next byte will be?
        17. If the value stored at **WRAM**`$018DE` is zero, jump execution to **loROM**`$818AB4`
        18. If not, decrement the value at **WRAM**`$018DE`, and using the pointer stored at **WRAM**`$00006`, load the next byte
        19. If this byte is `$00` jump to **loROM**`$818AAF` (has not been encountered in disassembly yet)
        20. If not, check if it's greater than or equal to 10, and if yes, jump to **loROM**`$818AA3`
        21. Next, check if the byte is less than `#$FD`, and jump to **loROM**`$818AAA` if less
        22. If `#$FD` or higher, decrement the value at **WRAM**`$018DE`
        23. Once that's done, jump to **loROM**`$818C2C`
* `$00` is a control code to signal the end of a "chunk" of text, and to stop reading any further
  * When a `$00` is encountered, execution jumps to near the end of the **TEXT1** subroutine (**loROM**`$818793`) where it restores previous register status, and returns from the subroutine
* `$01`, `$02`, and `$03` are control codes used to select the font style, which are full-width, half-width, and a more limited 8x8 font
  * Although they're usually found at the beginning of a text chunk, they can be, and are used to switch the font on the fly in the middle of a sentence
  * When one of these is loaded it's decremented by one, execution jumps to **loROM**`$8187B8`, which stores this value at **WRAM**`$01878` and jumps back to **loROM**`$8186EE` where the next byte is loaded
  * At **loROM**`$818C2C`, this value is used to read from a pointer table at **PRG**`$058000`, which loads the offset of the corresponding font table to **WRAM**`$01901`
    * `$02` (`$03`) - Full-width characters
      * Mainly used for the regular dialogue boxes
      * Stored as 16x12 tiles in ROM
      * Represented with the "**\[Full\]**" tag in table files
      * `#$03C6` gets loaded to **WRAM**`$01901`
    * `$01` (`$02`) - Half-width characters
      * Used for certain menu and interface boxes (ex character status boxes and the file selection screen)
      * Stored as 8x12 tiles in ROM
      * Represented with the "**\[Half\]>**" tag in tables files
      * `#$01E6` gets loaded to **WRAM**`$01901`
      * When toggling a `$03` manually to `$02` in ROM, the game has no issue printing these characters in regular dialogue boxes! This is REALLY GOOD because it means the text drawing code can already handle 8x16 fonts! :D
    * `$00` (`$01`) - 8x8 characters
      * Seems to mostly be used in battles, like HP/MP/damage numbers, icons, and to label some text boxes like the psy powers
      * Represented with the "**\[8x8\]**" tag in table files
      * `#$0006` gets loaded to **WRAM**`$01901`
* `$10` - This is the "space" byte, however, in the decoding logic, if the byte is found to be higher than `#$10`, it's treated differently
  * When it's less, the value is decremented by one, left arithmetic shifted once, and jumps to an offset relative to that new value via a pointer `($879C,X)` (yeesh, but seems to be where control code handling happens)
  * When it's greater than `#$10` it's likely that this means it's a drawable character, and less than are non-drawable control characters
* `$0F` - This is specifically checked for (at **loROM**`$818703`) and is a pascal string that ends the current dialogue chunk and starts a new one with an asterisk in place of the character name. See [Pascal String Table Part 1](/notes/lookup_tables.md#pascal-string-table-part-1)
        * First occurrence within a dialogue blob appears to be at **PRG**`$060640` (**loROM**`$8C8640`)
* Text characters are stored in a 1bpp format in ROM, but are converted to 2bpp before being DMA'd to VRAM
  * Bitplane 1 seems to always be rows of `$FF` bytes and Bitplane 2 follows the actual character pixels. Example of an 8x8 character stored at **VRAM**`$00E0`: [![1bpp to 2bpp](/images/1bpp_to_2bpp_thumb.png)](/images/1bpp_to_2bpp.png)
* When a printable character byte is found, this is how the code figures out where the corresponding graphics data is stored in ROM ([also detailed in the Graphics Lookup tables](/notes/lookup_tables.md#graphics-lookup-tables))
    1. First, the table stored at **PRG**`$117DD0`/**loROM**`$A2FDD0` (see [lookup_tables.md](lookup_tables.md#lookup-tables)) and scanned to see if the byte represents a [Pascal string](/notes/lookup_tables.md#pascal-string-table-part-2))
    2. Offset value `#$03C6` is loaded and stored at **WRAM**`$01901`. This was determined by the fact that the text chunk started with `$03` (see section above about the font control bytes)
    3. The text byte is then loaded, subtracted by `#$0010`, doubled (by using an ASL command), and then the result is added with the previous Offset value, to obtain a new Offset value which is stored at **WRAM**`$01901`
        * In the case of `$D3` (「), this new Offset points to the start of the tile data for that character
* The routine that takes the 1bpp data for half-width characters from ROM and converts it to 2bpp in RAM starts at **loROM**`$818EFE`
  * Full-width is at **loROM(**`$818CD9`. It's pretty similar, but I believe there's also logic to squish the characters closer together, because they do not perfectly align to 16x16 tiles (almost like a VWF routine)
  * It's fairly straightforward and "should" (famous last words) be simple enough to modify to handle 8x16 data straight from ROM
  * Unmodified, the routine will always pad the first two and last two rows of the bitmap (in other words, four `$FF` bytes before and after), which is how the ROM data gets converted to 8x16 or 16x16
  * Because of how the palette is set for text, bitplane 1 will ALWAYS be rows of `$FF` (regardless of which font style we're looking at)
  * The tl;dr of how this routine works is that through comparing and flipping values stored in some "variables", it will read through the tile data one byte at a time, but will alternating between first writing `$FF` to **WRAM** and then the current byte of tile data, and so on until 12/24 bytes are read depending on the font used
  * So let's step through it with the half-width version of character `$35` (あ). The number of bytes it needs to read through is stored at **WRAM**`$0190A` which in this case will start at `#$0C` (because half-width tiles are 12 bytes in length). Additionally, **WRAM**`$0190C` and **WRAM**`$0190B` are at some point initialized to both store `#$02`
    1. Before this routine starts, there's some setup to obtain the correct Offset that points to the region of **WRAM** where tile data is staged (WRAM Offset going forward)
        1. A value set at **WRAM**`$00005` (`#$13` in this case), is `XBA`'d to become `#$1300`, divided by 2 twice, and the resulting value `#$04C6` is stored at **WRAM**`$01873`, which later doubled three times to become `#$2630`
            *Haven't quite tracked down where and when this initial value this is set, but it's not super important to understanding how this routine works
        2. This number is important because it corresponds with the first segment of **WRAM** where the character tiles are copied to, before being DMA'd to **VRAM**
        3. Lastly, `#$04` is added to this value, and I believe this is for padding the first two rows with `$FF` bytes
            * Important to note that this region of **WRAM** is pre-filled with `$FF` bytes already (my guess is because of the dialogue box being drawn on screen already)
    2. Once execution reaches **loROM**`$818EFE`, the [Graphics Offset](/notes/lookup_tables.md#half-width-text-table) for `$35` is loaded from **WRAM**`$01901` (it was previously stored there after that byte was loaded from the script), and is used to load the first byte of the tile data into **WRAM**`$1905`
    3. **WRAM**`$0190C` is set to `#$01`
    4. The value of **WRAM**`$0190B` (currently `#$02`) is check if it's equal to **WRAM**`$0190C` (currently `#$01`) and since it's not, `$FF` is written to **WRAM**
    5. Next, **WRAM**`$0190C` is checked if it's value is `#$01`, and if it is, it's value is flipped back to `#$02`,
    6. WRAM Offset is incremented by 1
    7. **WRAM**`$0190C` and **WRAM**`$0190B` values are compared again, but since they are equal, the tile byte is loaded back in from memory
    8. The tile byte is then `EOR`'d against `#$FF` (aka every bit is flipped) and written to **WRAM**
        *This is done so that the palette index for the "background" is always 3, and the actual character pixels are always index 1
    9. **WRAM**`$0190C` is checked if it's equal to `#$01` and if it's not, **WRAM**`$0190A` is decremented
    10. If **WRAM**`$190A` is zero after this step, then the loop is finished and execution resumes at **loROM**`$818F6B`
    11. If not, **WRAM**`$0190C` is flipped to `#$01`, and the Graphics Offset at **WRAM**`$01905` is incremented once
    12. **WRAM**`$01878` is checked if it's `#$00` and if yes, jumps to **loROM**`$818F63` (why?)
    13. **WRAM**`$0190A` is checked if it's `#$06` and if it is, `#$01F1` is added to the WRAM Offset and execution jumps back to **loROM**`$818EFE` where the loop starts (step 2)
        * Once the routine has written 6 bytes, that means the top 8x8 tile of the set is finished being set up, so adding `#$01F1` to the WRAM Offset, points the offset to where the bottom 8x8 tile of the set is stored
    14. If not, the WRAM Offset is incremented once, and then execution jumps back to Step 2 where the loop repeats
  * Once the loop is finished, **WRAM**`$01873` is incremented twice, which will set up the next run of the loop to point to the next block of space in **WRAM** to start writing characters
  * There will definitely be some logic somewhere to increment the WRAM Offset properly to account for the three lines in the dialogue box, but the actual setup routine above should work the same regardless
  * Thinking that to read 8x16 tiles from ROM, I'll just need to adjust offsets and the counter used for reading bytes in? Maybe? Hopefully? Oh god please let it be that simple?
  * `$04` is a control code that's used to change the color of the characters
    * When it's encountered, the following byte will determine what the color will be (calling this the Color Byte)
    * Two things happen when `$04` is read in:
          1. The Color Byte's value is first copied to the stack, then AND'd with `#$06`, doubled, and stored at **WRAM**`$01909`
          2. The Color Byte's value is pulled from the stack AND'd with `#$01`, incremented once, and then stored at **WRAM**`$0190B`
    * From what I can tell, these values are then used to manipulate palette data by ORA'ing the upper byte of each of the four tiles that will be used to display the next character, with the value stored in **WRAM**`$01909`. This routine runs every time a character needs to be drawn, but by default nothing happens
      * Haven't really worked out *exactly* how this works, but honestly it's not super important imo. Just documenting the ones used in the script is enough
      * It can display quite a few different colors, but within the script only three are used:
        * White (default) - `$04 $01`
        * Orange - `$04 00`
        * Blue - `$04 02`
  * `$06` will print out a string stored at **WRAM**`$00720`, but this control code doesn't seem to appear in any of the known blocks of text, so it's function is unknown
  * `$07` and `$08` control the text printing speed, by setting a flag at **WRAM**`$01879`
    * `$07` sets the flag to `#$01` which is slow
    * `$08` sets the flag back to `$#00`, which is the regular player selected speed
  * `$09` is a little strange, but from poking around, I believe that it's supposed to represent whoever is the current party leader?
    * When `$09` is loaded, it first checks if the value at **WRAM**`$00A83` is set to `#$08` and if it is, it jumps to the same routine as when `$06` is loaded. Still unclear what that value is, so might need to play a bit into the game to find out
    * When it's not `$08` it takes the value from **WRAM**`$00A83`, decrements it once, sends it to the Multiplicand Register `$4202`, and loads `#$E0` to the Multiplier Register `$4203`
      * It then takes the low byte of the result, adds it to `#$0100` and stores that at **WRAM**`$00006`
        * When **WRAM**`$00A83` is `#$01`, then it results in Kamekichi's name getting printed
    * Why I think this, is that at **PRG**`$069D64` is the string `[Full] [$09]は ヘリコプターに[LineBreak] 石油を入れた[End]`, which roughly translates to `[Full] [$09] put [LineBreak] fuel into the helicopter [End]`
      * There's other lines like this as well, this is just one example
  * `$0A` brings up the Yes/No/Uhh prompt
  * `$0B` brings up the Yes/No prompt
  * `$0C` is the prompt for the appraiser shop. There are three options:
    1. 第一の力 (First Power)
    2. 第ニの力 (Second Power)
    3. やめる (Quit)
  * `$0E` brings up a blank 3 option prompt on the current line of text, so the options need to be spaced out properly to line up with where the cursor jumps between
  * The button prompt to clear the text box and show more text when the text box is full appears to happen automatically within the game's code. Need to look into it more, but it seems to "just work" with both full and half width fonts
  * Full width text is almost certainly doing something like a VWF so it's really worth figuring out if/how it can be reused
    * At **loROM**`$818CE7` after the next two graphics bytes are loaded from ROM, something strange happens, if **WRAM**`$01877` is found to be greater than 0:
      1. The two bytes are `XBA`'d (swapped places in *A* register)
      2. Then `LSR` is performed 4 times
      3. Then `XBA`'d again
      4. That result is stored at **WRAM**`$1905`
    * At *loROM**`$818D31` there is a check against **WRAM**`$01877` to see if it's greater than zero, and when it is, some interesting stuff happens
      1. It will load the current byte relative to the offset counter stored in the *X* register
      2. Perform an `AND #$F0`
      3. Store the result back at the same location
      4. Pull from the stack
      5. Perform `AND #$0F` on that value
      6. Then `ORA` against current offset byte from step 3
      7. Push to stack
      8. Pull from Stack
      9. And store that final value at the same location
    * These above things seem to be the secret sauce of squishing characters closer to each other


## Menu Hacking

* When opening up the main menu, the game draws the the boxes in the following order:
  * Money -> Status Box(es) -> Menu Box
* **loROM**`$81806D` is the routine that sets up the area in **WRAM** that's used to stage the tile data used when drawing menus
  * Currently unsure how much of this space is reserved, but it starts at **WRAM**`$10400`/**loROM**`$7F0400`
* At **loROM**`$81E6EE` is what I think is a lookup routine to determine the dimensions or size of the money box
  * Adjusting the `LDX #$040A` instruction changes the size of the money box. Increasing the upper byte makes the box taller, and the lower byte, makes it wider.
  * The values are stored in **WRAM**`$00004` and **WRAM**`$00005`
  * The routine that draws the borders around boxes uses these as well, so it just works
  * To shift the box over by one tile need to modify the following offsets:
    * **loROM**`$81E6F2`: `LDX #$0214` -> `LDX #$0215`
    * **loROM**`$81E705`: `LDX #$0315` -> `LDX #$0316`
    * **loROM**`$81E716`: `LDX #$0317` -> `LDX #$0318`
* **loROM**`$82A0BB` is the routine to draw the status boxes
  * Unlike with the money box, adjusting the dimension bytes doesn't automatically adjust the borders
  * **WRAM**`$01988` is probably a variable used to track how many characters are in the party
    * Manually changing this draws more boxes, even with no party members (but it gets super buggy)
* At **PRG**`$0148FA` is a table that stores the geometry, coordinates, and configurations of certain menu boxes!
  * Each entry is 8 bytes long, "offsets" are relative to the upper left most tile, and for geometry/offset values, 1 byte = 1 tile (e.g. Width = `$13` means the window will be 19 tiles wide)
    * See the [menu drawing lookup table](/notes/lookup_tables.md#menu-drawing-table) for all entries
  * First entry controls the main menu, and setting the overall value to `01 02 14 C7 00 02 02 09` gives a menu wide enough to accommodate 8 character long strings
* Wardrobe menu drawing code is separate from the main menu lookup table, and uses hardcoded dimensions and unique routines for drawing the window content
  * Drawing order seems to be: stat box -> clothing list -> selection menu
  * Starts at **loROM**`$81F155`
  * Stat Box Dimensions (resize to 14x7 tiles, and shift to the right by 3 tiles):
    * **loROM**`$81F161`/**PRG**`$00F161`: `LDX #$020E` -> `LDX #$0211`
    * **loROM**`$81F166`/**PRG**`$00F166`: `LDX #$0610` -> `LDX #$070E`
  * Stat Box:
    * Drawing order: window -> stat labels -> resistance labels -> stat values -> resistance values
    * Stat labels (shift right by 3 tiles):
      * **loROM**`$81F16F`/**PRG**`$00F16F`: `LDX #$030F` -> `LDX #$0312`
      * **loROM**`$81F185`/**PRG**`$00F185`: `LDX #$050F` -> `LDX #$0512`
    * Stat values (shift right by 4 tiles):
      * **loROM**`$81F1D1`/**PRG**`$00F1D1` (Power): `LDA #$0311` -> `LDA #$0315`
      * **loROM**`$81F205`/**PRG**`$00F205` (Defense): `LDA #$0317` -> `LDA #$031B`
      * **loROM**`$81F230`/**PRG**`$00F230` (Speed): `LDA #$0511` -> `LDA #$0515`
      * **loROM**`$81F25B`/**PRG**`$00F25B` (Luck): `LDA #$0517` -> `LDA #$051B`
    * Resistances:
      * This one is a little trickier, starting at **loROM**`$81F1A2`/**PRG**`$00F1A2` is the routine to draw these. Which does them vertically, instead of the horizontal orientation we're planning
      * The horizontal offset is `#$1B`and is written to **WRAM**`$00002` each loop
      * Vertical offset is stored at **WRAM**`$00003` for the actual drawing, but is also stored in a temporary variable at **WRAM**`$0190F`, where it's incremented once each loop to increase the tile offset
      * Flipping which value gets written to which variable seems to work for getting them horizontal
      * From **loROM**`$81F1BA`/**PRG**`$00F1BA` to **loROM**`$81F1CA`/**PRG**`$00F1CA` I was able to modify the routine to do `INC $190F` three times, fit it within the exact same number of bytes, by changing some instructions and removing others that didn't seem to be necessary (the SEP and REP). Seems to work so far, but keep an eye on it!
        * Original routine:

        ```assembly
          LDA #$00
          STA $07
          JSL $81FC0D
          INC $190F
          INX
          REP #$20
          TXA
          SEP #$20
        ```

        * New Routine:

        ```assembly
        STZ $07
        JSL $81FC0D
        INC $190F
        INC $190F
        INC $190F
        INX
        TXA
        ```

      * Resistance icon repositioning (move them to be 1 tile to the right of the label):
        * **loROM**`$81F2A7`/**PRG**`$00F2A7` (Heat): `LDX #$031C` -> `LDX #$0713`
        * **loROM**`$81F2CE`/**PRG**`$00F2CE` (Cold): `LDX #$041C` -> `LDX #$0716`
        * **loROM**`$81F2FA`/**PRG**`$00F2FA` (Electric): `LDX #$051C` -> `LDX #$0719`
        * **loROM**`$81F322`/**PRG**`$00F322` (Mind): `LDX #$061C` -> `LDX #$071C`
  * Clothing List:
    * Drawing order: window -> clothing label -> kanji subscript -> equipped item
    * Geometry values (Widen by two tiles, and shift left by one tile):
      * **loROM**`$81EF04`/**PRG**`$00EF04`: `LDX #$080F` -> `LDX #$090D`
      * **loROM**`$81EF09`/**PRG**`$00EF09`: `LDX #$1210` -> `LDX #$1212`
    * The reason the bottom row of tiles (the bottom border) gets cut off is because the initial DMA of the final set of tiles only transfers 512 bytes (`$200`) and to get it to transfer the last row it needs to transfer 768 bytes (`$300`), this value is set somewhere at **WRAM**`$0003A`
      * This was a pain, but it seems that at **loROM**`$829150`/**PRG**`$011150` is `LDX #$1802` and changing that to `LDX #$1902` allows the bottom row to draw. Best guess is that this is some sort of counter that's also used to calculate how much more of WRAM needs to be DMA'd over?? @_@
    * Clothing label:
      * **loROM**`$81EF17`/**PRG**`$00EF17`: `LDA #$0F` -> `LDA #$0E`
      * Y-position (and row contents?) is controlled by a small table at **PRG**`$00EFCB`
    * Kanji subscript drawing routine is from **loROM**`$81EF47 - $81EF88` and it's going to be completely unnecessary for english text, so best idea is to just skip it with a JMP. Bonus is that this frees up 67 bytes to use for custom code! :D
    * Clothing Text (Shift down by one tile and shift left by 3 tiles):
      * **loROM**`$81EF8D`/**PRG**`$00EF8D`: `LDA #$09` -> `LDA #$0A`
      * **loROM**`$81EFA6`/**PRG**`$00EFA6`: `LDA #$13` -> `LDA #$10`
    * Clothing selection arrow (shift down one tile and left one tile):
      * **loROM**`$8295AE`/**PRG**`$0115AE`: `LDA #$0E` -> `LDA #$0D`
      * **loROM**`$8295B3`/**PRG**`$0115B3`: `LDA #$09` -> `LDA #$0A`
    * Select from Inventory Window (widen to 16 tiles wide and shift left by 1 tile)
      * When you close this window, it leaves the widened parts because the game doesn't know there's extra tiles to clear out. Need to find a way to remedy this
      * **loROM** `$8296FC`/**PRG**`$0116FC`: `LDX #$0602` -> `LDX #$0601`
      * **loROM** `$829701`/**PRG**`$011701`: `LDX #$140C` -> `LDX #$1410`
    * Select from inventory window text (shift left by 2 tiles):
      * **loROM**`$82980E`/**PRG**`$01180E`: `LDA #$04` -> `LDA #$02`
    * Select from inventory window arrow (shift left by 2 tiles):
      * Needs to be updated in two different spots to take effect. I think it covers both the wear and swap options
      * **loROM**`$829886`/**PRG**`$011886`: `LDX #$0703` -> `LDX #$0701`
      * **loROM**`$829A22`/**PRG**`$011A22`: `LDA #$03` `LDA #$01`
    * Clothing Swap Text (shift left 2 tiles):
      * **loROM**`$82972B`/**PRG**`$01172B`: `LDA #$04` -> `LDA #$02`
  * Inventory Menus (Items option on field menu):
    * Drawing order: "Who?" prompt -> Inventory List -> (after choosing) item actions menu -> (after choosing) Redraw Inventory List
    * "Who?" prompt drawing routine is at **loROM**`$82B479`/**PRG**`$013479`
      * Shouldn't need geometry adjustments, there's already room for 4 characters!
      * X/Y-Offset values are set at **loROM**`$82B47E`/**PRG**`$01347E` and are `LDX #$0C02`
      * Relocate to the top left corner (shift left 1 tile and up 10 tiles):
        * **loROM**`$82B47E`/**PRG**`$01347E`: `LDX #$0C02` -> `LDX #$0201`
        * **loROM**`$82B48C`/**PRG**`$01348C`: `LDX #$0D03` -> `LDX #$0302`
          * Text offset
        * **loROM**`$82B499`/**PRG**`$013499`: `LDX #$040C` -> `LDX #$0402`
          * Actually have no idea why this one needs to be adjusted too, but without it, the window doesn't draw until a character is selected, when it's supposed to do that before. Bugs me not knowing why but it works so idk
    * Inventory Window (shift left seven tiles and widen to 30 tiles):
      * **loROM**`$81E7FF`/**PRG**`$00E7FF`: `LDA #$08` -> `LDA #$01`
      * **loROM**`$81E818`/**PRG**`$00E818`: `LDA #$16` -> `LDA #$1E`
    * Inventory Window Clearing Parameters:
      * **loROM**`$8281AD`/**PRG**`$0101AD`: `LDX #$0608` -> `LDX #$0601`
      * **loROM**`$8281B2`/**PRG**`$0101B2`: `LDX #$0A16` -> `LDX #$0A1E`
      * These two help preserve the bottom part of the main field menu so there's no tile flickering while clearing the inventory window:
        * **loROM**`$828098`/**PRG**`$010098`: `LDX #$0608` -> `LDX #$0601`
        * **loROM**`$82809D`/**PRG**`$01009D`: `LDX #$0208` -> `LDX #$0214`
    * Inventory Window Cursor (shift left 7 tiles):
      * **loROM**`$82D312`/**PRG**`$015312`: `ADC #$09` -> `ADC #$02`
      * **loROM**`$82D2E8`/**PRG**`$0152E8`: `LDX #$0709` -> `LDX #$0702`
        * This one specifically is the starting position when the window is first drawn, and the above instruction is used when the cursor position is changed
        * The way the position of the cursor is set when switching between columns is proving tricky, but it seems to start around **loROM**`$82D366` where the value of **WRAM**`$0198F` is checked. If it's 0 it gets incremented, and from there it gets ASL'd three times, to get `$0C` which is then used as offset to move the cursor to the right column. When it's 1, it gets decremented once, setting it to `$00`, so that when it gets ASL'd, nothing happens and the offset is `$02`, putting in the right spot
    * Inventory Window Text:
      * **loROM**`$82D026`/**PRG**`$015026`: `LDA #$0A` -> `LDA #$03`
        * This is the offset used when redrawing the text when scrolling through the list, and is separate from the initial drawing, like with the cursor
        * The initial text X-offset positioning is calculated by taking the window x-offset, storing at **WRAM**`$01991`, and at **loROM**`$81E918` that value is loaded into the accumulator (with an `ADC`), incremented twice, and stored at **WRAM**`$01A4D`
        * Column Spacing (widen to 13 tiles):
          * **loROM**`$81E90A`/**PRG**`$00E90A`: `LDA #$0A` -> `LDA #$0E`
            * For the initial drawing
          * **loROM**`$82D1A5`/**PRG**`$0151A5`: `ADC #$0A` -> `ADC #$0E`
            * When scrolling down
          * **loROM**`$82D0B5`/**PRG**`$0150B5`: `ADC #$0A` -> `ADC #$0E`
            * When scrolling up
          * These six values need to be adjusted so that all of the text scrolls properly. Again, I don't really know *why* this is needed exactly, but it works @_@. Thinking it has something to do with how items that stack work, because before getting all of these lined up correctly, those would not scroll the correct number of tiles
            * Scrolling Up:
              * **loROM**`$82D062`/**PRG**`$015062`: `LDA #$13` -> `LDA #$1E`
              * **loROM**`$82D07F`/**PRG**`$01507F`: `LDX #$0113` -> `LDX #$011E`
              * **loROM**`$82D0FD`/**PRG**`$0150FD`: `LDA #13` -> `LDA #$1E`
            * Scrolling Down:
              * **loROM**`$82D13B`/**PRG**`$01513B`: `LDA #$13` -> `LDA #$1E`
              * **loROM**`$82D15B`/**PRG**`$01515B`: `LDX #$0113` -> `LDX #$011E`
              * **loROM**`$82D1E6`/**PRG**`$0151E6`: `LDA #13` -> `LDA #$1E`
    * Item Description Window:
      * **loROM**`$82D338`/**PRG**`$015338`: `LDX #$0208` -> `LDX #$0207`
      * **loROM**`$81ED00`/**PRG**`$00ED99`: `LDX #$0416` -> `LDX #$0418`
      * These values control which tiles are copied before being overwritten with the description window. Adjusting these prevents flickering after the window closes
        * Use option:
          * **loROM**`$828202`/**PRG**`$010202`: `LDX #$0208` -> `LDX #$0207`
          * **loROM**`$828207`/**PRG**`$010207`: `LDX #$0408` -> `LDX #$040E`
          * **loROM**`$828210`/**PRG**`$010210`: `LDX #$0214` -> `LDX #$0215`
        * Give option:
          * **loROM**`$8283D5`/**PRG**`$0103D5`: `LDX #$0208` -> `LDX #$0207`
          * **loROM**`$8283DA`/**PRG**`$0103DA`: `LDX #$0408` -> `LDX #$040E`
          * **loROM**`$8283E3`/**PRG**`$0103E3`: `LDX #$0214` -> `LDX #$0215`
        * Move option:
          * **loROM**`$8288CD`/**PRG**`$0108CD`: `LDX #$0208` -> `LDX #$0207`
          * **loROM**`$8288D2`/**PRG**`$0108D2`: `LDX #$0408` -> `LDX #$040E`
          * **loROM**`$8288DB`/**PRG**`$0108DB`: `LDX #$0214` -> `LDX #$0215`
        * Toss option:
          * **loROM**`$828AA3`/**PRG**`$010AA3`: `LDX #$0208` -> `LDX #$0207`
          * **loROM**`$828AA8`/**PRG**`$010AA8`: `LDX #$0408` -> `LDX #$040E`
          * **loROM**`$828AB1`/**PRG**`$010AB1`: `LDX #$0214` -> `LDX #$0215`
    * Item Actions Window:
      * This one has it's values stored in the [Field Menus Lookup Table](/notes/lookup_tables.md#field-menus-lookup-table) at **PRG**`$014902`
        * Shift left 1 tile:
          * **PRG**`$014902`: `$02 $09 $02 $06 $08 $CB $00 $01 $04` -> `$02 $09 $01 $06 $08 $CB $00 $01 $04`
      * These values need to be adjusted to prevent tile flickering when the actions window is closed. I believe these control how much tile data is copied to preserve the original tiles before being overwritten with the actions menu
        * **loROM**`$8280F5`/**PRG**`$0100F5`: `LDX #$0808` -> `LDX #$0801`
        * **loROM**`$8280FA`/**PRG**`$0100FA`: `LDX #$0402` -> `LDX #$0409`
        * This copy actually happens before the window is drawn
        * The tiles are copied starting from the **WRAM**`$10C00` range and stored in the **WRAM**`$14000` range
  * I think I've worked out how what the numbers used to prevent tile flickering mean. They define a box with screen coordinates in tiles to copy the tile data that will be overwritten by the menu about to be drawn, to a separate part of WRAM
    * Using the Item Description Window as an example, it needs two instructions updated, `LDX #$0208` -> `LDX #$0207` and `LDX #$0408` -> `LDX #$040E` and those two specifically are meant to preserve whatever part of the main field menu window will be overwritten. The money box has it's own set of coordinates that function the same way
      * In this example, the lower byte of `#$0207`, `$02`, is the Y-coordinate and the upper byte, `$07` is the X-Coordinate, and these define the "upper-left" corner of the box
      * The next set `#$040E` works the same way for height and width respectively, so the box will start at Tile 2,7 on screen, and be 14 tiles wide by 4 tiles tall
  * Special Ability Windows:
    * These follow more or less the same patterns as the inventory window
    * Ability Window geometry and placement (shift left 7 tiles and widen to 30 tiles):
      * **loROM**`$81EAEA`/**PRG**`$00EAEA`: `LDA #$08` -> `LDA #$01`
      * **loROM**`$81EAFE`/**PRG**`$00EAFE`: `LDX #$0A16` -> `LDX #$0A1E`
    * Ability Window Clearing Parameters:
      * **loROM**`$828CD3`/**PRG**`$010CD3`: `LDX #$0608` -> `LDX #$0601`
      * **loROM**`$828CD8`/**PRG**`$010CD8`: `LDX #$0A16` -> `LDX #$0A1E`
      * Preserve the bottom row the main field menu to prevent flickering when closing the ability window:
        * **loROM**`$828C4E`/**PRG**`$010C4E`: `LDX #$0A08` -> `LDX #$0A01`
        * **loROM**`$828C53`/**PRG**`$010C53`: `LDX #$0202` -> `LDX #$0209`
    * Ability Window Text:
      * Right Column initial placement:
        * **loROM**`$81EB8A`/**PRG**`$00EB8A`: `LDA #$0A` -> `LDA #$0E`
      * Left Column placement while redrawing:
        * ~~**loROM**`$81EC90`/**PRG**`$00EC90`: `LDA #$0A` -> `LDA #$0E`~~
          * Not actually sure about this one, the default value doesn't actually seem to make a difference, so keep it that way for now
      * Scrolling:
        * **loROM**`$82D9DC`/**PRG**`$0159DC`: `LDA #$0A` -> `LDA #$03` (left column, up and down)
        * **loROM**`$82DA81`/**PRG**`$015A81`: `ADC #$0A` -> `ADC #$0E` (up)
        * **loROM**`$82DA0E`/**PRG**`$015A0E`: `LDA #$13` -> `LDA #$1E` (up)
        * **loROM**`$82DAE8`/**PRG**`$015AE8`: `LDA #$13` -> `LDA #$1E` (up)
        * **loROM**`$82DA2B`/**PRG**`$015A2B`: `LDX #$0113` -> `LDX #$011E` (up)
        * **loROM**`$82DBB3`/**PRG**`$015BB3`: `ADC #$0A` -> `ADC #$0E` (down)
        * **loROM**`$82DB26`/**PRG**`$015B26`: `LDA #$13` -> `LDA #$1E` (down)
        * **loROM**`$82DBE9`/**PRG**`$015BE9`: `LDA #$13` -> `LDA #$1E` (down)
        * **loROM**`$82DB46`/**PRG**`$015B46`: `LDX #$0113` -> `LDX #$011E` (down)
      * Cursor
        * **loROM**`$82DCF8`/**PRG**`$015CF8`: `LDA #$09` -> `LDA #$02` (initial draw)
        * **loROM**`$82DD76`/**PRG**`$015D76`: `ADC #$09` -> `ADC #$02` (redraws)
        * **loROM**`$82DD6D`/**PRG**`$015D6D`: `LDA #$0A` -> `LDA #$0E` (column switching)
    * Ability Description Window (shift left 1 tile):
      * The geometry values are shared with the item description window, so only the X-offset needs adjusted
      * **loROM**`$82DD9B`/**PRG**`$015D9B`: `LDX #$0208` -> `LDX #$0207`
      * Values for copying and restoring overwritten tiles:
        * Use option:
          * **loROM**`$828D28`/**PRG**`$010D28`: `LDX #$0208` -> `LDX #$0207`
          * **loROM**`$828D2D`/**PRG**`$010D2D`: `LDX #$0408` -> `LDX #$040E`
          * **loROM**`$828D36`/**PRG**`$010D36`: `LDX #$0214` -> `LDX #$0215`
        * Move option:
          * **loROM**`$828EF7`/**PRG**`$010EF7`: `LDX #$0208` -> `LDX #$0207`
          * **loROM**`$828EFC`/**PRG**`$010EFC`: `LDX #$0408` -> `LDX #$040E`
          * **loROM**`$828F05`/**PRG**`$010F05`: `LDX #$0214` -> `LDX #$0215`
    * Ability Actions Window:
      * This one has it's values stored in the [Field Menus Lookup Table](/notes/lookup_tables.md#field-menus-lookup-table) at **PRG**`$01490A`
      * Shift left 1 tile:
        * **PRG**`$01490A`: `$02 $0A $08 $CF $00 $01 $02 $00` -> `$01 $0A $08 $CF $00 $01 $02 $00`
      * Values to preserve what gets overwritten by the ability actions menu
        * **loROM**`$828C01`/**PRG**`$010C01`: `LDX #$0608` -> `LDX #$0601`
        * **loROM**`$828C06`/**PRG**`$010C06`: `LDX #$0208` -> `LDX #$0214`
      * TODO: Seems like the swap option has it's own values for copying tiles, so modify that one too I guess (why did they do it this way seriously ;-_-)
  * Wardrobe preview window:
    * Window geometry and placement (shift left 7 tiles and widen to 30 tiles)
      * **loROM**`$81EE1A`/**PRG**`$00EE1A`: `LDX #$0608` -> `LDX #$0601`
      * **loROM**`$81EE1F`/**PRG**`$00EE1F`: `LDX #$0A16` -> `LDX #$0A1E`
* The data that determines what character is selected on the Naming Screen is located from **PRG**`$03788E` to **PRG**`$0379B9` and is split into two halves. The actual letters are stored as full strings for each set, in the MISC_2 Block
  * First half is Hiranaga characters (capital letters for English) from **PRG**`$03788E` to **PRG**`$037923`
  * Second half is Katakana characters (lower case for English) from **PRG**`$037924` to **PRG**`$0379B9`
  * Seems to use some sort of two byte encoding where the first byte is the letter code, e.g. `$35` for 'a' followed by `$FF` or `$FE`. Not really sure what the significance of this is?
    * Seems to be part of moving the cursor around when selecting different letters. When a `$FF` is found it jumps to a different routine that increments the counter used to select from the table
    * `$FE` only seems to be used for the spot for "End"

## Hacking Notes/Ideas/Thoughts

### TODOS

* It looks like the game hardcodes the ordering of "`<character>` got `<item>`" where in the original script it would be more like "`<character>` `<item>` got" so need to track that down at some point while working to insert the script

### Variable Width Font Algorithm

* Assumptions:
  * 8x16 (or 8x8) pixel 1bpp font data in ROM
  * All characters in font graphics are left aligned (as in, the left-most pixel(s) start at X-index 0 of the respective font tile)
  * There is a new pre-made lookup table (referred to as the "shift table") that will indicate how many pixels the ***next character*** will need to shift left, to have a 1 pixel wide space between the one just printed and it
    * For example: Lowercase 'i' will have 4 in it's table entry following the formula of `<tile width> - (<character width> + 1)` -> `8 - (3 + 1) = 4`
      * For 7 pixel wide characters, the next character will not need to be shifted at all
  * Reuse most of the existing drawing code of the alternate Half-Width routine starting at **loROM**`$818E14`/**PRG**`$008E14`
  * Two 8-bit variables are used to track bitshift values, prev_shift (**WRAM**`$01802`) and cur_shift (**WRAM**`$01803`)
    * These will always be (re-)initialized to `#$00` when a new text window is drawn, when a text window is cleared to draw more text, and when a newline character is encountered, so that the first character on every line is aligned evenly
  * cur_shift is dynamically calculated by performing `(prev_shift + cur_shift) % 8`
  * prev_shift is always loaded from the shift table

#### High level algorithm

1. Once character drawing code has started, immediately jump to the Set_Shift routine to set the bitshift variables for the current character
2. Load `prev_shift` value
3. If `prev_shift` is 0 don't update `cur_shift` because the next character to draw will be aligned evenly to the next tile, or this is the first character on the line (Skip to step 7)
4. If `prev_shift` is greater than 0, add the value currently stored in `cur_shift`
5. Modulo the result by 8 (`AND #$07`)
6. Update `cur_shift` with new value (pseudo-code: `cur_shift = (prev_shift + cur_shift) % 8`)
7. Load the hex value of the character that is being printed (already stored in **WRAM**`$018DA` by the game)
8. Subtract `$10` from character hex to get the lookup index in the shift table for that character
9. Update `prev_shift` with the value pulled from the shift table, to use with the ***NEXT*** character (pseudo-code: prev_shift = shift_table[int((ch - 0x10))])
10. Set up `jump_offset` (**WRAM**`$01B05`) for the bitshift operation later, by performing `(7 - cur_shift) + #$B312` (explanation below)
11. Load a byte of the tile data
12. Jump to the Shift_Bits subroutine. Rather than using a traditional loop, I used an unrolled loop that uses the `jump_offset` to jump to a certain line within an sequence of 7 `ASL` operations. So for example, if `(7 - cur_shift)` is 5, execution jumps to the 3rd `ASL` in the sequence, to perform 5 left arithmetic shifts. This is theoretically uses less cpu cycles which will be helpful for menus that draw all characters at once before printing to the screen rather than 1 at a time
13. After performing the bitshifts (or not if the `jump_offset` was 7), load `cur_shift` and if greater than 0, perform an `XBA` to flip the LSB and MSB (this is needed in most cases because the LSB needs to be printed first, but it's in little endian ordering)
14. Next, if the code is on a cycle that needs to update the tile data, load `new_tile` and store it in **WRAM**`$01B00`
15. Load what is in the current tile, based on the `tile_index` counter
16. Perform an exclusive OR on `current_tile` data (`EOR #$FF`) to flip the bits back to match ROM format
17. Perform an inclusive OR on `current_tile` using the new_tile to merge the two into `merged_tile`
18. Perform an exclusive OR on `merged tile` to set the correct 2bpp palette
19. Store `merged_tile` at the address of `current_tile` to replace it
20. Finish the remainder of the existing drawing routine, which will loop back to Step 11, until the entire character has been printed
21. Once character has been fully printed, jump to the subroutine to update `tile_index` (this is used by the game to track which tile on the screen to begin printing the next character)
22. If the final value of `cur_shift` is greater than 0, `tile_index` skip to step 25
23. If the final value of `cur_shift` is zero and the final value of `prev_shift` is greater than zero do not update `tile_index` (this is because the final printed character is left-aligned exactly to the current tile, so we need to start at this tile again to position the next character properly)
24. If the final value of `cur_shift` and the final value of `prev_shift` are both 0, that means we just printed two characters in a row that were exactly aligned with their tiles, so increment `tile_index` by 2 (remember that the bitshifting operations are essentially taking 8x16 tile data and converting it to 16x16!)
25. If `prev_shift + cur_shift` is greater than 8, do not increment `tile_index`, I'm struggling to explain *why* this actually works, it seems to be some sort of edge case was shifted, but stays within the bounds of a single tile, so the next character needs to be treated as if no shift had happened or something like that @_@
26. Otherwise, `tile_index` needs to be incremented by 2

#### Pseudocode:

```C
int set_shift(int *prev_shift, int *cur_shift, char* ch, int shift_table[]) {
    if (*prev_shift > 0) {
        *cur_shift = (*cur_shift + *prev_shift) % 8;
    }
    index = int(ch* - 0x10);
    prev_shift = shift_table[index];
    jump_offset = 7 - *cur_shift;

    return jump_offset;
}

unsigned char shift_bits(int jump_offset, char tile_data) {
    for (jump_offset; jump_offset > 0; jump_offset--;) {
        tile_data << 1;
    }

    return tile;
}

void update_tile_offset(int *prev_shift, int *cur_shift, int* tile_offset) {
    if (*prev_shift > 0) {
      if ((*prev_shift + *cur_shift) < 9) {
          (*tile_offset)++;
          (*tile_offset)++;
      }
    }
    else {
      if (*cur_shift == 0) {
          (*tile_offset)++;
          (*tile_offset)++;        
      }
    }

int main() {
    int prev_shift = 0;
    int cur_shift = 0;
    //TODO fill out the rest of this I don't feel like thinking anymore today
}
}
```

### Current to-do list

1. Rewrite/modify the Pascal String lookup algorithm
  a. It should use a lookup table rather than iterate through a list. Can probably reuse most of the logic otherwise
2. Insert the entire intro script
3. Test out some different ways to do the dictionary compression on the script. Probably going to need some rom expansion done, but worth doing anyways
4. Expand Hero name to 9 characters
  a. This might be possible as is! At **WRAM**`$00100` there are 9 bytes before the character level byte. Need to figure out if these are unused and if so, might be pretty easy to modify the routine that prints the hero's name

### Misc Thoughts

* Making the status boxes on the menu screen look *NICE* is going to be tricky. There are 5 sections with a full party, and each only fits 4 8x16 characters
  * Each could be widened to 5 tiles wide, but this still poses problems for characters with longer names (really just Kamekichi)
  * One possibility is to implement a 4x8 font specially for the status boxes (good looking example <https://fontstruct.com/fontstructions/show/1482769/kubikami-walshb-4x8-4x5>)
    * Mockup of this idea. Status boxes expanded by one tile and a 4x8 VWF can fit Kamekichi's name at least. Looks nice enough, but might be tricky to implement
      * ![Menu Mockup](/images/idea-no-hi-menu-mockup.png)
  * Other less flexible possibility is to hardcode names into free tiles
    * If I'm remembering correctly only Kamekichi and pets are player nameable, so this is somewhat feasible
    * Could hard code defaults with the "long" name and player choices have to be shorter (not ideal but i've seen it done)
* For a font, I think that I want to go with "Glimmer Sans" from here: <https://mattwalkden.itch.io/pixel-font-pack>
  * Feels like it captures the "vibe" of the Japanese font pretty well
  * Purchased and double checked with the author that it's kosher to use in a rom hack
  * I also kinda like Gold Box Light from that pack as well, but still leaning towards Glimmer Sans. Will make tilesets for both to test out
