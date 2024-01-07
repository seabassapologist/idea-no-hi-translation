# Miscellaneous Finds

Interesting stuff that doesn't have anything to do with text encoding or printing

* **WRAM**`$00017-$0001A` seem to be bytes used to record play time. `$3C` is 60 in decimal, and there's the right number and order of checks for it to be counting seconds, minutes, and hours
    * At **loROM**`$85C1E2` **WRAM**`$00017` is checked to see if it's equal to `$3C`, and if not increment it by one and continues with execution
    * Once it hits that value, it's reset to `$00`, and then **WRAM**`$00018` is loaded, incremented and checked if it's `$3C`
    * This process keeps repeating until **WRAM**`$00018` equals `#$3C`, and then **WRAM**`$00019` goes through this same process
    * Once **WRAM**`$00019` equals `#$3C` execution jumps to **loROM**`$85C204`, which hasn't been encountered yet
        * But once it does, **WRAM**`$0001A` is incremented once (unclear what this means)