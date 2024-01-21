import json
import sys

input = sys.argv[1].split() 
with open("jp_table.json", encoding="utf8") as tb:
    table = json.load(tb)

out = ""
for char in input:
    out += table[char]

print(out)
