$version = Get-Content version.txt
$parts = $version -split '\.'
$parts[1] = [int]$parts[1] + 1                              // Bump minor
$newVersion = "$($parts[0]).$($parts[1]).$($parts[2])"
Set-Content version.txt $newVersion
