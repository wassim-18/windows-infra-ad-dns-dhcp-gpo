#requires -RunAsAdministrator
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Import-Module ActiveDirectory

# =========================
# EDIT ME (placeholders)
# =========================
$DomainDN   = "DC=example,DC=local"     # <-- A REMPLIR
$CompanyOU  = "Company"                # <-- A REMPLIR (ex: Equitable)
$DefaultUPN = "example.local"          # <-- A REMPLIR (UPN suffix)
# =========================

$BaseOU = "OU=$CompanyOU,$DomainDN"

function Ensure-OU {
    param(
        [Parameter(Mandatory)] [string] $Name,
        [Parameter(Mandatory)] [string] $Path
    )
    $dn = "OU=$Name,$Path"
    $exists = Get-ADOrganizationalUnit -LDAPFilter "(distinguishedName=$dn)" -ErrorAction SilentlyContinue
    if (-not $exists) {
        New-ADOrganizationalUnit -Name $Name -Path $Path -ProtectedFromAccidentalDeletion $true | Out-Null
        Write-Host "Created OU: $dn" -ForegroundColor Green
    } else {
        Write-Host "OU exists: $dn" -ForegroundColor Yellow
    }
    return $dn
}

function Ensure-Group {
    param(
        [Parameter(Mandatory)] [string] $Name,
        [Parameter(Mandatory)] [string] $Path
    )
    $g = Get-ADGroup -Filter "Name -eq '$Name'" -ErrorAction SilentlyContinue
    if (-not $g) {
        New-ADGroup -Name $Name -GroupScope Global -GroupCategory Security -Path $Path | Out-Null
        Write-Host "Created group: $Name" -ForegroundColor Green
    } else {
        Write-Host "Group exists: $Name" -ForegroundColor Yellow
    }
}

function Ensure-User {
    param(
        [Parameter(Mandatory)] [string] $Sam,
        [Parameter(Mandatory)] [string] $GivenName,
        [Parameter(Mandatory)] [string] $Surname,
        [Parameter(Mandatory)] [string] $Path,
        [Parameter(Mandatory)] [securestring] $Password
    )

    $u = Get-ADUser -Filter "SamAccountName -eq '$Sam'" -ErrorAction SilentlyContinue
    if (-not $u) {
        $upn = "$Sam@$DefaultUPN"
        New-ADUser `
            -SamAccountName $Sam `
            -UserPrincipalName $upn `
            -GivenName $GivenName `
            -Surname $Surname `
            -Name "$GivenName $Surname" `
            -DisplayName "$GivenName $Surname" `
            -Path $Path `
            -Enabled $true `
            -ChangePasswordAtLogon $true `
            -AccountPassword $Password | Out-Null

        Write-Host "Created user: $Sam ($upn)" -ForegroundColor Green
    } else {
        Write-Host "User exists: $Sam" -ForegroundColor Yellow
    }
}

Write-Host "=== Creating OU baseline ===" -ForegroundColor Cyan

# Create root Company OU
$companyDn = "OU=$CompanyOU,$DomainDN"
if (-not (Get-ADOrganizationalUnit -LDAPFilter "(distinguishedName=$companyDn)" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name $CompanyOU -Path $DomainDN -ProtectedFromAccidentalDeletion $true | Out-Null
    Write-Host "Created OU: $companyDn" -ForegroundColor Green
} else {
    Write-Host "OU exists: $companyDn" -ForegroundColor Yellow
}

# Sub OUs
$UsersOU      = Ensure-OU -Name "Users"      -Path $BaseOU
$ComputersOU  = Ensure-OU -Name "Computers"  -Path $BaseOU
$ServersOU    = Ensure-OU -Name "Servers"    -Path $BaseOU
$GroupsOU     = Ensure-OU -Name "Groups"     -Path $BaseOU
$AdminsOU     = Ensure-OU -Name "Admins"     -Path $BaseOU

$StaffOU      = Ensure-OU -Name "Staff"      -Path $UsersOU
$ITOU         = Ensure-OU -Name "IT"         -Path $UsersOU
$Workstations = Ensure-OU -Name "Workstations" -Path $ComputersOU
$MemberServers= Ensure-OU -Name "MemberServers" -Path $ServersOU

Write-Host "=== Creating groups (RBAC) ===" -ForegroundColor Cyan

# Groups
$GroupsGlobalOU = Ensure-OU -Name "Global" -Path $GroupsOU

$RBACGroups = @(
    "GG-IT-Helpdesk",
    "GG-IT-Admins",
    "GG-Users-Standard"
)

foreach ($g in $RBACGroups) {
    Ensure-Group -Name $g -Path $GroupsGlobalOU
}

Write-Host "=== Creating sample lab users ===" -ForegroundColor Cyan

# Password template (à changer en prod)
$pwd = ConvertTo-SecureString "P@ssw0rd-ChangeMe!" -AsPlainText -Force

# Sample users (placeholders)
$Users = @(
    @{Sam="it.admin1";   Given="IT";     Surname="Admin1";   OU=$ITOU;   Groups=@("GG-IT-Admins")},
    @{Sam="it.help1";    Given="IT";     Surname="Helpdesk1";OU=$ITOU;   Groups=@("GG-IT-Helpdesk")},
    @{Sam="user.staff1"; Given="User";   Surname="Staff1";   OU=$StaffOU;Groups=@("GG-Users-Standard")}
)

foreach ($u in $Users) {
    Ensure-User -Sam $u.Sam -GivenName $u.Given -Surname $u.Surname -Path $u.OU -Password $pwd
    foreach ($g in $u.Groups) {
        Add-ADGroupMember -Identity $g -Members $u.Sam -ErrorAction SilentlyContinue
    }
}

Write-Host "=== Done. Next: delegation (optional) ===" -ForegroundColor Green
Write-Host "Tip: Export proof with: Get-ADOrganizationalUnit -Filter * | Select Name,DistinguishedName" -ForegroundColor Yellow
