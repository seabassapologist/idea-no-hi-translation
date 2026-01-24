#!/usr/bin/env python3

# compile a lookup table and string data for pascal strings

import json
import struct

STRINGS_FILE="pascal_strings.json"

def build_data(p_strings):
    byte_str = ""
    for p in p_strings.values():
        byte_str += f"{p['length']} {p['string']} "

    return bytearray.fromhex(byte_str.strip())

def build_table(p_strings):
    table = b'\x00\x00'
    offset = 0

    for p_str in p_strings.values():
        offset += int(p_str["length"]) + 1
        table += struct.pack("<h", offset)       # '<h' = 16-bit little-endian

    return table

def main():
    try:
        with open(STRINGS_FILE, "r", encoding="utf8") as strings:
            pascal_strings = json.load(strings)
    except IOError as err:
        print(f"Can't open Table file '{STRINGS_FILE}': {err}")
        exit(1)

    try:
        with open("../data/pascal_string_data.bin", "bw") as pstrings_bin:
            pstrings_bin.write(build_data(pascal_strings))
    except IOError as err:
        print(f"Failed to write pascal string data': {err}")
        exit(1)

    try:
        with open("../data/pascal_string_table.bin", "bw") as pstrings_bin:
            pstrings_bin.write(build_table(pascal_strings))
    except IOError as err:
        print(f"Failed to write pascal string table': {err}")
        exit(1)


if __name__ == "__main__":
    main()
