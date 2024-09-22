<#
.SYNOPSIS
This script installs Chocolatey, a package manager for Windows.

.DESCRIPTION
The script performs the following actions:
1. Checks if the script is running with administrative privileges.
2. Sets the PowerShell execution policy to Bypass for the current process.
3. Downloads and installs Chocolatey from the official website.
4. Verifies the installation of Chocolatey by printing its version.

.NOTES
- Author : Noxcivis
- Revision : 1.0
- Source : https://github.com/Noxcivis
- This script must be run from an elevated (Administrator) PowerShell prompt.
- The execution policy is temporarily set to Bypass to allow the script to run.

.EXAMPLE
To download and run this script from an elevated PowerShell prompt, use the following command:
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Noxcivis/windows/refs/heads/main/Core/chocolatey-install.ps1' -OutFile '$env:TEMP\chocolatey-install.ps1'; powershell -ExecutionPolicy Bypass -File '$env:TEMP\chocolatey-install.ps1'"
#>

# DOWNLOAD AND INSTALL FROM AN ADMIN POWERSHELL PROMPT
# powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Noxcivis/windows/refs/heads/main/Core/chocolatey-install.ps1' -OutFile '$env:TEMP\chocolatey-install.ps1'; powershell -ExecutionPolicy Bypass -File '$env:TEMP\chocolatey-install.ps1'"

# Check if the script is running with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You do not have Administrator rights to run this script. Please re-run this script as an Administrator."
    exit
}

# Set the execution policy to allow the script to run
Set-ExecutionPolicy Bypass -Scope Process -Force

# Install Chocolatey
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Verify Chocolatey installation
choco -v
