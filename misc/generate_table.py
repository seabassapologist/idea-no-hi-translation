output = ""
offset = 0x12C2

for i in range(0, 80):
    string = str(hex(offset))[2:].upper()
    le = f"{string[2:]} {string[:2]}"
    output += le + " "
    offset += 0x10

print(output)