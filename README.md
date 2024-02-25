# idea-no-hi-translation

Tools and notes from my attempt at translating Idea no Hi for the Super Famicom

This repo is intended to reflect the current state of the project, so assume that whatever is here is everything that's been done so far

**Current State:**

* Dumped all known blocks of text. Currently verifying if there are any missing sections
* Very, very rough proof of concept showing that much of the existing text drawing routine can be reused to print 8x16 characters directly from ROM, by just modifying pointer tables and a few constants :D
  * A lot more work is needed, this was just done quick and dirty by editing values in a hex editor after inserting part of the font

![English Text Proof of Concept](/images/english_text_poc.png)

| Task | Status |
|------|--------|
| **Disassembly** | Ongoing |
| **Documentation** | Ongoing |
| **Table File** | Done |
| **Script Dump** | Verifying |
| **Translation** | Not Started |
| **Font Insertion** | In Progress |
| **Script Insertion** | Not Started |
| **Hacking** | Started |

## Instructions

While the current script dump will be kept available in the repository, if you'd like to run the dumper script yourself, here's how you can do that:

Dependencies:
  * Python 3.6 or above
  * Git
  * No-Intro ROM for Idea no Hi [(see below)](#misc-notes)

Optional:
  * Windows - [winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/#install-winget) or [scoop](https://scoop.sh) for easily installing python and git
  * macOS - [Homebrew](https://brew.sh) for easily installing python and git
  * Linux - Refer to your distro's package manager (e.g. apt, dnf, yum, pacman, etc.). These may already be pre-installed depending on your distro

In a terminal:

Clone the repository to your machine
```shell
git clone https://github.com/seabassapologist/idea-no-hi-translation
```

Enter the repository directory
```shell
cd idea-no-hi-translation
```

Place the ROM file inside the repository directory and make sure the filename is exactly `Idea no Hi (Japan).sfc`

Now run the dumper script

Windows:
```shell
python script_dump.py
```

macOS/Linux
```shell
./script_dump.py
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
