import json
import sys

input = sys.argv[1].split() 
with open("jp_table.json", encoding="utf8") as tb:
    table = json.load(tb)

out = ""
interin = iter(input)
for char in interin:
    if char in ["FE", "FD", "FF"]:
        nextch = next(interin)
        print(type(nextch))
        if nextch in table[char]:
            out += table[char][nextch]
        else:
            out += f"<{char} {nextch}>"
    else:    
        out += table[char]

print(out)
