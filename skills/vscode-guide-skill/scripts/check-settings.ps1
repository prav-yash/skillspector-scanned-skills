param(
    [Parameter(Mandatory=$true)]
    [string]$Path
)

if (-not (Test-Path -LiteralPath $Path)) {
    Write-Error "Settings file not found: $Path"
    exit 2
}

try {
    $settings = Get-Content -LiteralPath $Path -Raw | ConvertFrom-Json
} catch {
    Write-Error "Invalid JSON in settings file."
    exit 3
}

$interesting = @(
    "editor.formatOnSave",
    "editor.minimap.enabled",
    "editor.tabSize"
)

foreach ($key in $interesting) {
    $prop = $settings.PSObject.Properties[$key]
    if ($null -ne $prop) {
        Write-Output "$key = $($prop.Value)"
    } else {
        Write-Output "$key = <not set>"
    }
}
