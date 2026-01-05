# Get the current trimmed version from version.txt
$version = (Get-Content version.txt).Trim()

# Check the version is in the right format
try {
    $parts = $version -split '\.' | ForEach-Object { [int]$_ }
} catch {
    Write-Error "Version must be numeric: MAJOR.MINOR.PATCH"
    exit 1
}

# Make sure there are three parts
if ($parts.Count -ne 3) {
    Write-Error "Invalid version format. Expected MAJOR.MINOR.PATCH"
    exit 1
}

# Bump
$parts[2] = [int]$parts[2] + 1                              # Bump patch
$newVersion = "$($parts[0]).$($parts[1]).$($parts[2])"

# Write the updated version
Set-Content version.txt $newVersion
Write-Host "Version bumped to $newVersion"
