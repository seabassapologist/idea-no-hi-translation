#!/usr/bin/env python3

import pandas as pd
import json

EN_TABLE = {}
SCRIPT_FILE = "idea_no_hi_script_dump.json"
TABLE_FILE = "en_table.json"

def analyze_script(script):
    script_words = pd.Series([])
    
    return script_words

def flatten_script(script):
    flat = []
    for block in script:
        for line in script[block]:
            flat.append(script[block][line]["eng"])
            print(script[block][line]["eng"])
    return flat

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

    flat_script = flatten_script(script_file)
    print(flat_script)

    # words = analyze_script(script_file)

if __name__ == "__main__":
    main()
