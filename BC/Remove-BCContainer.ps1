[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string] $containerName
)

# Define certificate store on local host
$certStorePath = "\LocalMachine\Root\"

#region Check for pre-requisites
Write-Host "`nChecking pre-requisites..." -ForegroundColor Cyan
Invoke-Expression -Command $PSScriptRoot\Get-PreRequisites.ps1 -ErrorAction Stop
#endregion

#region Stop BC container
Write-Host "`nStopping BC container ($containerName)..." -ForegroundColor Cyan
Stop-BCContainer $containerName -ErrorAction Stop
Write-Host "`nBC container stopped." -ForegroundColor Green
#endregion

#region Remove BC container
Write-Host  "`nRemoving BC container ($containerName)..." -ForegroundColor Cyan
Remove-BCContainer $containerName -ErrorAction Stop
Write-Host "`nBC container ($containerName) removed." -ForegroundColor Green
#endregion

#region Remove BC container certificate
Write-Host "`nRemoving BC container ($containerName) certificate..." -ForegroundColor Cyan
(Get-ChildItem -Path "Cert:$certStorePath" | Where-Object {$_.Subject -like "CN=$containerName*"}) `
    | ForEach-Object {Remove-Item -Path "Cert:\LocalMachine\Root\$($_.Thumbprint)" -Verbose} -ErrorAction Stop
Write-Host "`nBC container ($containerName) self-signed certificate removed from certificate store ($certStorePath)." -ForegroundColor Green
#endregion