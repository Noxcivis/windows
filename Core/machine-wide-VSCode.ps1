<#
.SYNOPSIS
This script downloads and installs Visual Studio Code for all users on a Windows machine.

.DESCRIPTION
The script performs the following actions:
1. Checks if the script is running with administrative privileges.
2. Checks if Visual Studio Code is already installed.
3. Defines the URL for the Visual Studio Code installer.
4. Defines the path where the installer will be downloaded.
5. Downloads the Visual Studio Code installer.
6. Installs Visual Studio Code for all users silently.
7. Removes the installer after installation.

.NOTES
- Author : Noxcivis
- Revision : 1.1
- Source : https://github.com/Noxcivis
- The script must be run from an elevated PowerShell prompt (Run as Administrator).
- The script uses the latest stable version of Visual Studio Code.

.EXAMPLE
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Noxcivis/windows/refs/heads/main/Core/machine-wide-VSCode.ps1' -OutFile '$env:TEMP\machine-wide-VSCode.ps1'; powershell -ExecutionPolicy Bypass -File '$env:TEMP\machine-wide-VSCode.ps1'"
#>

# DOWNLOAD AND INSTALL FROM AN ADMIN POWERSHELL PROMPT
# powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Noxcivis/windows/refs/heads/main/Core/machine-wide-VSCode.ps1' -OutFile '$env:TEMP\machine-wide-VSCode.ps1'; powershell -ExecutionPolicy Bypass -File '$env:TEMP\machine-wide-VSCode.ps1'"

# Check if the script is running with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You do not have Administrator rights to run this script. Please re-run this script as an Administrator."
    exit
}

# Check if Visual Studio Code is already installed
if (Get-Command "code" -ErrorAction SilentlyContinue) {
    Write-Host "Visual Studio Code is already installed."
    exit
}

# Define the URL for the VSCode installer
$installerUrl = "https://update.code.visualstudio.com/latest/win32-x64-user/stable"

# Define the path where the installer will be downloaded
$installerPath = "$env:TEMP\VSCodeSetup.exe"

# Download the installer
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

# Install VSCode for all users
Start-Process -FilePath $installerPath -ArgumentList "/verysilent", "/allusers", "/mergetasks=!runcode" -Wait

# Remove the installer after installation
Remove-Item -Path $installerPath

Write-Host "Visual Studio Code has been installed."

# Pause for 60 seconds
Start-Sleep -Seconds 60

# Exit the PowerShell session
exit
