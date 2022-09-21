cd "C:\Program Files\tanzu"
Expand-Archive -path tanzu-framework-windows-amd64.zip
mv tanzu-framework-windows-amd64\cli .\
mv .\cli\core\v0.11.6\tanzu-core-windows_amd64.exe tanzu.exe
[System.Environment]::SetEnvironmentVariable('TANZU_CLI_NO_INIT','true',[System.EnvironmentVariableTarget]::Machine)
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$newpath = "$oldpath;C:\Program Files\tanzu"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
$ENV:PATH="$ENV:PATH;C:\Program Files\tanzu"
tanzu plugin install --local cli all
rm -f tanzu-framework-windows-amd64.zip
rm tanzu-framework-windows-amd64 -r -Force
rm -f install-plugins.ps1
