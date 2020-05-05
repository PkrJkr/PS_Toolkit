# Get module loaded in current session
$activeModule = Get-Module navcontainerhelper

# Get installed module
$installedModule = Get-Module navcontainerhelper -ListAvailable

# Get latest module version available from repository
$latestModule = Find-Module -Name navcontainerhelper -Repository PSGallery -ErrorAction Stop

function UpdateModule {
    Write-Host "Uninstalling current version..." -ForegroundColor Yellow
    Uninstall-Module -Name navcontainerhelper -Force -ErrorAction Stop
    Write-Host "Installing latest version..." -ForegroundColor Cyan
        
}

if ($installedModule -eq $null) {
    Write-Host "NavContainerHelper module is not installed." -ForegroundColor Red
    Write-Host "Installing latest version..." -ForegroundColor Cyan

    Install-Module -Name navcontainerhelper -Force -ErrorAction Stop

    Write-Host "NavContainerHelper version $($latestModule.Version) was successfully installed." -ForegroundColor Green
}
elseif ($latestModule.Version -gt $installedModule.Version) {
    Write-Host "There's an updated version of NavContainerHelper available." -ForegroundColor Yellow
    Write-Host "Updating it now..." -ForegroundColor Cyan

    UpdateModule

    Write-Host "NavContainerHelper version $($latestModule.Version) was successfully installed." -ForegroundColor Green

}

if ($activeModule -eq $null) {
    Write-Host "NavContainerHelper is not loaded on current session." -ForegroundColor Yellow
    Write-Host "Loading it now..." -ForegroundColor Cyan

    Import-Module -Name navcontainerhelper

    Write-Host "NavContainerHelper was successfully loaded." -ForegroundColor Green
}