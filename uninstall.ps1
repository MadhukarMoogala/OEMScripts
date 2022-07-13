Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall | Get-ItemProperty | Where-Object { ($_.Publisher -match "FUN") -or ($_.Publisher -match "Autodesk") } | Select-Object -Property DisplayName, UninstallString | Format-Table -autosize | out-string -width 4096