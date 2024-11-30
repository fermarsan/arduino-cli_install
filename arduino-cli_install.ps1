Set-PSDebug -Trace 0    #echo off

# this is a batch file to automate the installing of arduino-cli on Windows

# Download arduino-cli.zip from official page
if (-not (Test-Path -Path "..\arduino-cli.zip")) {  # if the .zip file doesn't exist
    Write-Output "`nDownloading arduino-cli.zip from official page..."
    Invoke-WebRequest "https://downloads.arduino.cc/arduino-cli/arduino-cli_latest_Windows_64bit.zip" -OutFile "..\arduino-cli.zip"
}

# Unzip arduino-cli.zip to C:\arduino-cli
if (-not (Test-Path -Path "C:\arduino-cli")) {    # if the folder doesn't exist
    Write-Output "`nUnzipping arduino-cli.zip to C:\arduino-cli..."
    Expand-Archive -Path "..\arduino-cli.zip" -DestinationPath "C:\arduino-cli"
} 

# Create arduino-cli symlink (add it to PATH)
if (-not (Get-Command arduino-cli)) { # if the command doesn't exist
    Write-Output "`nCreating arduino-cli symlink..."
    $env:PATH += ";C:\arduino-cli\"
    [System.Environment]::SetEnvironmentVariable("PATH", $env:PATH, "Machine")
}

# install AVR core
arduino-cli core install arduino:avr

# restore de execution policy
Set-ExecutionPolicy Restricted

Write-Output "`nProcess completed."
Read-Host -Prompt "`nPress any key to continue"
