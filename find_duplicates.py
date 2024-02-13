import json
import sys

with open("jp_table.json", encoding="utf8") as tb:
    table = json.load(tb)


for subtable in ["FD", "FE", "FF"]:
   dictB = {}
   for key, value in table[subtable].items():
      dictB.setdefault(value, set()).add(key)

   res = filter(lambda x: len(x) >1, dictB.values())
   print(f"{subtable}",list(res))