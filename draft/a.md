```ps1
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
