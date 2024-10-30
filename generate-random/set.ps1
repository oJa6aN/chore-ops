# Define the alias name and the executable path
$aliasName = "pswd"
$exePath = "E:\github\oJa6aN\chores-for-windows\generate-random\app\generate_password\target\release\generate_password.exe"

if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
}

$profileContent = Get-Content -Path $PROFILE

$updatedProfileContent = $profileContent | Where-Object { $_ -notlike "Set-Alias -Name $aliasName*" }

Set-Content -Path $PROFILE -Value $updatedProfileContent

Add-Content -Path $PROFILE -Value "Set-Alias -Name $aliasName -Value `"$exePath`""

Write-Host "Alias '$aliasName' has been updated in the PowerShell profile."
