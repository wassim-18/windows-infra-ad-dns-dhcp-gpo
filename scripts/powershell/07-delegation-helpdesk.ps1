#requires -RunAsAdministrator
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# =========================
# EDIT ME (placeholders)
# =========================
$DomainDN   = "DC=example,DC=local"   # <-- A REMPLIR
$CompanyOU  = "Company"              # <-- A REMPLIR (ex: Equitable)
$HelpdeskGroup = "GG-IT-Helpdesk"    # <-- groupe Helpdesk
# =========================

$UsersOU = "OU=Users,OU=$CompanyOU,$DomainDN"

Write-Host "Delegating Helpdesk permissions on: $UsersOU" -ForegroundColor Cyan

# Validate dsacls availability
$dsacls = Join-Path $env:SystemRoot "System32\dsacls.exe"
if (-not (Test-Path $dsacls)) {
    throw "dsacls.exe not found at $dsacls"
}

# Resolve group to DOMAIN\GroupName format (best effort)
try {
    $domainNetbios = (Get-ADDomain).NetBIOSName
    $principal = "$domainNetbios\$HelpdeskGroup"
} catch {
    # fallback
    $principal = $HelpdeskGroup
}

Write-Host "Using principal: $principal" -ForegroundColor Yellow

# --- Delegations ---
# 1) Reset password (extended right)
& $dsacls $UsersOU /G "$principal:CA;Reset Password"

# 2) Read/Write lockoutTime (unlock account)
# lockoutTime attribute controls account unlock (set to 0)
& $dsacls $UsersOU /G "$principal:RPWP;lockoutTime"

# 3) Read/Write pwdLastSet (force user to change password at next logon by setting pwdLastSet=0)
& $dsacls $UsersOU /G "$principal:RPWP;pwdLastSet"

# (Optional) enable/disable account (userAccountControl) — leave commented unless needed
# & $dsacls $UsersOU /G "$principal:RPWP;userAccountControl"

Write-Host "Delegation applied." -ForegroundColor Green
Write-Host "Next: export evidence with dsacls OU output." -ForegroundColor Cyan



4) Tests (ce que tu dois prouver)

Crée un user test dans OU=Users (ex: user.test1)

Mets-lui un mot de passe + lock le compte (3-5 essais faux)

Connecte-toi avec un compte membre de GG-IT-Helpdesk

Ouvre AD Users and Computers → dans OU=Users :

Reset Password ✅

Unlock account ✅

User must change password at next logon ✅
