# Business Central

## How to Use this Image

### Using BcContainerHelper

[BcContainerHelper](https://www.powershellgallery.com/packages/bccontainerhelper) is a PowerShell module that can be installed from the PowerShell Gallery:

```powershell
Install-Module BcContainerHelper -Force
```

To see which functions are available in BcContainerHelper, run:

```powershell
Write-BcContainerHelperWelcomeText
```

To spin up a new Business Central on-premises container:

```powershell
$artifactUrl = Get-BcArtifactUrl -type sandbox -country us -select latest
New-BcContainer -accept_eula -containerName test -artifactUrl $artifactUrl
```

BcContainerHelper automatically selects the best image for your host operating system and helps you create on-premises containers integrated with your Active Directory in a secure way. See the [BcContainerHelper GitHub repository](https://github.com/microsoft/navcontainerhelper) for the source code and additional documentation.
