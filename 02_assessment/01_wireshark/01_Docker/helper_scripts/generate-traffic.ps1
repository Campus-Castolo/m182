param(
  [string]$ContainerName = "forensic-client"
)

$flags = @()
if (-not [Console]::IsInputRedirected) { $flags += "-i" }
if (-not [Console]::IsOutputRedirected) { $flags += "-t" }

Write-Host "Running traffic generator in container: $ContainerName"
& docker exec @flags $ContainerName sh /home/helper_scripts/generate-traffic.sh
exit $LASTEXITCODE
