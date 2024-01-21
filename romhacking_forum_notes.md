Vehek May 28, 2019, 04:06:57 PM:
I have some notes from several years ago. I'm double-checking some of these details as I get them ready. All referenced offets are linear addresses, not the lorom the game uses.

The dialog text is one blob (at 0x60000), with no pointers, instead it counts end tokens. There are two different end token, which affect both the current string and the following one. The first, 00, is a typical string ender. The other, 0F, inserts a closing 」mark and an opening「 mark with asterisk into the next string.
FD XX, FE XX, and FF XX are mostly kanji, but FD XX also contains dictionary strings (Pascal strings)
My notes say there are graphic pointers for each individual text character. Important, since past a certain point, the raw order in the font graphics doesn't match the internal order.

Quote
58000 - Offsets into the font graphics for each font character?
*583C6 - Start of regular text
*589A6, 58BA6, 58DA6 - Start of kanji tables
**Of note: FD-kanji are the last in the graphics
***Starting with FD48, the kanji graphics are no longer in alignment with the previous ones.
**Not all Roman alphabet letters are used. A few have blank offsets, as their slots are used for control codes.
59CCE - Font

Quote
Pascal strings
117DF8
Format: Dict.String #, offset of dictionary string relative to 117DCA.

--------------------

Psyklax May 28, 2019, 04:47:44 PM:
The graphics for the text are 2 BPP and the first kanji is stored at $5DC86. The game, for some reason, takes the values stored there, then does an EOR #$FF before putting it in RAM for a DMA transfer to VRAM. No idea why they need to do the EOR instead of just putting the actual value, but whatever.

The table reference to $5DC86 is at $58F2A. Ultimately, the reference to this address comes from $117F6B, where the C2 there is doubled then added to a value stored at $585A4, but that's not important right now. What IS important is that the C2 refers to that particular kanji, and another look tells me how the text system works.

Before C2 is FF, and FF tells the game to use kanji bank 3, if you like (the game checks for FD, FE and FF). If the address is under FD, it signals the primary bank, where the kana etc is.

It's at this point that I realise this is just for the character name: in this case, 博士 [hakase] or 'doctor'. Before the name, there's a byte saying how many bytes to read - in this case, 04, because it's FF C2 FD 67 (two kanji). The actual text is another matter.

Making a table file for the basic kana is trivial at this point, and a quick search for the first two characters bring me to $60000. Yep, that's where the text is stored. A little fiddling tells me exactly what's going on. It starts with 03 FD E8, which tells the game that this is the aforementioned doctor speaking. If I change it to E7, the name changes to Charles. I haven't delved into the meaning of 03 FD, but if you change FD to FE, you get a different kanji, so who knows for now.

--------------------

Psyklax May 29, 2019, 03:19:55 AM:
I should have pointed out that the first order of business is getting an English font in there, because the only font currently there is an incomplete capital alphabet. This is complicated by the fact that it goes through the EOR process I mentioned, but I think I'll have a go at converting the existing font so that I could convert a new one in there. Of course it'll be up to you which exact font to use. I'll come back later with my results.

EDIT: okay, I had a go. Fortunately there's an online bitwise calculator which lets me do mass EOR conversion. So the way the font is stored in the ROM, it uses six of the eight rows in an 8x8 tile. The six lines for the top tile are followed by the six lines for the bottom tile, and then the next character, and so on. If I add FF FF to the six bytes for a tile, it displays correctly in Tile Molester. Next step is to do the process in reverse to insert an English alphabet. Of course, the system used in the game could be modified to use a dictionary compression system. As it stands it's pretty limited, but there you go. I'll try inserting a font and report back.

-------------------- 

Psyklax May 29, 2019, 01:25:53 PM:
That was my assumption when I read the first post, hence my initial response. I'm still gonna have a little go with the font and such, for experience, but I'm certainly not going to translate it, or do any of the real work. I've got too much else to do. :)

EDIT: well I'm just puttin' this out there. I've decompressed the FE and FF kanji and put them in a binary file. If anyone wants to identify all 512 kanji and make a table file, be my guest. :D But don't worry, there's still the FD kanji to do, but they're a little bit off so I'll need to do a tad more work on them.
To view correctly, open in Tile Molester, make sure you're in 1bpp planar and change block size to 2x2. This is how it's arranged in the ROM, after EORing with FF, reordering the bytes into a more sensible order, then adding some FFs for padding because they're actually 12x12 and the game sticks them together.
http://s346165667.websitehome.co.uk/psyktrans/ideanohi-kanjifeff.bin

--------------------

Vehek May 29, 2019, 11:24:25 PM:
The simpler way of viewing the font would be to use a tile viewer that allows custom heights. For example, use CrystalTile2 with width 16, height 12, and solid 1bpp. Font graphics stored this way are fairly common.
However, graphic viewers don't work perfectly with this game because the "pointers for each font character" thing can create mismatches between the character index and the raw graphics viewed directly from the ROM.
What would seem in a raw dump to be the last 10 kanji of the FE block are actually the last 10 of the FD block (FD C3 through FD CC). I'll write down what replaces the 10 last FE kanji slots, since it's just the alphabet letters that got removed from the one-byte range: J K O P Q R U W X Z. This seems to be the only major discrepancy, all other kanji are in order. Just ignore that duplicate kanji at the point FD kanji get misaligned. (Go to 0x5E92C if you want to see that section properly.) 

00FC80-00FD38: String block selection routines
00FD39-00FD76: String finding routines
060000-067F9B: Dialogue block 1 (strings #1-558)
068000-06FFDF: Dialogue block 2 (strings #559-986)
070000-077F10: Dialogue block 3 (strings #987-1580)
07A02D-07A29F: Skill names
07A2A6-07B45E: Item names
07B48F-07BA93: Enemy names
07BAA7-07CE46: Menus and other text
07CE84-07D5B4: Skill descriptions
07D5B5-07FF91?: Item descriptions
07F524-???: Unknown text block
0BF524-0BFF93: Battle messages
117DCA-117DF7: XX Pascal string entry pointers/Base address for Pascal strings
117DF8-117E91: FD XX dictionary(Pascal) strings pointer entries
11F239-11FE06?: Unidentified text
128000-12B697: Dialogue block 4 (strings #1581-1873)