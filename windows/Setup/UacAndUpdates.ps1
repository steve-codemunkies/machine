Param (
    [Parameter(ParameterSetName="Disable")]
    [switch]$Disable
)

$disablingUaCAndUpdates = $false

if ($Disable.IsPresent) {
    $disablingUaCAndUpdates = $true
}

if ($disablingUaCAndUpdates) {
    Disable-MicrosoftUpdate
    Disable-UAC
} else {
    Enable-UAC
    Enable-MicrosoftUpdate
}

Restart-Computer -Confirm