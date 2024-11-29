Set-PSDebug -Trace 0    #echo off

# this is a batch file to automate the installing of arduino-cli on Windows
# copy 'arduino-cli.zip' in the same folder of this file after executing as administrator

# Unzip arduino-cli.zip to C:\arduino-cli
if (-not (Test-Path -Path 'C:\arduino-cli')) {    # if the folder doesn't exist
    Write-Output 'Unzipping arduino-cli.zip to C:\arduino-cli...'
    Expand-Archive -Path '.\arduino-cli_1.1.1_Windows_64bit.zip' -DestinationPath 'C:\arduino-cli'
} 

# Create arduino-cli symlink
if (-not (Get-Command arduino-cli)) { # if the command doesn't exist
    Write-Output "Creating arduino-cli symlink..."
    $env:PATH += ";C:\arduino-cli\"
    [System.Environment]::SetEnvironmentVariable("PATH", $env:PATH, "Machine")
}

# install AVR core
arduino-cli core install arduino:avr

# restore de execution policy
Set-ExecutionPolicy Restricted

Write-Output "Process completed."
Read-Host -Prompt "Press any key to continue"
