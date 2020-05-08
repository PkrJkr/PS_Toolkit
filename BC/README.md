# Introduction 
This is a collection of PowerShell scripts related to Microsoft Dynamics 365 Business Central containers. 

Based on **NAV Container Helper** PowerShell module, by *Freddy Kristiansen*
> https://github.com/microsoft/navcontainerhelper

## How-to's

### Check for the latest BC Sandbox base image
```
Get-BCImageTags.ps1 <part_of_build_number>
```
> Example: Get-BCImageTags.ps1 16.0

### Check for the latest NAV base image
> Used to create containers in *process isolation* mode, instead of *Hyper-V isolation* mode.
```
Get-NAVImageTags.ps1
```

### Check for pre-requisites
```
Get-PreRequisites.ps1
```

### Create a new local BC Sandbox container in Hyper-V isolation mode
1. Get the desired build number by running **Get-BCImageTags.ps1**
2. Run the following command:
```
Create-NewBC.ps1 <container_name> <memory_limit_in_GB> <build_number>
```
> Example: Create-NewBC.ps1 bc160 4 16.0.11240.12474-ca-ltsc2019