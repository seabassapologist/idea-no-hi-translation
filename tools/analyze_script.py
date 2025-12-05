#!/usr/bin/env python3

import pandas as pd
import json
import re
from commonstrings import PyCommon_multiple_strings

EN_TABLE = {}
SCRIPT_FILE = "idea_no_hi_script_dump.json"
TABLE_FILE = "en_table.json"

def process_script_pandas(script):
    script_words = []

    for line in script:
        script_words += line.strip().split(' ')

    
    return pd.Series(script_words)


def flatten_script(script):
    flat = []
    for block in script:
        for line in script[block]:
            stripped = script[block][line]["eng"]
            # strip out control codes, extraneous punctuation, and extra spaces
            stripped = re.sub(r"(\[\w+\])|\"|\:|\*", '', stripped)
            stripped = re.sub(" +", ' ', stripped)

            flat.append(stripped)

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

    print("Flattening script JSON...")
    flat_script = flatten_script(script_file)
    # print(flat_script)

    print("Processing script...")
    words = process_script_pandas(flat_script)
    print(words.value_counts().nlargest(30))
    
    tree = PyCommon_multiple_strings()
    tree.from_strings(flat_script)

    # print(tree.filter_substrings_by_length(length_input=2))
    print(tree.filter_substrings_by_length(length_input=5, times=(200, None)))

    try:
        with open("flat_eng_script.txt", "w") as flat_out:
            for line in flat_script:
                flat_out.write(line + "\n")
    except IOError as err:
        print(f"Error writing flat script file: {err}")
        exit(1)

if __name__ == "__main__":
    main()
