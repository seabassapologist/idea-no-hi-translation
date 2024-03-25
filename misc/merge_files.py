#!/usr/bin/env python3

import sys
import json

old = sys.argv[1]
updated = sys.argv[2]

with open(old, encoding="utf8") as scr:
    old_script = json.load(scr)

with open(updated, encoding="utf8") as scr:
    updated_script = json.load(scr)

for block in old_script:
    # print(old_script[block])
    for string in old_script[block]:
        if old_script[block][string]["eng"] != '':
            updated_script[block][string]["eng"] = old_script[block][string]["eng"]

with open("idea_no_hi_script_dump_fixed.json", "w", encoding='utf8') as script_file:
    json.dump(updated_script, script_file, ensure_ascii=False, indent=1)