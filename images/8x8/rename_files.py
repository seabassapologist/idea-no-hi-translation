import pathlib
import natsort
import sys
import os

exclude = [0x24, 0x25, 0x29, 0x2A, 0x2B, 0x2C, 0x2F, 0x31, 0x32, 0x34, 0xED, 0xEE, 0xEF, 0xF3, 0xF4, 0xF8, 0xF9, 0xFA, 0xFB, 0xFC]

h = 0x11
d = 0
p = pathlib.Path('.')
s = natsort.natsorted(list(p.glob('*.png')))
# print(s)
# for d in range(0,98):
#     if h not in exclude:
#         #s[d].rename(f"0x{str(hex(h)).upper()[2:]}.png")
#         print(f"{s[d].name} -> 0x{str(hex(h)).upper()[2:]}.png")
#     h += 0x01 

with open(sys.argv[1]) as table:
    for line in table:
        line = line.strip().split(" ")
        groffset = f"{line[1]}{line[0]}"
        if int(f"0x{groffset}", 16):
          s[d].rename(f"0x{str(hex(h)).upper()[2:]}.png")
          #print(f"{s[d].name} -> 0x{str(hex(h)).upper()[2:]}.png")
          d+=1
        h+=0x01
