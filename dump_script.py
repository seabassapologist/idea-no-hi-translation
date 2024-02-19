#!/usr/bin/env python3

import json
import hashlib
import sys

ROM_FILE = "Idea no Hi (Japan).sfc"
TABLE_FILE = "jp_table.json"
SCRIPT_FILE = "idea_no_hi_script_dump.json"
STARTING_OFFSET = 0x60000

def byte_to_string(byte):
    return f"{str(hex(byte))[2:].upper():0>2}"

def dump_script(rom, table, offset):
    # set up the first block which will always be 0x60000
    block = str(hex(offset))
    script={block: ""}
    for byte in rom:
        # convert the byte to a zero padded string
        char = byte_to_string(byte)

        if char in ["FE", "FD", "FF", "04"]:
            # this is a Kanji, Pascal String, or highlight code so grab the next byte and convert that to a string
            nextchar = byte_to_string(next(rom))
            script[block] += table[char][nextchar]
            offset += 0x1
        else:    
            script[block] += table[char]

        offset += 0x1

        # 0x00 is the string terminator so update the block and create a new blank string to start adding to
        if char == "00":
            block = str(hex(offset))
            script[block] = ""
    
    return script

def main():
    try:
        with open(ROM_FILE, 'rb') as rom_file:
            rom_file.seek(STARTING_OFFSET)
            # make this into an iterator so that we can manually iterate when needed
            rom_data = iter(rom_file.read(1024))
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

    script = dump_script(rom_data, table_file, STARTING_OFFSET)

    with open(SCRIPT_FILE, "w", encoding='utf8') as script_file:
        json.dump(script, script_file, ensure_ascii=False, indent=1)

if __name__ == "__main__":
    main()