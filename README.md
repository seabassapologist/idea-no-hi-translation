# idea-no-hi-translation

Tools and notes from my attempt at translating Idea no Hi for the Super Famicom

This repo is intended to reflect the current state of the project, so assume that whatever is here is everything that's been done so far

**Current State:**

* Testing out script inserting methods and writing code to facilitate that

![First String](/images/first_string.png)
![English Character Set](/images/VWF_demo.gif)

| Task | Status |
|------|--------|
| **Disassembly** | Ongoing |
| **Documentation** | Ongoing |
| **Table File** | Done |
| **Script Dump** | Done |
| **Translation** | All text translated, pending any edits |
| **Font Insertion** | Done |
| **Variable Width Font** | Done |
| **Script Insertion** | In Progress |
| **Hacking** | In Progress |

## Credits

**Translation:** _Goburinbro_

**Hacking/ASM/Documentation:** _seabassapologist_

**Icons/Mockups/Title Screen Research:** _vervalkon_

**Special Thanks:**

* _Vehek_, for leaving notes on text addresses, font addresses, and preliminary research into the text drawing code
* _Neo Wonder_, early drafts of the translation

**English Font:** "Glimmer Sans" by _MattWalkden_ - [https://mattwalkden.itch.io/pixel-font-pack](https://mattwalkden.itch.io/pixel-font-pack)

## Instructions

Currently there's no binary patch (IPS/BPS) yet because it's too soon. The instructions below explain how to patch the ROM manually with what's currently been implemented

Note: These instructions are for Windows since Asar is only built for Windows, but it should be work on macOS/Linux, with Wine

Dependencies:

* Python 3.6 or above
* Git
* Powershell
* Asar (v1.91 at the time of writing) - <https://github.com/RPGHacker/asar>
* No-Intro ROM for Idea no Hi [(see below)](#misc-notes)

In a terminal:

Clone the repository to your machine

```shell
git clone https://github.com/seabassapologist/idea-no-hi-translation
```

Enter the repository directory

```shell
cd idea-no-hi-translation
```

### Compile the English Script

_**Shouldn't need to run this unless changes have been made to the script file. The repository will otherwise always have the most recently compiled script files**_

Run the script compiler

```shell
python compile_script.py
```

Currently this will just output a single binary file called `test_strings.bin`, but in the future there will be one .bin file per text block

### ASM Patching

Make a copy of the ROM file and name it exactly `Idea no Hi (Japan) - Clean.sfc`

Run the ASM patching script

```shell
.\clean_patch.ps1
```

This will apply all ASM patches to the ROM and save it as `Idea no Hi (Japan).sfc`

Happy testing!

### Dump Script

_**This should never be necessary since the script file with translated strings is always provided in the repository. Just leaving here for completeness**_

Place the ROM file inside the repository directory and make sure the filename is exactly `Idea no Hi (Japan).sfc`

Now run the dumper script

```shell
python script_dump.py
```

The script will then create the file `idea_no_hi_script_dump.json`, or if this file already exists it will overwrite it with a fresh copy

## Misc Notes

All work is being done using the No-Intro ROM dump:

```text
File:       Idea no Hi (Japan).sfc
Size:       2097152
CRC32:      2796523e  [selected]
MD5:        8eee9bab94c00436d1e799ffcac88b4c
SHA-1:      5f9fd724d1e29af65bbd92d0bae030364e5dbb03
SHA-256:    a1c822eca5555e24e904e947a6db5f375de17970446a386421aeb7c55e2eb6b3 
```
