Remove-Item '.\Idea no Hi (Japan).sfc'
Copy-Item -Path '.\Idea no Hi (Japan) - Clean.sfc' -Destination '.\Idea no Hi (Japan).sfc'
.\asar.exe -v -werror menus.asm 'Idea no Hi (Japan).sfc'