$source = "C:\Users\rei\AppData\Roaming\SBI Securities"
$target = "E:\Users\rei\AppData\Roaming\SBI Securities"

if ((Test-Path $source) -and -not (Test-Path $target)) {
    Move-Item -Path $source -Destination $target
    New-Item -ItemType Junction -Path $source -Target $target
}
