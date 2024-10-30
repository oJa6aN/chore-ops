$source = "C:\Users\rei\AppData\Roaming\Vortex"
$target = "D:\Users\rei\AppData\Roaming\Vortex"

if ((Test-Path $source) -and -not (Test-Path $target)) {
    Move-Item -Path $source -Destination $target
    New-Item -ItemType Junction -Path $source -Target $target
}
