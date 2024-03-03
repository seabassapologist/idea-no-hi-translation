output = ""
offset = 0x0FA6

for i in range(0, 81):
    string = str(hex(offset))[2:].upper()
    if len(string) == 3:
        string = "0" + string
    le = f"{string[2:]} {string[:2]}"
    output += le + " "
    offset += 0x08

print(output)