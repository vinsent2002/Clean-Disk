Start-Process "cleanmgr.exe"  "/d C: /verylowdisk"

#Remove Microsoft Configuration Manager Cache
$UIResourceMgr = New-Object -ComObject UIResource.UIResourceMgr
$Cache = $UIResourceMgr.GetCacheInfo()
$Cache.GetCacheElements() |
foreach {
    $Cache.DeleteCacheElement($_.CacheElementID)
}

#Lenovo Temp Driver Installations Folder
Remove-Item $env:windir\TempInst\* -Force -Recurse

#Remove all items in Temp Folder
Remove-Item $env:windir\Temp\* -Force -Recurse -ErrorAction SilentlyContinue

#Remove Lenovo Temp Directory
Remove-Item C:\SWTOOLS -Force -Recurse
Remove-Item C:\DRIVERS -Force -Recurse

Get-ChildItem "C:\Users" -Directory -Exclude Default,Public | ForEach-Object {
    $joined_path = Join-Path -Path $_.FullName -ChildPath "AppData\Local\CrashDumps"
    if (Test-Path $joined_path) {
        Write-Host "Removing" $joined_path
        Remove-Item $joined_path -Recurse -Force
    }
}
