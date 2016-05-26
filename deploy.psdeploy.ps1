﻿# Generic module deployment.
# This stuff should be moved to psake for a cleaner deployment view

# ASSUMPTIONS:

 # folder structure of:
 # - RepoFolder
 #   - This PSDeploy file
 #   - ModuleName
 #     - ModuleName.psd1

 # Nuget key in $ENV:NugetApiKey

# find a folder that has psd1 of same name...
$Script:ModuleToDeploy = Get-ChildItem $PSScriptRoot -Directory |
    Where-Object {
        Test-Path $(Join-Path $_.FullName "$($_.name).psd1";)
    } |
    Select -ExpandProperty Fullname

if($ModuleToDeploy -and $ModuleToDeploy.Count -eq 1)
{

    Deploy Module {
        By PSGalleryModule {
            FromSource $Script:ModuleToDeploy
            To PSGallery
            WithOptions @{
                ApiKey = $ENV:NugetApiKey
            }
        }
    }
}