$riotClient = "C:\Riot Games\Riot Client\RiotClientServices.exe"
$riotArgs = "--launch-product=valorant --launch-patchline=live"

Start-Process -FilePath $riotClient -ArgumentList $riotArgs
Write-Output "Launching VALORANT via Riot Client..."

$process = $null
for ($i = 0; $i -lt 180; $i++) {
  Start-Sleep -Seconds 1
  $process = Get-Process -Name "VALORANT-Win64-Shipping" -ErrorAction SilentlyContinue
  if ($process) {
    Write-Output "VALORANT process detected."
    break
  }
}

if ($process) {
  try {
    $process.PriorityClass = "High"
    Write-Output "Priority set to High."
  }
  catch {
    Write-Error "Failed to set priority: $_"
  }
}
else {
  Write-Warning "VALORANT process not found within 180 seconds."
}
