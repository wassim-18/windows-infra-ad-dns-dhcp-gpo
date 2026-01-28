\# GPO — Baseline Sécurité



\## Objectif

Mettre en place un ensemble de stratégies de groupe (GPO)

afin de renforcer la sécurité des postes et serveurs Windows.



Ces GPO appliquent un standard de durcissement (baseline).



\## Portée

\- Ordinateurs : OU=Computers

\- Utilisateurs : OU=Users

\- Domaine : Politique globale



\## GPO Implémentées



| Nom GPO | Cible | Description |

|---------|-------|-------------|

| GPO-Base-Computer | Computers | Sécurité système |

| GPO-Base-User | Users | Restrictions utilisateur |

| GPO-Password | Domain | Politique mots de passe |

| GPO-Firewall | Computers | Pare-feu Windows |



\## Paramètres Principaux



\### Sécurité Système

\- UAC activé

\- Désactivation SMBv1

\- Désactivation Guest

\- Audit avancé activé

\- Verrouillage session



\### Réseau

\- Pare-feu actif (3 profils)

\- Désactiver LLMNR

\- Désactiver NetBIOS (optionnel)



\### Utilisateur

\- Désactiver panneau config

\- Bloquer CMD/PowerShell (lab)

\- Verrouillage écran auto



\### Mot de passe

\- Longueur minimale : \[X]

\- Complexité : Activée

\- Expiration : \[X jours]



\## Déploiement

Les GPO sont liées aux OU correspondantes

via la console GPMC.



\## Validation



```powershell

gpupdate /force

gpresult /h report.html

✅ 3) Paramètres Sécurité à configurer (dans GPMC)

Après le script, tu configures dans Group Policy Management :

🔐 GPO-Base-Computer

Chemin :

Computer Config → Policies → Windows Settings → Security Settings


Active :

Account Policies

Password length ≥ 12

Complexity ON

Lockout = 5

Local Policies → Security Options

UAC: Enabled

Guest: Disabled

SMBv1: Disabled

Audit Policy

Logon/Logoff : Success/Failure

Object Access : Success

🔥 GPO-Firewall
Computer → Windows Defender Firewall


Domain / Private / Public = ON

Inbound = Block

Outbound = Allow

👤 GPO-Base-User
User → Admin Templates


Disable Control Panel

Disable CMD

Screen lock 10 min

✅ 4) Export automatique (preuves)

Sur le DC :

Get-GPOReport -All -ReportType Html -Path evidence\reports\gpo-baseline.html


Sur client :

gpresult /h evidence\reports\gpresult-client.html




