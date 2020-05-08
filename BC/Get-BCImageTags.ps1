[CmdletBinding()]
Param (
    [Parameter(Mandatory=$true)]
    [string]$buildNumber
)
(Get-BCContainerImageTags -imageName "mcr.microsoft.com/businesscentral/sandbox").tags `
    | Where-Object {$_.startswith($buildNumber) -and $_.endswith('ca-ltsc2019')} -ErrorAction Stop