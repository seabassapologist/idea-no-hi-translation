#!/usr/bin/env python3

# convert english strings the script file into raw hex data for insertion into ROM

import json
import re

# constants
TABLE_FILE = "en_table.json"
SCRIPT_FILE = "idea_no_hi_script_dump.json"
EN_TABLE = {}

TEST_STRING_1 = "[Full]Doctor \"Come now! Today's[Line] the day where you will[Line] show us your powers![Line] Do it now!\"[End]"
TEST_STRING_2 = "[Full][Line][Hero]\"Ugagaaaa...!\"[Line][End]"
TEST_STRING_3 = "[Full]Doctor \"Do you understand![Line] If you don't want to[Line] suffer like this,[Line] then do it already.[Line][Line] Blow the mannequin[Line] before you into pieces![Line] Hurry up and use your[Line] powers!\"[End]"
TEST_STRING_4 = "[Full][Line][Hero] \"[Slow]...[Normal]\"[Line][End]"

def match_control_code(matchobj):
    if matchobj.group(0) in EN_TABLE["control_codes"]:
        return EN_TABLE[matchobj.group(0)]
    else:
        return "XX" # should never happen 

def to_bytearray(eng_str, table):
    byte_str = ""
    tokens = re.split(r"(\[\w+\])", eng_str)[1:-1]
    print(tokens)
    for token in tokens:
        # byte_str += re.sub(r"(\[\w+\])", match_control_code, token)
        if token in EN_TABLE["control_codes"]:
            byte_str +=  EN_TABLE["control_codes"][token]
        else:
            # key_words = re.split(r"(\w+)", token)[1:-1]
            tr_token = token.translate(table)
            print(tr_token)
            byte_str += tr_token
    return bytearray.fromhex(byte_str)
    

def main():
    global EN_TABLE

    try:
        with open(TABLE_FILE, "r", encoding="utf8") as tab:
            EN_TABLE = json.load(tab)
    except IOError as err:
        print(f"Can't open Table file '{TABLE_FILE}': {err}")
        exit(1)

    try:
        with open(SCRIPT_FILE, "r", encoding="utf8") as script:
            script_file = json.load(script)
    except IOError as err:
        print(f"Can't open Script file '{SCRIPT_FILE}': {err}")
        exit(1)

    trans_table = str.maketrans(EN_TABLE["characters"])
    with open("test_strings.bin", "bw") as bin_file:
        bin_file.write(to_bytearray(TEST_STRING_1, trans_table))
        bin_file.write(to_bytearray(TEST_STRING_2, trans_table))
        bin_file.write(to_bytearray(TEST_STRING_3, trans_table))
        bin_file.write(to_bytearray(TEST_STRING_4, trans_table))

if __name__ == "__main__":
    main()
