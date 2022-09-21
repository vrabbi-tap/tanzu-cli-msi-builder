# Variables
$outputDirName = "output"
$tapVersion = "1.2.1"
$tanzuZipFileName = "tanzu-framework-windows-amd64.zip"
$company = "TeraSky Israel"
$upgradeCode = 'a8473e56-43ec-4665-9132-2ff94ac32b33'
$productName = "TAP"

# MSI Builder Logic
$DIR=(pwd).path
$installAction = New-InstallerCustomAction -FileId 'InstallPlugins' -CheckReturnValue -RunOnInstall -arguments '-NoProfile -WindowStyle Normal -InputFormat None -ExecutionPolicy Bypass'
$uninstallAction = New-InstallerCustomAction -FileId 'UninstallPlugins' -CheckReturnValue -RunOnUninstall -arguments '-NoProfile -WindowStyle Normal -InputFormat None -ExecutionPolicy Bypass'
New-Installer -Productname $productName -Manufacturer $company -platform x64 -UpgradeCode $upgradeCode -Content {
  New-InstallerDirectory -PredefinedDirectory "ProgramFiles64Folder"  -Content {
    New-InstallerDirectory -DirectoryName "tanzu" -Content {
      New-InstallerFile -Source .\$tanzuZipFileName -Id 'bundle'
      New-InstallerFile -Source .\install-plugins.ps1 -Id 'InstallPlugins'
      New-InstallerFile -Source .\uninstall-tanzu-cli.ps1 -Id 'UninstallPlugins'
    }
  }
} -OutputDirectory (Join-Path $PSScriptRoot "$outputDirName") -RequiresElevation -verbose -version $tapVersion -CustomAction $installAction,$uninstallAction -AddRemoveProgramsIcon $DIR\tanzu-icon.ico

cd $outputDirName
((Get-Content -path .\TAP.$tapVersion.x64.wxs -Raw) -replace '<CustomAction Id=','<CustomAction Impersonate="no" Id=') | Set-Content -Path .\TAP.$tapVersion.x64.wxs
rm -force .\TAP.$tapVersion.x64.msi
$modulePath = (Get-Module -ListAvailable PowerShellProTools)[0].path
$modulePath = $modulePath.substring(0,$modulePath.LastIndexOf("\"))
& $modulePath\Wix\bin\candle.exe ".\TAP.$tapVersion.x64.wxs"
& $modulePath\Wix\bin\light.exe ".\TAP.$tapVersion.x64.wixobj"
cd $DIR
