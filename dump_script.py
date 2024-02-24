#!/usr/bin/env python3

import json
import hashlib
import sys

# constants
ROM_FILE = "Idea no Hi (Japan).sfc"
TABLE_FILE = "jp_table.json"
SCRIPT_FILE = "idea_no_hi_script_dump.json"

BLOCKS = [
    {
        "name": "BLOCK_1",
        "start": 0x60000,
        "end": 0x067F9C
    },
    {
        "name": "BLOCK_2",
        "start": 0x68000,
        "end": 0x6FFDF
    },
    {
        "name": "BLOCK_3",
        "start": 0x70000,
        "end": 0x77F11
    },
    {
        "name": "SKILL_NAMES",
        "start": 0x7A02D,
        "end": 0x7A29F
    },
    {
        "name": "ITEM_NAMES",
        "start": 0x7A2A6,
        "end": 0x7B45E
    },
    {
        "name": "MISC_1",
        "start": 0x7B47B,
        "end": 0x7B48F
    },
    {
        "name": "ENEMY_NAMES",
        "start": 0x7B48F,
        "end": 0x7BA93
    },
    {
        "name": "MISC_2",
        "start": 0x7BAA7,
        "end": 0x7CE46
    },
    {
        "name": "SKILL_DESCRIPTIONS",
        "start": 0x7CE84,
        "end": 0x07D5B4
    },
    {
        "name": "ITEM_DESCRIPTIONS_1",
        "start": 0x7D5B5,
        "end": 0x7FF91
    },
    {
        "name": "BATTLE_MESSAGES_1",
        "start": 0xBF524,
        "end": 0xBFF93
    },
    {
        "name": "ITEM_DESCRIPTIONS_2",
        "start": 0x11F239,
        "end": 0x11FE06
    },
    {
        "name": "BLOCK_4",
        "start": 0x128000,
        "end": 0x12B697
    },
    {
        "name": "BATTLE_MESSAGES_2",
        "start": 0x143F75,
        "end": 0x144D80
    }
]

def byte_to_string(byte):
    return f"{str(hex(byte))[2:].upper():0>2}"

def dump_script(rom, table, offset, end):
    block = f"0x{str(hex(offset))[2:].upper()}"
    script={block: ""}
    rom.seek(offset)
    #length = end - offset
    rom_data = iter(rom.read(end - offset)) # make this into an iterator so that we can manually iterate when needed
    for byte in rom_data:
        # convert the byte to a zero padded string
        char = byte_to_string(byte)

        if char == "0F":
            script[block] += "」[End]"
            offset += 0x1
            block = f"0x{str(hex(offset))[2:].upper()}"
            script[block] = "[Full]＊「"

        else:
            if char in ["FE", "FD", "FF", "04"]:
                # this is a Kanji, Pascal String, or highlight code so grab the next byte and convert that to a string
                nextchar = byte_to_string(next(rom_data))
                try:
                    script[block] += table[char][nextchar]
                except KeyError as err:
                    print(char)
                offset += 0x1
            else:    
                script[block] += table[char]

            offset += 0x1

            # 0x00 is the string terminator so update the block and create a new blank string to start adding to
            if char == "00" and offset != end:
                    block = f"0x{str(hex(offset))[2:].upper()}"
                    script[block] = ""

    return script

def main():
    try:
        rom_file = open(ROM_FILE, 'rb')
    except IOError as err:
        print(f"Can't open ROM file '{ROM_FILE}': {err}")
        exit(1)

    # TODO: add an MD5 sum check to make sure this is the No-Intro dump

    try:
        with open(TABLE_FILE, encoding="utf8") as tab:
            table_file = json.load(tab)
    except IOError as err:
        print(f"Can't open Table file '{TABLE_FILE}': {err}")
        exit(1)

    script = {}

    for block in BLOCKS:
        script[block["name"]] = dump_script(rom_file, table_file, block["start"], block["end"])

    with open(SCRIPT_FILE, "w", encoding='utf8') as script_file:
        json.dump(script, script_file, ensure_ascii=False, indent=1)

    try:
        rom_file.close()
    except IOError as err:
        print(f"Couldn't close ROM file '{ROM_FILE}': {err}")
        exit(1)

if __name__ == "__main__":
    main()