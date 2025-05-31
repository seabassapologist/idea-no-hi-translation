output = ""
offset = 0x1CD2

for i in range(0, 121):
    string = str(hex(offset))[2:].upper()
    if len(string) == 3:
        string = "0" + string
    le = f"{string[2:]} {string[:2]}"
    output += le + " "
    offset += 0x010

print(output)
