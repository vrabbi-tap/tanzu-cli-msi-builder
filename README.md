# Tanzu CLI MSI Builder
### This is a POC for building an MSI for Tanzu CLI with all TAP Plugins

## Pre Requisites
1. Powershell 7 installed on a windows machine (tested on windows 10 and 11)
2. Download the windows Tanzu CLI zip file from Tanzu Network
3. Internete Access
4. Admin Access on your machine  

## Installation and Execution
### 1. Clone this repo
```powershell
git clone https://github.com/vrabbi-tap/tanzu-cli-msi-builder.git
cd tanzu-cli-msi-builder
```
### 2. Install Powershell Module
```powershell
Install-Module PowerShellProTools
```
### 3. Place Tanzu CLI zip file in the correct location
You need to place the Tanzu CLI zip file in the root directory of this repo.  

### 4. Update the variables as needed in the build script
The variables at the top of the script are the only values you may want or need to change.

### 5. Build an MSI
```powershell
.\build-msi.ps1
```
