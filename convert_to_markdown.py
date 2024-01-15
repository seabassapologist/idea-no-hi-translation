#!/usr/bin/env python

import sys

print("| Index | Kanji Offset | Graphics Offset | Address   | Image |")
print("|-------|--------------|-----------------|-----------|-------|")

exclude = [0x24, 0x25, 0x29, 0x2A, 0x2B, 0x2C, 0x2F, 0x31, 0x32, 0x34, 0xED, 0xEE, 0xEF, 0xF3, 0xF4, 0xF8, 0xF9, 0xFA, 0xFB, 0xFC]

with open(sys.argv[1]) as table:
    index = 0x00
    for line in table:
        line = line.strip().split(" ")
        groffset = f"{line[1]}{line[0]}"
        tboffset = f"{(index*2) + 0x0BA6:04x}"
        if int(f"0x{groffset}", 16):
            addr = str(hex(int(groffset, 16) + 0x58000)).upper()
            print(f"| `${str(hex(index)).upper()[2:]}` | `${str(tboffset).upper()}`      | `${line[1]}{line[0]}`         | `$0{addr[2:]}` | ![](images/kanji_ff/0x{str(hex(index))[2:].upper()}.png)")
        else:
            print(f"| `${str(hex(index)).upper()[2:]}` | `${line[1]}{line[0]}`      | `${line[1]}{line[0]}`         | `N/A`     | ![](images/half_width/blank.png)")
        index+=0x01