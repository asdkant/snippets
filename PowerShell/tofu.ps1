<#
.SYNOPSIS
    OpenTofu wrapper script for common Terraform operations.

.DESCRIPTION
    This script provides a convenient wrapper around OpenTofu commands for planning, applying, and destroying infrastructure.
    It includes audio notifications when operations complete and ensures only one operation can be executed at a time.

.PARAMETER Plan
    Executes 'tofu plan' to show what changes will be made without applying them.
    This is useful for reviewing infrastructure changes before applying them.

.PARAMETER Apply
    Executes 'tofu apply' with auto-approval to apply infrastructure changes.
    This will make actual changes to your infrastructure based on the current configuration.

.PARAMETER Destroy
    Executes 'tofu apply -destroy' with auto-approval to destroy all managed infrastructure.
    WARNING: This will destroy all resources managed by this OpenTofu configuration.

.EXAMPLE
    .\tofu.ps1 -Plan
    Shows what infrastructure changes would be made without applying them.

.EXAMPLE
    .\tofu.ps1 -Apply
    Applies the infrastructure changes defined in the OpenTofu configuration.

.EXAMPLE
    .\tofu.ps1 -Destroy
    Destroys all infrastructure managed by this OpenTofu configuration.

.NOTES
    File Name      : tofu.ps1
    Author         : Ariel Kanterewicz
    Prerequisite   : OpenTofu must be installed and available in PATH
    
    The script uses parameter sets to ensure only one operation can be specified at a time.
    Audio notifications are played when operations complete (different tones for different operations).

.LINK
    https://opentofu.org/docs/
#>

param (
    [Parameter(ParameterSetName = 'Plan', HelpMessage = "Show what changes will be made without applying them")]
    [switch]$Plan,
    
    [Parameter(ParameterSetName = 'Destroy', HelpMessage = "Destroy all managed infrastructure (WARNING: This is destructive!)")]
    [switch]$Destroy,
    
    [Parameter(ParameterSetName = 'Apply', HelpMessage = "Apply infrastructure changes with auto-approval")]
    [switch]$Apply
)

if ($Plan) {
    tofu plan
    [console]::beep(350, 700)
}

if ($Destroy) {
    tofu apply -destroy -auto-approve -compact-warnings
    [console]::beep(350, 700)
}

If ($Apply) {
    tofu apply -auto-approve -compact-warnings
    [console]::beep(500, 1000)
}

