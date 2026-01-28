#requires -RunAsAdministrator
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Import-Module ActiveDirectory

# ===== EDIT ME =====
$DomainDN  = "DC=example,DC=local"
$CompanyOU = "Company"
# ===================

$BaseOU = "OU=$CompanyOU,$DomainDN"

function Ensure-OU([string]$Name, [string]$Path) {
  $dn = "OU=$Name,$Path"
  if (-not (Get-ADOrganizationalUnit -LDAPFilter "(distinguishedName=$dn)" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name $Name -Path $Path -ProtectedFromAccidentalDeletion $true | Out-Null
    Write-Host "Created OU: $dn" -ForegroundColor Green
  } else { Write-Host "OU exists: $dn" -ForegroundColor Yellow }
}

function Ensure-Group([string]$Name, [string]$Path) {
  if (-not (Get-ADGroup -Filter "Name -eq '$Name'" -ErrorAction SilentlyContinue)) {
    New-ADGroup -Name $Name -GroupScope Global -GroupCategory Security -Path $Path | Out-Null
    Write-Host "Created group: $Name" -ForegroundColor Green
  } else { Write-Host "Group exists: $Name" -ForegroundColor Yellow }
}

# Root OU
if (-not (Get-ADOrganizationalUnit -LDAPFilter "(distinguishedName=OU=$CompanyOU,$DomainDN)" -ErrorAction SilentlyContinue)) {
  New-ADOrganizationalUnit -Name $CompanyOU -Path $DomainDN -ProtectedFromAccidentalDeletion $true | Out-Null
}

Ensure-OU "Users"     $BaseOU
Ensure-OU "Computers" $BaseOU
Ensure-OU "Servers"   $BaseOU
Ensure-OU "Groups"    $BaseOU
Ensure-OU "Admins"    $BaseOU

$GroupsOU = "OU=Groups,$BaseOU"
Ensure-Group "GG-IT-Helpdesk" $GroupsOU
Ensure-Group "GG-IT-Admins"   $GroupsOU
Ensure-Group "GG-Users-Standard" $GroupsOU

Write-Host "OU + groups baseline done." -ForegroundColor Cyan
