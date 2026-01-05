$version = Get-Content version.txt
$parts = $version -split '\.'
$parts[2] = [int]$parts[2] + 1                              # Bump patch
$newVersion = "$($parts[0]).$($parts[1]).$($parts[2])"
Set-Content version.txt $newVersion
