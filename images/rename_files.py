import pathlib
import natsort
import sys

h = 0x48
d = 0
p = pathlib.Path('.')
s = natsort.natsorted(list(p.glob('*.png')))
l = 1

print(s)

for f in s:
    f.rename(f"0x{str(hex(h)).upper()[2:]}.png")
    print(f"{f.name} -> 0x{str(hex(h)).upper()[2:]}.png")
    h+=0x01

# with open(sys.argv[1]) as table:
#     for line in table:
#         line = line.strip().split(" ")
#         groffset = f"{line[1]}{line[0]}"
#         if int(f"0x{groffset}", 16):
#           #s[d].rename(f"0x{str(hex(h)).upper()[2:]}.png")
#           print(f"{l} {s[d].name} -> 0x{str(hex(h)).upper()[2:]}.png")
#           d+=1
#         h+=0x01
#         l+=1

# with open(sys.argv[1]) as table:
#     line = table.read().splitlines()
#     print(line)
#     for f in s:
#       bytes = line[d].split(" ")
#       groffset = f"{bytes[1]}{bytes[0]}"
#       if groffset == "0000":
#         d+=1
#         h+=0x1  
#       else:
#         #print(f"{groffset} {f.name}")
#         f.rename(f"0x{str(hex(h)).upper()[2:]}.png")
#         print(f"{f.name} -> 0x{str(hex(h)).upper()[2:]}.png")

#       h+=0x01

