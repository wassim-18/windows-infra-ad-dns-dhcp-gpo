#requires -RunAsAdministrator
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Import-Module DhcpServer

# =========================
# EDIT ME
# =========================
$DhcpServer = "localhost"

$scopeName  = "LAN-MAIN"
$scopeId    = "192.168.56.0"

$startRange = "192.168.56.100"
$endRange   = "192.168.56.200"

$exclStart  = "192.168.56.1"
$exclEnd    = "192.168.56.20"

$router     = "192.168.56.1"
$dnsServer  = "192.168.56.10"
$dnsSuffix  = "example.local"

$resCSV = Join-Path $PSScriptRoot "..\..\configs\dhcp\reservations.sample.csv"
# =========================

$root = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$reportDir = Join-Path $root "evidence\reports"
New-Item -ItemType Directory -Force -Path $reportDir | Out-Null

Write-Host "=== DHCP Advanced Setup ===" -ForegroundColor Cyan

# 1) Authorize DHCP (AD)
try {
    Add-DhcpServerInDC -DnsName (hostname) -IPAddress $dnsServer -ErrorAction SilentlyContinue
    Write-Host "DHCP authorized in AD" -ForegroundColor Green
} catch {
    Write-Host "DHCP already authorized" -ForegroundColor Yellow
}

# 2) Create scope
$scope = Get-DhcpServerv4Scope -ComputerName $DhcpServer -ErrorAction SilentlyContinue |
         Where-Object { $_.ScopeId -eq $scopeId }

if (-not $scope) {
    Add-DhcpServerv4Scope `
        -ComputerName $DhcpServer `
        -Name $scopeName `
        -StartRange $startRange `
        -EndRange $endRange `
        -SubnetMask "255.255.255.0" `
        -State Active

    Write-Host "Scope created: $scopeName" -ForegroundColor Green
} else {
    Write-Host "Scope exists: $scopeName" -ForegroundColor Yellow
}

# 3) Exclusions
Add-DhcpServerv4ExclusionRange `
    -ComputerName $DhcpServer `
    -ScopeId $scopeId `
    -StartRange $exclStart `
    -EndRange $exclEnd `
    -ErrorAction SilentlyContinue

Write-Host "Exclusions configured" -ForegroundColor Green

# 4) Options
Set-DhcpServerv4OptionValue `
    -ComputerName $DhcpServer `
    -ScopeId $scopeId `
    -Router $router `
    -DnsServer $dnsServer `
    -DnsDomain $dnsSuffix

Write-Host "DHCP options applied" -ForegroundColor Green

# 5) Reservations (CSV)
if (Test-Path $resCSV) {

    $rows = Import-Csv $resCSV

    foreach ($r in $rows) {

        if ($r.IPAddress -and $r.ClientId) {

            $exists = Get-DhcpServerv4Reservation `
                -ComputerName $DhcpServer `
                -ScopeId $scopeId `
                -ErrorAction SilentlyContinue |
                Where-Object { $_.IPAddress -eq $r.IPAddress }

            if (-not $exists) {

                Add-DhcpServerv4Reservation `
                    -ComputerName $DhcpServer `
                    -ScopeId $scopeId `
                    -IPAddress $r.IPAddress `
                    -ClientId $r.ClientId `
                    -Name $r.Name `
                    -Description $r.Description

                Write-Host "Reservation added: $($r.Name)" -ForegroundColor Green
            }
        }
    }

} else {
    Write-Host "CSV not found: $resCSV" -ForegroundColor Yellow
}

# 6) Export configuration (evidence)
Get-DhcpServerv4Scope `
    -ComputerName $DhcpServer |
    Out-File (Join-Path $reportDir "dhcp-scopes.txt")

Get-DhcpServerv4Reservation `
    -ComputerName $DhcpServer `
    -ScopeId $scopeId |
    Out-File (Join-Path $reportDir "dhcp-reservations.txt")

Get-DhcpServerv4OptionValue `
    -ComputerName $DhcpServer `
    -ScopeId $scopeId |
    Out-File (Join-Path $reportDir "dhcp-options.txt")

Write-Host "DHCP configuration exported" -ForegroundColor Cyan
Write-Host "Done." -ForegroundColor Green
