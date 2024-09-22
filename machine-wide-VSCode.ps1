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
