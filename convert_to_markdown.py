#!/usr/bin/env python

import sys

with open(sys.argv[1]) as table:
    for line in table:
        line = line.strip().split(" ")
        print(f"| `${line[0]}` | `${line[2]}{line[1]}`|")