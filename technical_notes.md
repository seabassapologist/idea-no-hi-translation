# General Housekeeping

Address prefixes, for sake of reader sanity:
* **loROM** - 24-bit memory mapped address
* **PRG** - Linear ROM address
* **WRAM** - Work RAM
* **REL** - Relative address
* **VRAM** - Video RAM

(Warning/Apology: these notes are very scattered currently. Once I work out the entire text printing process and encoding, I'll try to organize them)

# Disassembly Notes
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
    * Vehek on RHDN mapped out some of the dialogue chunks here: https://datacrystal.romhacking.net/wiki/Idea_no_Hi:ROM_map
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

# Text Encoding Notes
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
            * `$00` seems to indicate the end of the table, so this means nothing was found in the table?
        8. Otherwise compare it to **WRAM**`$018DA` (the byte that was immediately after `$FD` in this example), and if it's equal to that byte, jump execution to **loROM**`$81874A`
        9. If less than the stored byte, increment *X* three times, then jump back to Step 6, and repeat. This is the routine to check if the byte is an [FD pascal string](/lookup_tables.md#pascal-string-table-part-3)
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
* `$0F` - This is specifically checked for (at **loROM**`$818703`) and is a pascal string that ends the current dialogue chunk and starts a new one with an asterisk in place of the character name. See [Pascal String Table Part 1](/lookup_tables.md#pascal-string-table-part-1)
        * First occurrence within a dialogue blob appears to be at **PRG**`$060640` (**loROM**`$8C8640`)
* Text characters are stored in a 1bpp format in ROM, but are converted to 2bpp before being DMA'd to VRAM
    * Bitplane 1 seems to always be rows of `$FF` bytes and Bitplane 2 follows the actual character pixels. Example of an 8x8 character stored at **VRAM**`$00E0`: <img src="images/2bpp_to_1bpp.png" style="max-width: 40%;" />
* When a printable character byte is found, this is how the code figures out where the corresponding graphics data is stored in ROM ([also detailed in the Graphics Lookup tables](/lookup_tables.md#graphics-lookup-tables))
    1. First, the table stored at **PRG**`$117DD0`/**loROM**`$A2FDD0` (see [lookup_tables.md](lookup_tables.md#lookup-tables)) and scanned to see if the byte represents a [Pascal string](/lookup_tables.md#pascal-string-table-part-2))
    2. Offset value `#$03C6` is loaded and stored at **WRAM**`$01901`. This was determined by the fact that the text chunk started with `$03` (see section above about the font control bytes)
    3. The text byte is then loaded, subtracted by `#$0010`, doubled (by using an ASL command), and then the result is added with the previous Offset value, to obtain a new Offset value which is stored at **WRAM**`$01901`
        * In the case of `$D3` (「), this new Offset points to the start of the tile data for that character
* The routine that takes the 1bpp data for half-width characters from ROM and converts it to 2bpp in RAM starts at **loROM**`$818EFE`
    * Full-width is at **loROM**`$818CD9`. It's pretty similar, but I believe there's also logic to squish the characters closer together, because they do not perfectly align to 16x16 tiles (almost like a VWF routine)
    * It's fairly straightforward and "should" (famous last words) be simple enough to modify to handle 8x16 data straight from ROM
    * Unmodified, the routine will always pad the first two and last two rows of the bitmap (in other words, four `$FF` bytes before and after), which is how the ROM data gets converted to 8x16 or 16x16
    * Because of how the palette is set for text, bitplane 1 will ALWAYS be rows of `$FF` (regardless of which font style we're looking at)
    * The tl;dr of how this routine works is that through comparing and flipping values stored in some "variables", it will read through the tile data one byte at a time, but will alternating between first writing `$FF` to **WRAM** and then the current byte of tile data, and so on until 12/24 bytes are read depending on the font used
    * So let's step through it with the half-width version of character `$35` (あ). The number of bytes it needs to read through is stored at **WRAM**`$0190A` which in this case will start at `#$0C` (because half-width tiles are 12 bytes in length). Additionally, **WRAM**`$0190C` and **WRAM**`$0190B` are at some point initialized to both store `#$02`
        1. Before this routine starts, there's some setup to obtain the correct Offset that points to the region of **WRAM** where tile data is staged (WRAM Offset going forward) 
            1. A value set at **WRAM**`$00005` (`#$13` in this case), is `XBA`'d to become `#$1300`, divided by 2 twice, and the resulting value `#$04C6` is stored at **WRAM**`$01873`, which later doubled three times to become `#$2630`
                * Haven't quite tracked down where and when this initial value this is set, but it's not super important to understanding how this routine works
            2. This number is important because it corresponds with the first segment of **WRAM** where the character tiles are copied to, before being DMA'd to **VRAM**
            3. Lastly, `#$04` is added to this value, and I believe this is for padding the first two rows with `$FF` bytes
                * Important to note that this region of **WRAM** is pre-filled with `$FF` bytes already (my guess is because of the dialogue box being drawn on screen already)
        2. Once execution reaches **loROM**`$818EFE`, the [Graphics Offset](/lookup_tables.md#half-width-text-table) for `$35` is loaded from **WRAM**`$01901` (it was previously stored there after that byte was loaded from the script), and is used to load the first byte of the tile data into **WRAM**`$1905`
        3. **WRAM**`$0190C` is set to `#$01`
        4. The value of **WRAM**`$0190B` (currently `#$02`) is check if it's equal to **WRAM**`$0190C` (currently `#$01`) and since it's not, `$FF` is written to **WRAM**
        5. Next, **WRAM**`$0190C` is checked if it's value is `#$01`, and if it is, it's value is flipped back to `#$02`, 
        6. WRAM Offset is incremented by 1
        7. **WRAM**`$0190C` and **WRAM**`$0190B` values are compared again, but since they are equal, the tile byte is loaded back in from memory
        8. The tile byte is then `EOR`'d against `#$FF` (aka every bit is flipped) and written to **WRAM**
            * This is done so that the palette index for the "background" is always 3, and the actual character pixels are always index 1
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

# Hacking Notes/Ideas/Thoughts

* Making the status boxes on the menu screen look *NICE* is going to be tricky. There are 5 sections with a full party, and each only fits 4 8x16 characters
    * Each could be widened to 5 tiles wide, but this still poses problems for characters with longer names (really just Kamekichi)
    * One possibility is to implement a 4x8 font specially for the status boxes (good looking example https://fontstruct.com/fontstructions/show/1482769/kubikami-walshb-4x8-4x5)
        * Mockup of this idea. Status boxes expanded by one tile and a 4x8 VWF can fit Kamekichi's name at least. Looks nice enough, but might be tricky to implement
            * ![](/images/idea-no-hi-menu-mockup.png)
    * Other less flexible possibility is to hardcode names into free tiles
        * If I'm remembering correctly only Kamekichi and pets are player nameable, so this is somewhat feasible
        * Could hard code defaults with the "long" name and player choices have to be shorter (not ideal but i've seen it done)
* Because of how the full sized data is stored in ROM, the routine to take the 16x12 data and mangle it into a 16x16 chunks is kinda convoluted
    * Current plan is to just bypass that routine all together and reuse the routine that can handle the 8x16 characters
        * Will probably want to eventually modify or rewrite it for VFW but that's way down the line
    * There'll be a lot of extra space to use without the kanji characters, so I could just insert a 2bpp format font directly (this is probably the sane thing to do, but we'll see...)
* For a font, I think that I want to go with "Glimmer Sans" from here: https://mattwalkden.itch.io/pixel-font-pack
    * Feels like it captures the "vibe" of the Japanese font pretty well
    * Purchased and double checked with the author that it's kosher to use in a rom hack
    * I also kinda like Gold Box Light from that pack as well, but still leaning towards Glimmer Sans. Will make tilesets for both to test out