# New My Windows PC's Setups

This setup guide is intended for individuals who have an understanding of basic operations in PowerShell and Registry Editor, as well as for those who use their PCs for gameplay.

## Deploy the integrated update tool

Install App Installer from Microsoft Store.

[App Installer - Microsoft Apps](https://apps.microsoft.com/detail/9nblggh4nns1)

```ps1
Install-Module -Name PSWindowsUpdate -Force
```

## Edit Registry

It is better to set the registry after the application has been installed because some applications modify the registry upon installation.

### Backup Current Registry

Create a backup of your current registry before modifying it in the next step.

```ps1
$backupFolderPath = "C:\Windows\System32\config\RegBack"

if (-not (Test-Path -Path $backupFolderPath)) {
    New-Item -Path $backupFolderPath -ItemType Directory
}

$backupFilePath = Join-Path -Path $backupFolderPath -ChildPath "${env:USERNAME}-HKCU-$(Get-Date -Format 'yyyyMMddHHmmss').reg"
reg export "HKCU" $backupFilePath
```

### Diasble Shortcut Keys You Don't Use

Shortcuts like Sticky Keys are often entered unintentionally during gameplay. Disable shortcut keys you don't use.

```ps1
# Disable Sticky Keys
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Value "506"

# Disable Toggle Keys Sound
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\ToggleKeys" -Name "Flags" -Value "58"

# Disable Filter Keys
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "Flags" -Value "122"

# Disable Magnify.exe ------------------------------------
function Set-DisallowRun {
    param (
        [string] $applicationName
    )

    $keyLocation = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"

    # Create Key, DisallowRun if not exists
    $disallowRunKey = Get-Item -Path "${keyLocation}\DisallowRun" -ErrorAction SilentlyContinue
    if ($null -eq $disallowRunKey) {
        $disallowRunKey = New-Item -Path "${keyLocation}\DisallowRun" -Force
    }

    # Enable DisallowRun
    Set-ItemProperty -Path $keyLocation -Name "DisallowRun" -Value 1 -Type DWord

    # Check if the application is already registered.
    $existingProperties = Get-ItemProperty -Path "${keyLocation}\DisallowRun" -ErrorAction SilentlyContinue
    $isRegistered = $false
    $maxNumber = 0
    foreach ($prop in $existingProperties.PSObject.Properties) {
        if ($prop.Name -match '^\d+$') {
            if ($prop.Value -eq $applicationName) {
                $isRegistered = $true
                break
            }
            $maxNumber = [math]::Max($maxNumber, [int]$prop.Name)
        }
    }

    if (-not $isRegistered) {
        $newPropertyName = ($maxNumber + 1).ToString()
        Set-ItemProperty -Path "${keyLocation}\DisallowRun" -Name $newPropertyName -Value $applicationName -Type String -Force
    }
}
Set-DisallowRun "Magnify.exe"
# --------------------------------------------------------
```

## Restart

Restart Windows to apply the changes to the registry.
