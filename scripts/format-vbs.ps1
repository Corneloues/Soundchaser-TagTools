# Script to format VBScript with proper indentation

param(
    [string]$inputFile = "c:\Users\roy\source\Soundchaser-TagTools\legacy\RegExpReplace-4.4.9\RegExpReplace-readable.vbs"
)

Write-Host "Reading $inputFile..."
$lines = Get-Content $inputFile

Write-Host "Formatting $($lines.Count) lines..."

$outputLines = @()
$indentLevel = 0
$indentString = "`t"

foreach ($line in $lines) {
    $trimmed = $line.Trim()
    
    # Skip empty lines or preserve comments
    if ($trimmed -eq "") {
        $outputLines += ""
        continue
    }
    
    if ($trimmed.StartsWith("'")) {
        $outputLines += $line
        continue
    }
    
    # Decrease indent BEFORE adding line for these keywords (case-insensitive)
    if ($trimmed -match '(?i)^(End Sub|End Function|End If|End With|End Select|Next|Loop|Wend|Else|ElseIf)') {
        $indentLevel = [Math]::Max(0, $indentLevel - 1)
    }
    
    # Add the line with current indentation
    $outputLines += ($indentString * $indentLevel) + $trimmed
    
    # Increase indent AFTER adding line for these keywords (case-insensitive)
    # Check for multi-line blocks
    if ($trimmed -match '(?i)^(Sub |Function |Private Sub|Public Sub|Private Function|Public Function)' -or
        $trimmed -match '(?i)^(For |While |Do |With |Select Case)') {
        $indentLevel++
    }
    # Check for If Then without End If on same line (multi-line If)
    elseif ($trimmed -match '(?i)^If .* Then\s*$') {
        $indentLevel++
    }
    # Check for Else/ElseIf
    elseif ($trimmed -match '(?i)^(Else|ElseIf .* Then)\s*$') {
        $indentLevel++
    }
}

# Write back to the same file
Write-Host "Writing formatted code back to $inputFile..."
$outputLines | Out-File -FilePath $inputFile -Encoding UTF8

Write-Host "Done! Formatted $($outputLines.Count) lines"
