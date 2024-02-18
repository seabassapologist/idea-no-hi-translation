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
    out=""
    for byte in rom:
        # convert the byte to a zero padded string
        char = byte_to_string(byte)

        if char in ["FE", "FD", "FF", "04"]:
            # this is a Kanji, Pascal String, or highlight code so grab the next byte and convert that to a string
            nextchar = byte_to_string(next(rom))
            out += table[char][nextchar]
        else:    
            out += table[char]
        offset += 0x1

    print(out)
    print(str(hex(offset)))

def main():
    try:
        with open(ROM_FILE, 'rb') as rom_file:
            rom_file.seek(STARTING_OFFSET)
            # make this into an iterator so that we can manually iterate when needed
            rom_data = iter(rom_file.read(16))
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

    dump_script(rom_data, table_file, STARTING_OFFSET)

if __name__ == "__main__":
    main()