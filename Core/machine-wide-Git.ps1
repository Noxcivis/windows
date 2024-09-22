<#
.SYNOPSIS
This script downloads and installs Git for Windows for all users on a Windows machine.

.DESCRIPTION
The script performs the following actions:
1. Checks if the script is running with administrative privileges.
2. Checks if Git is already installed.
3. Defines the URL for the Git installer.
4. Defines the path where the installer will be downloaded.
5. Downloads the Git installer.
6. Installs Git for all users silently.
7. Removes the installer after installation.

.NOTES
- Author : Noxcivis
- Revision : 1.0
- Source : https://github.com/Noxcivis
- The script must be run from an elevated PowerShell prompt (Run as Administrator).
- The script uses the latest stable version of Git for Windows.

.EXAMPLE
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Noxcivis/windows/blob/main/Core/machine-wide-Git.ps1' -OutFile '$env:TEMP\machine-wide-Git.ps1'; powershell -ExecutionPolicy Bypass -File '$env:TEMP\machine-wide-Git.ps1'"
#>

# DOWNLOAD AND INSTALL FROM AN ADMIN POWERSHELL PROMPT
# powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Noxcivis/windows/refs/heads/main/Core/machine-wide-Git.ps1' -OutFile '$env:TEMP\machine-wide-Git.ps1'; powershell -ExecutionPolicy Bypass -File '$env:TEMP\machine-wide-Git.ps1'"

# Check if the script is running with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
   
    Write-Host "You do not have Administrator rights to run this script. Please re-run this script as an Administrator." -ForegroundColor Red
    
    # Pause for 60 seconds
    Start-Sleep -Seconds 60

    # Exit the PowerShell session
    exit

}

# Check if Git is already installed
if (Get-Command "git" -ErrorAction SilentlyContinue) {
    
    Write-Host ""
    Write-Host "Git is already installed." -ForegroundColor Green
    Write-Host ""
    
    # Pause for 60 seconds
    Start-Sleep -Seconds 60

    # Exit the PowerShell session
    exit

}

# Define the Git version and URL for the installer
$gitVersion = "2.41.0"
$installerUrl = "https://github.com/git-for-windows/git/releases/latest/download/Git-$gitVersion-64-bit.exe"

# Define the path where the installer will be downloaded
$installerPath = "$env:TEMP\GitSetup.exe"

# Download the installer with error handling
try {
    Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath -ErrorAction Stop
    Write-Host "Git installer downloaded successfully." -ForegroundColor Green
} catch {
    Write-Host "Failed to download Git installer." -ForegroundColor Red
    exit
}

# Install Git for all users with error handling
try {
    Start-Process -FilePath $installerPath -ArgumentList "/verysilent", "/allusers" -Wait -ErrorAction Stop
    Write-Host "Git for Windows has been installed." -ForegroundColor Green
} catch {
    Write-Host "Failed to install Git." -ForegroundColor Red
    exit
}

# Remove the installer after installation
Remove-Item -Path $installerPath -ErrorAction SilentlyContinue

# Pause for 60 seconds
Start-Sleep -Seconds 60

# Exit the PowerShell session
exit
