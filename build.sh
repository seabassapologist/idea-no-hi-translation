#!/usr/bin/env bash

CLEAN_ROM="Idea no Hi (Japan).sfc"
PATCHED_ROM="Idea no Hi (Japan) - Patched.sfc"
ASM_FILES=("font.asm" "menus.asm" "misc.asm" "script.asm" "vwf.asm")
WINE=$(command -v wine)

if ! [ -f "$CLEAN_ROM" ]; then
    echo "'$CLEAN_ROM' not found! Make sure an unpatched ROM is in the root of the project folder!"
    exit 1
fi

# wine needs to be installed to run asar.exe
if [ -z "$WINE" ]; then
    echo "Wine binary not found. Is it installed?"
    exit 1
fi

if ! [ -f "asar.exe" ]; then
    echo "asar.exe not found! Make sure asar.exe (v1.91) is in the root of the project folder!\n\nhttps://github.com/RPGHacker/asar"
    exit 1
fi

# make a temporary backup of any existing patched ROM in case build fails
if [ -f "$PATCHED_ROM" ]; then
    cp "$PATCHED_ROM" "$PATCHED_ROM.backup"
fi

cp "$CLEAN_ROM" "$PATCHED_ROM"

for file in "${ASM_FILES[@]}"; do
    FILE_NAME=$(echo "$file" | cut -d "." -f1)
    echo "Patching ${FILE_NAME^^}..."

    $WINE ./asar.exe -v -werror code/$file "$PATCHED_ROM"

    if [ $? -ne 0 ]; then
        if [ -f "$PATCHED_ROM" ]; then
            cp "$PATCHED_ROM.backup" "$PATCHED_ROM"
        fi
        exit 1
    fi

    echo ""
done