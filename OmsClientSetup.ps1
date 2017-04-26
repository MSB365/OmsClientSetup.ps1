 <#
.SYNOPSIS
OmsCientSetup.ps1 

.DESCRIPTION 
This Script is downloading and installing the OMS Client Agent and the Service Map Client.
During the Script you will be asked to Enter the OMS Portal credentials for your Workspace, this will be needed to register the Agent in your OMS Workspace.


.PARAMETER



.EXAMPLE
.\ConfigureAAD.ps1 


.NOTES
Written by: Drago Petrovic

Download path Service Map for Linux Clients
http://download.microsoft.com/download/E/D/B/EDB22276-C316-4982-AFED-6367255D0824/InstallDependencyAgent-Linux64.bin

.TROUBLENOTES



Find me on:

* LinkedIn:	https://www.linkedin.com/in/drago-petrovic-86075730/
* Xing:     https://www.xing.com/profile/Drago_Petrovic
* Website:  https://blog.abstergo.ch
* GitHub:   https://github.com/MSB365


Change Log
V1.00, 17/01/2017 - Initial version
V1.10, 26/04/2017 - Update Customer Information about progress Status


--- keep it simple, but significant ---

.COPYRIGHT
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#>

Write-Host "--- keep it simple, but significant ---" -ForegroundColor Magenta
Write-Host "Set Variables" -ForegroundColor cyan
# Variables
$WorkspaceID = Read-Host -Prompt "Enter your WorkspaceID e.g.: 35c4b383-a41d-232f-c9b1-579c2drpe023"
$WorkspaceKey = Read-Host -Prompt "Enter your WorkspaceKey e.g.: LgE3drJfan9E8geliNaHnRtpPetrovaQ2TgBX18TU6vTdQjh725FSGnDuIHFuvHWm2EJeN5l1U0ZtQcEGdCTwv+="
Write-Host "done" -ForegroundColor green

# Create target directory
Write-Host "Create target directory" -ForegroundColor cyan
New-Item C:\sources\OMS -type directory
Write-Host "done" -ForegroundColor green

# Go to Path
cd C:\sources\OMS

# Auto Variables
$SetupPath = "C:\sources\OMS"
$OMSA = "OMS Client Agent"
$OMSS = "Service Map Client"

# Download OMS Client
Write-Host "Download OMS Client Agent" -ForegroundColor cyan
New-Item C:\SPFRequirements -ItemType Directory
Invoke-WebRequest http://download.microsoft.com/download/1/5/E/15E274B9-F9E2-42AE-86EC-AC988F7631A0/MMASetup-AMD64.exe -OutFile C:\sources\OMS\MMASetup-AMD64.exe

# Pause
Start-Sleep -s 15
Write-Host "done" -ForegroundColor green

# Install OMS Client
Write-Host "Install OMS Client" -ForegroundColor cyan
.\MMASetup-AMD64.exe /C:”setup.exe /qn ADD_OPINSIGHTS_WORKSPACE=1 OPINSIGHTS_WORKSPACE_ID=$WorkspaceID OPINSIGHTS_WORKSPACE_KEY=$WorkspaceKey AcceptEndUserLicenseAgreement=1
Write-Host "done" -ForegroundColor green

# Download Service Map Installer (WINDOWS)
Write-Host "Download Service Map Installer" -ForegroundColor cyan
New-Item C:\SPFRequirements -ItemType Directory
Invoke-WebRequest http://download.microsoft.com/download/E/D/B/EDB22276-C316-4982-AFED-6367255D0824/InstallDependencyAgent-Windows.exe -OutFile C:\sources\OMS\InstallDependencyAgent-Windows.exe

# Pause
Start-Sleep -s 15
Write-Host "done" -ForegroundColor green

# Install Service Map Client
Write-Host "Install Service Map Client" -ForegroundColor cyan
.\InstallDependencyAgent-Windows.exe AcceptEndUserLicenseAgreement=1
Write-Host "done" -ForegroundColor green
Write-Host "The $OMSA and $OMSS are downloaded and istalled! You can find the Install Files under: $SetupPath" -ForegroundColor yellow



