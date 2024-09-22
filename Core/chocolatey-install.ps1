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
