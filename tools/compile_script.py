#!/usr/bin/env python3

# convert english strings the script file into raw hex data for insertion into ROM

import json
import re

# constants
TABLE_FILE = "en_table.json"
SCRIPT_FILE = "idea_no_hi_script_dump.json"
EN_TABLE = {}

def match_control_code(matchobj):
    if matchobj.group(0) in EN_TABLE["control_codes"]:
        return EN_TABLE[matchobj.group(0)]
    else:
        return "XX" # should never happen 

def to_bytearray(eng_str, table):
    if eng_str:
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
                # print(tr_token)
                byte_str += tr_token
    else:
        # "[Full]Placeholder[End]" for untranslated lines
        byte_str = "022A403537393C434038394600"
    print(byte_str)
    if byte_str[-2:] != "00":
        print(byte_str[-2:])
        print(f"Missing String Terminator in string: '{eng_str}'!")
        exit(1)
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
    
    with open("../data/eng_block1.bin", "bw") as block1_bin:
        for line in script_file["BLOCK_1"]:
            block1_bin.write(to_bytearray(script_file["BLOCK_1"][line]["eng"], trans_table))

    with open("../data/eng_block2.bin", "bw") as block2_bin:
        for line in script_file["BLOCK_2"]:
            block2_bin.write(to_bytearray(script_file["BLOCK_2"][line]["eng"], trans_table))

    with open("../data/eng_block3.bin", "bw") as block3_bin:
        for line in script_file["BLOCK_3"]:
            block3_bin.write(to_bytearray(script_file["BLOCK_3"][line]["eng"], trans_table))

    with open("../data/eng_misc2.bin", "bw") as misc2_bin:
        for line in script_file["MISC_2"]:
            misc2_bin.write(to_bytearray(script_file["MISC_2"][line]["eng"], trans_table))    

if __name__ == "__main__":
    main()
