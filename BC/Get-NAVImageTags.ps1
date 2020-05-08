[CmdletBinding()]
Param (
    [Parameter(Mandatory=$true)]
    [string]$buildNumber
)
(Get-BCContainerImageTags -imageName "mcr.microsoft.com/dynamicsnav").tags | Where-Object { $_.startswith($buildNumber) -and $_.endswith('-generic') }