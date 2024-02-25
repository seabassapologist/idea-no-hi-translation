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
