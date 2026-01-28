#requires -RunAsAdministrator
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Import-Module DnsServer

# ===== EDIT ME =====
$ZoneName  = "example.local"
$DnsServer = "localhost"
$Records = @(
  @{Name="srv-dc01"; IPv4="192.168.56.10"}
)
# ===================

foreach ($r in $Records) {
  $existing = Get-DnsServerResourceRecord -ComputerName $DnsServer -ZoneName $ZoneName -Name $r.Name -ErrorAction SilentlyContinue
  if (-not $existing) {
    Add-DnsServerResourceRecordA -ComputerName $DnsServer -ZoneName $ZoneName -Name $r.Name -IPv4Address $r.IPv4
    Write-Host "Added: $($r.Name).$ZoneName -> $($r.IPv4)" -ForegroundColor Green
  } else {
    Write-Host "Exists: $($r.Name).$ZoneName" -ForegroundColor Yellow
  }
}
