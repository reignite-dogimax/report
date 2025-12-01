$content = Get-Content README_for_pdf.md -Raw -Encoding UTF8

# Eliminar dobles pipes al inicio de líneas
$content = $content -replace "`n`| `|", "`n|"
$content = $content -replace "`r`n`| `|", "`r`n|"

# Corregir filas de tabla que tienen | pero no espacios alrededor
$lines = $content -split "`r?`n"
$fixedLines = @()

foreach ($line in $lines) {
    # Si la línea empieza con | pero el siguiente carácter no es espacio
    if ($line -match '^\|\S') {
        $line = $line -replace '^\|', '| '
    }
    # Si la línea termina con | pero el anterior no es espacio
    if ($line -match '\S\|$' -and $line -match '\|') {
        $line = $line -replace '\|$', ' |'
    }
    $fixedLines += $line
}

$newContent = $fixedLines -join "`n"

[System.IO.File]::WriteAllText("README_for_pdf.md", $newContent, [System.Text.Encoding]::UTF8)
Write-Host "Correcciones finales aplicadas"

