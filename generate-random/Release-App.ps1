$ScriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$AppPath = Join-Path $ScriptDir "app"

$Projects = Get-ChildItem -Path $AppPath -Directory

foreach ($Project in $Projects) {
    Write-Host "Building project: $($Project.Name)"
    Set-Location "$($Project.FullName)"
    cargo build --release
    Set-Location $AppPath
}

