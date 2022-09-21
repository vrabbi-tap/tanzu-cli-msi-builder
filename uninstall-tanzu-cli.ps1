rm "C:\Program Files\tanzu" -r -Force
$regLocation = "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment"
$path = (Get-ItemProperty -Path $regLocation -Name PATH).path
$path = ($path.Split(';') | Where-Object { $_ -ne "C:\Program Files\tanzu" }) -join ';'
Set-ItemProperty -Path $regLocation -Name PATH -Value $path
[System.Environment]::SetEnvironmentVariable('TANZU_CLI_NO_INIT',$null,[System.EnvironmentVariableTarget]::Machine)
