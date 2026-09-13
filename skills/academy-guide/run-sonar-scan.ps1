$ErrorActionPreference = "Stop"
 
$SonarUrl   = "http://localhost:9000"
$ProjectKey = "academy-guide"
 
$Scanner = "D:\sonar-scanner-cli-8.0.1.6346-windows-x64\sonar-scanner-8.0.1.6346-windows-x64\bin\sonar-scanner.bat"
 
$OutputDir = Join-Path (Get-Location) "sonar-results"
 
if (-not $env:SONAR_TOKEN) {
    Write-Host "SONAR_TOKEN is not set."
    Write-Host 'Run: $env:SONAR_TOKEN="YOUR_TOKEN"'
    exit 1
}
 
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null
 
$Headers = @{
    Authorization = "Bearer $env:SONAR_TOKEN"
}
 
Write-Host "======================================"
Write-Host "1. Running SonarScanner"
Write-Host "======================================"
 
& $Scanner `
    "-Dsonar.host.url=$SonarUrl" `
    "-Dsonar.token=$env:SONAR_TOKEN" `
    2>&1 | Tee-Object "$OutputDir\sonar-scan.log"
 
if ($LASTEXITCODE -ne 0) {
    Write-Host "SonarScanner failed. Check sonar-scan.log"
    exit 1
}
 
Write-Host ""
Write-Host "======================================"
Write-Host "2. Exporting all issues"
Write-Host "======================================"
 
$AllIssues = @()
$page = 1
$pageSize = 500
 
do {
    $response = Invoke-RestMethod `
        -Uri "$SonarUrl/api/issues/search?componentKeys=$ProjectKey&ps=$pageSize&p=$page" `
        -Headers $Headers
 
    if ($response.issues) {
        $AllIssues += $response.issues
    }
 
    $total = $response.total
    $page++
 
} while ($AllIssues.Count -lt $total)
 
@{
    total  = $AllIssues.Count
    issues = $AllIssues
} |
ConvertTo-Json -Depth 50 |
Out-File "$OutputDir\sonar-all-issues.json" -Encoding utf8
 
 
Write-Host ""
Write-Host "======================================"
Write-Host "3. Creating security issues report"
Write-Host "======================================"
 
$SecurityIssues = $AllIssues | Where-Object {
 
    $_.type -eq "VULNERABILITY" -or
 
    ($_.impacts -and (
        $_.impacts.softwareQuality -contains "SECURITY"
    ))
}
 
@{
    total  = @($SecurityIssues).Count
    issues = @($SecurityIssues)
} |
ConvertTo-Json -Depth 50 |
Out-File "$OutputDir\sonar-security-issues.json" -Encoding utf8
 
 
Write-Host ""
Write-Host "======================================"
Write-Host "4. Exporting measures"
Write-Host "======================================"
 
$MetricKeys = @(
    "ncloc",
    "complexity",
    "cognitive_complexity",
    "coverage",
    "duplicated_lines_density",
    "duplicated_lines",
    "duplicated_blocks"
) -join ","
 
Invoke-RestMethod `
    -Uri "$SonarUrl/api/measures/component?component=$ProjectKey&metricKeys=$MetricKeys" `
    -Headers $Headers |
ConvertTo-Json -Depth 50 |
Out-File "$OutputDir\sonar-measures.json" -Encoding utf8
 
 
Write-Host ""
Write-Host "======================================"
Write-Host "5. Exporting Quality Gate"
Write-Host "======================================"
 
Invoke-RestMethod `
    -Uri "$SonarUrl/api/qualitygates/project_status?projectKey=$ProjectKey" `
    -Headers $Headers |
ConvertTo-Json -Depth 50 |
Out-File "$OutputDir\sonar-quality-gate.json" -Encoding utf8
 
 
Write-Host ""
Write-Host "======================================"
Write-Host "6. Exporting available metrics"
Write-Host "======================================"
 
$AllMetrics = @()
$page = 1
 
do {
 
    $response = Invoke-RestMethod `
        -Uri "$SonarUrl/api/metrics/search?ps=500&p=$page" `
        -Headers $Headers
 
    if ($response.metrics) {
        $AllMetrics += $response.metrics
    }
 
    $total = $response.total
    $page++
 
} while ($AllMetrics.Count -lt $total)
 
@{
    total   = $AllMetrics.Count
    metrics = $AllMetrics
} |
ConvertTo-Json -Depth 50 |
Out-File "$OutputDir\sonar-metrics.json" -Encoding utf8
 
 
Write-Host ""
Write-Host "======================================"
Write-Host "7. Exporting rules"
Write-Host "======================================"
 
$AllRules = @()
$page = 1
 
do {
 
    $response = Invoke-RestMethod `
        -Uri "$SonarUrl/api/rules/search?ps=500&p=$page" `
        -Headers $Headers
 
    if ($response.rules) {
        $AllRules += $response.rules
    }
 
    if ($response.total) {
        $total = $response.total
    }
    else {
        $total = $AllRules.Count
    }
 
    $page++
 
} while ($AllRules.Count -lt $total)
 
@{
    total = $AllRules.Count
    rules = $AllRules
} |
ConvertTo-Json -Depth 50 |
Out-File "$OutputDir\sonar-rules.json" -Encoding utf8
 
 
Write-Host ""
Write-Host "======================================"
Write-Host "8. Trying Security Hotspots export"
Write-Host "======================================"
 
try {
 
    $Hotspots = @()
    $page = 1
 
    do {
 
        $response = Invoke-RestMethod `
            -Uri "$SonarUrl/api/hotspots/search?projectKey=$ProjectKey&ps=500&p=$page" `
            -Headers $Headers
 
        if ($response.hotspots) {
            $Hotspots += $response.hotspots
        }
 
        if ($response.paging.total) {
            $total = $response.paging.total
        }
        else {
            $total = $Hotspots.Count
        }
 
        $page++
 
    } while ($Hotspots.Count -lt $total)
 
    @{
        total    = $Hotspots.Count
        hotspots = $Hotspots
    } |
    ConvertTo-Json -Depth 50 |
    Out-File "$OutputDir\sonar-hotspots.json" -Encoding utf8
 
}
catch {
 
    @{
        status  = "NOT_EXPORTED"
        reason  = "Security Hotspots endpoint was unavailable or unsupported by this SonarQube version."
        error   = $_.Exception.Message
    } |
    ConvertTo-Json -Depth 20 |
    Out-File "$OutputDir\sonar-hotspots.json" -Encoding utf8
}
 
 
Write-Host ""
Write-Host "======================================"
Write-Host "REPORT GENERATION COMPLETED"
Write-Host "======================================"
 
Get-ChildItem $OutputDir | Select-Object Name, Length
 
Write-Host ""
Write-Host "Reports saved at:"
Write-Host $OutputDir