$version = Get-Content version.txt
$parts = $version -split '\.'
$parts[0] = [int]$parts[0] + 1                              # Bump major
$newVersion = "$($parts[0]).0.0"
Set-Content version.txt $newVersion
