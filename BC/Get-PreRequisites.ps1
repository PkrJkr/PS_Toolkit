function UpdateModule {
    Write-Host "Uninstalling current version $($installedModule.Version)..." -ForegroundColor Cyan
    Uninstall-Module -Name navcontainerhelper -Force -ErrorAction Stop

    Write-Host "Installing latest version $($latestModule.Version)..." -ForegroundColor Cyan
    Install-Module -Name navcontainerhelper -Force -ErrorAction Stop
}

# Get installed module
$installedModule = Get-Module navcontainerhelper -ListAvailable

# Get module loaded in current session
$activeModule = Get-Module navcontainerhelper

# Get latest module version available from repository
$latestModule = Find-Module -Name navcontainerhelper -Repository PSGallery -ErrorAction Stop

#region Check if module is installed and is latest
if ($null -eq $installedModule) {
    Write-Warning "NavContainerHelper module is not installed."

    Write-Host "Installing latest version $($latestModule.Version)..." -ForegroundColor Cyan
    Install-Module -Name navcontainerhelper -Force -ErrorAction Stop
    Write-Host "NavContainerHelper version $($latestModule.Version) was successfully installed." -ForegroundColor Green
}
elseif ($latestModule.Version -gt $installedModule.Version) {
    Write-Warning "There's a new version of NavContainerHelper module available: v$($latestModule.Version)."
    
    Write-Host "Updating it now..." -ForegroundColor Cyan
    UpdateModule
    Write-Host "NavContainerHelper version $($latestModule.Version) was successfully installed." -ForegroundColor Green
}
#endregion

#region Check if module is loaded in current session
if ($null -eq $activeModule) {
    Write-Warning "NavContainerHelper is not loaded on current session."

    Write-Host "Loading it now..." -ForegroundColor Cyan
    Import-Module -Name navcontainerhelper
    Write-Host "NavContainerHelper was successfully loaded." -ForegroundColor Green
}
#endregion
