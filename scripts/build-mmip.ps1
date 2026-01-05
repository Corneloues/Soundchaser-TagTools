$addonName = "Soundchaser-TagTools"

$root      = Resolve-Path ".."
$src       = Join-Path $root "src"
$build     = Join-Path $root "build"
$outFile   = Join-Path $build "$addonName.mmip"

if (!(Test-Path $build)) {
    New-Item -ItemType Directory -Path $build | Out-Null
}

if (Test-Path $outFile) {
    Remove-Item $outFile
}

Compress-Archive -Path "$src\*" -DestinationPath $outFile

Write-Host "Built $outFile"
