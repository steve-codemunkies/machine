[CmdletBinding(DefaultParameterSetName='Prereqs')]
Param(
    [Parameter(ParameterSetName='Uac')]
    [switch]$DisableUac,
    [Parameter(ParameterSetName='Prereqs')]
    [switch]$Prereqs,
    [Parameter(ParameterSetName='Software')]
    [switch]$Ubuntu,
    [Parameter(ParameterSetName='Software')]
    [switch]$Apps,
    [Parameter(ParameterSetName='Software')]
    [switch]$VSCodeExtensions,
    [Parameter(ParameterSetName='Uac')]
    [switch]$EnableUac
)

# Nothing selected? Show help screen.
if (!$Prereqs.IsPresent -and !$Ubuntu.IsPresent -and !$Apps.IsPresent `
    -and !$VSCodeExtensions.IsPresent -and !$DisableUac.IsPresent `
    -and !$EnableUac.IsPresent)
{
    Get-Help .\Install.ps1
    Exit;
}

# Load some utilities
. (Join-Path $PSScriptRoot "./Utilities/Utilities.ps1")

# Assert that we're running as administrators
Assert-Administrator -FailMessage "This script must be run as administrator.";

# Install BoxStarter + Chocolatey if missing
if (!(Assert-CommandExists -CommandName "Install-BoxstarterPackage")) {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://boxstarter.org/bootstrapper.ps1')); 
    Get-Boxstarter -Force
}

if ($DisableUac.IsPresent) {
    ./Setup/UacAndUpdates.ps1 -Disable
}
if ($Prereqs.IsPresent) {
    Install-BoxstarterPackage ./Setup/Prereqs.ps1 -DisableReboots
    RefreshEnv
}
if ($Apps.IsPresent) {
    Install-BoxstarterPackage ./Setup/Apps.ps1 -DisableReboots
    RefreshEnv
}
if ($VSCodeExtensions.IsPresent) {
    Install-BoxstarterPackage ./Setup/Code.ps1 -DisableReboots
    RefreshEnv
}
if ($Ubuntu.IsPresent) {
    Install-BoxstarterPackage ./Setup/Ubuntu.ps1 -DisableReboots
    RefreshEnv
}
if ($EnableUac.IsPresent) {
    ./Setup/UacAndUpdates.ps1 
}
