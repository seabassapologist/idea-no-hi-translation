Remove-Item '.\Idea no Hi (Japan).sfc'
Copy-Item -Path '.\Idea no Hi (Japan) - Clean.sfc' -Destination '.\Idea no Hi (Japan).sfc'
Write-Output "Patching Menus..."
.\asar.exe -v -werror code\menus.asm 'Idea no Hi (Japan).sfc'
Write-Output ""
Write-Output "Patching Font..."
.\asar.exe -v -werror code\font.asm 'Idea no Hi (Japan).sfc'
Write-Output ""
Write-Output "Patching Variable Width Font..."
.\asar.exe -v -werror code\vwf.asm 'Idea no Hi (Japan).sfc'
Write-Output ""
Write-Output "Inserting English Script"
.\asar.exe -v -werror code\script.asm 'Idea no Hi (Japan).sfc'
