Remove-Item '.\Idea no Hi (Japan).sfc'
Copy-Item -Path '.\Idea no Hi (Japan) - Clean.sfc' -Destination '.\Idea no Hi (Japan).sfc'
Write-Output "Patching Menus..."
.\asar.exe -v -werror menus.asm 'Idea no Hi (Japan).sfc'
Write-Output "Patching Font..."
.\asar.exe -v -werror font.asm 'Idea no Hi (Japan).sfc'
Write-Output "Patching Variable Width Font..."
.\asar.exe -v -werror vwf.asm 'Idea no Hi (Japan).sfc'
