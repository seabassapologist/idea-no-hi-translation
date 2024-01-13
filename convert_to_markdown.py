#!/usr/bin/env python

import sys

print("| Index | Offset | Address   | Image |")
print("|-------|--------|-----------|-------|")

exclude = [0x24, 0x25, 0x29, 0x2A, 0x2B, 0x2C, 0x2F, 0x31, 0x32, 0x34, 0xED, 0xEE, 0xEF, 0xF3, 0xF4, 0xF8, 0xF9, 0xFA, 0xFB, 0xFC]

with open(sys.argv[1]) as table:
    index = 0x11
    for line in table:
        line = line.strip().split(" ")
        offset = f"{line[1]}{line[0]}"
        if index not in exclude:
            addr = str(hex(int(offset, 16) + 0x58000)).upper()
            print(f"| `${str(hex(index)).upper()[2:]}` | `${line[1]}{line[0]}`| `$0{addr[2:]}` | ![](images/full_width_regular/0x{str(hex(index))[2:].upper()}.png)")
        else:
            print(f"| `${str(hex(index)).upper()[2:]}` | `${line[1]}{line[0]}`| `N/A` | ![](images/full_width_regular/blank.png)")
        index+=0x01