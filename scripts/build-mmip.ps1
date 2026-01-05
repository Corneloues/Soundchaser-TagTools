# build-mmip.ps1
# Build MediaMonkey Addon (.mmip) - Windows

# -------------------------
# CONFIG
# -------------------------
$addonName = "Soundchaser-TagTools"    # Base name
$version   = "1.0.0"                   # Only for internal use, not in filename
$root      = Resolve-Path ".."         # Adjust if script moved
$src       = Join-Path $root "src"
$build     = Join-Path $root "build"
$outFile   = Join-Path $build "$addonName.mmip"  # Fixed filename for MM update

# -------------------------
# PREPARE BUILD FOLDER
# -------------------------
if (!(Test-Path $build)) {
    New-Item -ItemType Directory -Path $build | Out-Null
}

# Remove existing mmip
if (Test-Path $outFile) {
    Remove-Item $outFile
}

# -------------------------
# COMPRESS TO MMIP
# -------------------------
Compress-Archive -Path "$src\*" -DestinationPath $outFile

Write-Host "✅ Built $outFile"
