# Script to un-minify VBScript file by splitting on colons
# while respecting string literals

param(
    [string]$inputFile = "c:\Users\roy\source\Soundchaser-TagTools\legacy\RegExpReplace-4.4.9\RegExpReplace.vbs",
    [string]$outputFile = "c:\Users\roy\source\Soundchaser-TagTools\legacy\RegExpReplace-4.4.9\RegExpReplace-readable.vbs"
)

Write-Host "Reading $inputFile..."
$content = Get-Content $inputFile -Raw

# Split into lines
$lines = $content -split "`r`n|`n"

# Find the minified line (starts with "Option Explicit")
$outputLines = @()
$foundMinified = $false

foreach ($line in $lines) {
    if ($line -match '^Option Explicit:') {
        Write-Host "Found minified line, processing..."
        $foundMinified = $true
        
        # Split the line intelligently, respecting string literals
        $statements = @()
        $currentStatement = ""
        $inString = $false
        $chars = $line.ToCharArray()
        
        for ($i = 0; $i -lt $chars.Length; $i++) {
            $char = $chars[$i]
            
            if ($char -eq '"') {
                # Toggle string state
                $inString = -not $inString
                $currentStatement += $char
            }
            elseif ($char -eq ':' -and -not $inString) {
                # Statement separator outside of strings
                if ($currentStatement.Trim() -ne "") {
                    $statements += $currentStatement.Trim()
                }
                $currentStatement = ""
            }
            else {
                $currentStatement += $char
            }
        }
        
        # Add the last statement
        if ($currentStatement.Trim() -ne "") {
            $statements += $currentStatement.Trim()
        }
        
        Write-Host "Split into $($statements.Count) statements"
        
        # Add all statements as separate lines
        foreach ($stmt in $statements) {
            $outputLines += $stmt
        }
    }
    else {
        $outputLines += $line
    }
}

# Write to output file
Write-Host "Writing to $outputFile..."
$outputLines | Out-File -FilePath $outputFile -Encoding UTF8

Write-Host "Done! Created readable version with $($outputLines.Count) lines"
