#requires -RunAsAdministrator
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# =========================
# EDIT ME
# =========================
$DomainDN   = "DC=example,DC=local"     # <-- A REMPLIR
$CompanyOU  = "Company"                # <-- A REMPLIR
$HelpdeskGroup = "GG-IT-Helpdesk"
# =========================

$ComputersOU = "OU=Computers,OU=$CompanyOU,$DomainDN"

Write-Host "Delegating Join-Domain permissions on: $ComputersOU" -ForegroundColor Cyan

# Locate dsacls
$dsacls = Join-Path $env:SystemRoot "System32\dsacls.exe"
if (-not (Test-Path $dsacls)) {
    throw "dsacls.exe not found"
}

# Get DOMAIN\Group format
try {
    $netbios = (Get-ADDomain).NetBIOSName
    $principal = "$netbios\$HelpdeskGroup"
} catch {
    $principal = $HelpdeskGroup
}

Write-Host "Using principal: $principal" -ForegroundColor Yellow

# -------------------------------------------------
# Join Domain delegation
# -------------------------------------------------

# 1) Create/Delete computer objects
& $dsacls $ComputersOU /G "$principal:CCDC;computer"

# 2) Read/Write computer attributes
& $dsacls $ComputersOU /G "$principal:RPWP;description"
& $dsacls $ComputersOU /G "$principal:RPWP;servicePrincipalName"
& $dsacls $ComputersOU /G "$principal:RPWP;dNSHostName"

# 3) Reset machine password
& $dsacls $ComputersOU /G "$principal:CA;Reset Password"

Write-Host "Join-Domain delegation applied." -ForegroundColor Green
Write-Host "Next: test from client PC using Helpdesk account." -ForegroundColor Cyan
