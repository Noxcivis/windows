<#
.SYNOPSIS
    This script checks if Git is installed and sets the global Git configuration for user name and email.

.DESCRIPTION
    The script performs the following actions:
    1. Checks if Git is installed on the system.
    2. If Git is installed, prompts the user to enter their Git user name and email.
    3. Sets the global Git configuration with the provided user name and email.
    4. If Git is not installed, prompts the user to install Git.

.PARAMETERS
    None.

.INPUTS
    None. The script prompts the user for input.

.OUTPUTS
    None. The script writes messages to the host.

.EXAMPLE
    To run the script, execute the following command in PowerShell:
    .\setup-git.ps1

.NOTES
    Ensure that Git is installed on the system before running this script.
#>

# SETUP GIT
# powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Noxcivis/windows/refs/heads/main/Core/setup-git.ps1' -OutFile '$env:TEMP\setup-git.ps1'; powershell -ExecutionPolicy Bypass -File '$env:TEMP\setup-git.ps1'"

# Check if Git is installed
$gitPath = Get-Command git -ErrorAction SilentlyContinue

if ($gitPath) {
    Write-Host "Git is installed at $($gitPath.Path)"
    
    # Prompt for user name and email
    $gitUserName = Read-Host "Enter your Git user name"
    $gitUserEmail = Read-Host "Enter your Git user email"
    
    # Set the global Git configuration
    git config --global user.name "$gitUserName"
    git config --global user.email "$gitUserEmail"
    
    Write-Host "Git global configuration updated successfully."
    
    # Output the current Git global configuration
    Write-Host "Current Git global configuration:"
    git config --global --list
} else {
    Write-Host "Git is not installed. Please install Git and try again."
}
