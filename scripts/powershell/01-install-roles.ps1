#requires -RunAsAdministrator
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Write-Host "Installing roles: AD DS, DNS, DHCP, GPMC..." -ForegroundColor Cyan
Install-WindowsFeature AD-Domain-Services, DNS, DHCP, GPMC -IncludeManagementTools
Write-Host "Done. Reboot if required." -ForegroundColor Green
