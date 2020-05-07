[CmdletBinding()]
Param (
    [Parameter(Mandatory=$true,Position=0)]
    [string] $containerName,
    [Parameter(Mandatory=$true,Position=1)]
    [string] $memoryLimit,
    [Parameter(Mandatory=$true,Position=2)]
    [string] $buildNumber
)
function CreateBCContainer {
    New-BCContainer `
        -useSSL `
        -accept_eula `
        -accept_outdated `
        -assignPremiumPlan `
        -updatehosts `
        -shortcuts None `
        -includeAL `
        -credential (New-Object PSCredential ('admin', (ConvertTo-SecureString -String 'Pass@word1' -AsPlainText -Force))) `
        -auth UserPassword `
        -containerName $containerName `
        -memoryLimit "$memoryLimitG" `
        -imageName $imageName
        # -PublishPorts 80,443,1433,7045,7046,7047,7048,7049,8080 `
        # -additionalParameters @('--network LAN', '--restart always') `
}
function InstallCertificate {
    # Target certificate store on local container host
    $certStore = "Cert:\LocalMachine\Root"

    # Path to default BC container self-signed certificate
    $certPath  = "C:\ProgramData\NavContainerHelper\Extensions\$containerName\certificate.cer"
    
    #region Install BC container self-signed certificate
    Write-Host "`nImporting new BC container self-signed certificate..." -ForegroundColor Cyan
    Import-Certificate -FilePath $certPath -CertStoreLocation $certStore -ErrorAction Stop
    Write-Host "`nCertificate imported successfully." -ForegroundColor Green
    #endregion
}

# Defines the BC container image repository
$imageName = "mcr.microsoft.com/businesscentral/sandbox:$buildNumber"

#region Check for pre-requisites
Write-Host "`nChecking pre-requisites..." -ForegroundColor Cyan
Invoke-Expression -Command $PSScriptRoot\Get-PreRequisites.ps1 -ErrorAction Stop
#endregion

#region Download BC container image (with nice progress bars)
Write-Host "`nDownloading BC container base image (build # $buildNumber)..." -ForegroundColor Cyan
Invoke-Expression "docker pull $imageName" -ErrorAction Stop
Write-Host "BC container image downloaded (build # $buildNumber)." -ForegroundColor Green
#endregion

#region Create the new BC container
Write-Host "`nCreating your new BC container...`n" -ForegroundColor Cyan
CreateBCContainer
#endregion

#region Import new BC container self-signed certificate
InstallCertificate
#endregion