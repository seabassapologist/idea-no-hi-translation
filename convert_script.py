#!/usr/bin/env python3

# convert english strings the script file into raw hex data for insertion into ROM

import json
import re

# constants
TABLE_FILE = "en_table.json"
SCRIPT_FILE = "idea_no_hi_script_dump.json"
EN_TABLE = {}

TEST_STRING = "[Full]Doctor \"Come now! Today's[Line] the day where you will[Line] show us your powers![Line] Do it now!\"[End]"

def match_control_code(matchobj):
    if matchobj.group(0) in EN_TABLE.keys():
        return EN_TABLE[matchobj.group(0)]
    else:
        return "XX" # should never happen 

def to_bytearray(eng_str):
    new = re.sub(r"(\[\w+\])", match_control_code, eng_str)
    print(new)
    

def main():
    global EN_TABLE

    try:
        with open(TABLE_FILE, "r", encoding="utf8") as tab:
            EN_TABLE = json.load(tab)
    except IOError as err:
        print(f"Can't open Table file '{TABLE_FILE}': {err}")
        exit(1)

    try:
        with open(TABLE_FILE, "r", encoding="utf8") as script:
            script_file = json.load(script)
    except IOError as err:
        print(f"Can't open Script file '{SCRIPT_FILE}': {err}")
        exit(1)

    to_bytearray(TEST_STRING)

if __name__ == "__main__":
    main()
