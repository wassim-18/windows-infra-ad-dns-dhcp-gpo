#requires -RunAsAdministrator
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$reportsDir = Join-Path $root "evidence\reports"
New-Item -ItemType Directory -Force -Path $reportsDir | Out-Null

dcdiag /v | Out-File (Join-Path $reportsDir "dcdiag.txt") -Encoding utf8
repadmin /replsummary | Out-File (Join-Path $reportsDir "repadmin-replsummary.txt") -Encoding utf8

try {
  Import-Module GroupPolicy
  Get-GPOReport -All -ReportType Html -Path (Join-Path $reportsDir "gpo-report.html")
} catch {
  "GPO report skipped: GroupPolicy module not available." | Out-File (Join-Path $reportsDir "gpo-report.txt") -Encoding utf8
}

Write-Host "Evidence exported to $reportsDir" -ForegroundColor Green
