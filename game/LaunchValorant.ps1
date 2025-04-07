Start-Process -FilePath "C:\Riot Games\Riot Client\RiotClientServices.exe" -ArgumentList "--launch-product=valorant --launch-patchline=live"

Write-Output "Launching VALORANT via Riot Client..."

$process = $null
for ($i = 0; $i -lt 300; $i++) {
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
  }
  catch {
    Write-Error "Failed to set priority: $_"
  }
}
else {
  Write-Warning "VALORANT process not found within 300 seconds."
}
