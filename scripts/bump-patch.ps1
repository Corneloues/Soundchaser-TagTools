$version = Get-Content version.txt
$parts = $version -split '\.'

if ($parts.Count -ne 3) {
    Write-Error "Invalid version format. Expected MAJOR.MINOR.PATCH"
    exit 1
}

$parts[2] = [int]$parts[2] + 1                              # Bump patch
$newVersion = "$($parts[0]).$($parts[1]).$($parts[2])"
Set-Content version.txt $newVersion
Write-Host "Version bumped to $newVersion"
