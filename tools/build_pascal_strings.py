#!/usr/bin/env python3

# compile a lookup table and string data for pascal strings

import json

STRINGS_FILE="pascal_strings.json"

def build_data(p_strings):
    byte_str = ""
    for p in p_strings.values():
        byte_str += f"{p['length']} {p['string']} "

    return bytearray.fromhex(byte_str.strip())

def build_table(p_strings):
    byte_str = ""
    byte_count = 0x0

def main():
    try:
        with open(STRINGS_FILE, "r", encoding="utf8") as strings:
            pascal_strings = json.load(strings)
    except IOError as err:
        print(f"Can't open Table file '{STRINGS_FILE}': {err}")
        exit(1)

    pascal_data = build_data(pascal_strings)
    print(pascal_data)

if __name__ == "__main__":
    main()
