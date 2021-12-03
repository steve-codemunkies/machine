Param (
    [Parameter(ParameterSetName="Enable")]
    [switch]$Enable
)

$enablingUaCAndUpdates = $false

if ($Enable.IsPresent) {
    $enablingUaCAndUpdates = $true
}

if ($enablingUaCAndUpdates) {
    Enable-UAC
    Enable-MicrosoftUpdate
} else {
    Disable-MicrosoftUpdate
    Disable-UAC
}

Restart-Computer -Confirm