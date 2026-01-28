#requires -RunAsAdministrator
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Import-Module DhcpServer

# ===== EDIT ME =====
$DhcpServer = "localhost"
$scopeName  = "LAN-MAIN"
$scopeId    = "192.168.56.0"
$startRange = "192.168.56.100"
$endRange   = "192.168.56.200"
$router     = "192.168.56.1"
$dnsServer  = "192.168.56.10"
$dnsSuffix  = "example.local"
# ===================

if (-not (Get-DhcpServerv4Scope -ComputerName $DhcpServer -ErrorAction SilentlyContinue | Where-Object {$_.ScopeId -eq $scopeId})) {
  Add-DhcpServerv4Scope -ComputerName $DhcpServer -Name $scopeName -StartRange $startRange -EndRange $endRange -SubnetMask "255.255.255.0" -State Active
}

Set-DhcpServerv4OptionValue -ComputerName $DhcpServer -ScopeId $scopeId -Router $router -DnsServer $dnsServer -DnsDomain $dnsSuffix
Write-Host "DHCP scope + options applied." -ForegroundColor Green
