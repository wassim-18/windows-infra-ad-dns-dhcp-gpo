#requires -RunAsAdministrator
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Import-Module GroupPolicy

# =========================
# EDIT ME
# =========================
$DomainDN  = "DC=example,DC=local"   # <-- A REMPLIR
$CompanyOU = "Company"              # <-- A REMPLIR
# =========================

$ComputersOU = "OU=Computers,OU=$CompanyOU,$DomainDN"
$UsersOU     = "OU=Users,OU=$CompanyOU,$DomainDN"

# GPO Names
$GPOs = @{
    "GPO-Base-Computer" = $ComputersOU
    "GPO-Base-User"     = $UsersOU
    "GPO-Firewall"      = $ComputersOU
}

function Ensure-GPO {
    param(
        [string]$Name,
        [string]$LinkTarget
    )

    $gpo = Get-GPO -Name $Name -ErrorAction SilentlyContinue
    if (-not $gpo) {
        $gpo = New-GPO -Name $Name
        Write-Host "Created GPO: $Name" -ForegroundColor Green
    } else {
        Write-Host "GPO exists: $Name" -ForegroundColor Yellow
    }

    # Link GPO
    $link = Get-GPLink -Target $LinkTarget -ErrorAction SilentlyContinue
    if (-not ($link | Where-Object { $_.DisplayName -eq $Name })) {
        New-GPLink -Name $Name -Target $LinkTarget -LinkEnabled Yes
        Write-Host "Linked $Name to $LinkTarget" -ForegroundColor Green
    }
}

# Create & link
foreach ($gpo in $GPOs.GetEnumerator()) {
    Ensure-GPO -Name $gpo.Key -LinkTarget $gpo.Value
}

Write-Host "GPO baseline structure created." -ForegroundColor Cyan
Write-Host "Next: configure security settings manually or via backup import." -ForegroundColor Yellow
