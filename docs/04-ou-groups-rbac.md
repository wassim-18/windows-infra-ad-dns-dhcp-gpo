\# Modèle AD — OU, Groupes, RBAC



\## Objectif

Structurer Active Directory de manière “entreprise” :

\- OUs claires (Users, Computers, Servers…)

\- Groupes Security (RBAC)

\- Délégation (Helpdesk, IT Admins, etc.)



---



\## 1) Arborescence OU (à adapter)



\[DC=...,DC=...]

└── OU=Company

├── OU=Users

│ ├── OU=Staff

│ ├── OU=IT

│ └── OU=VIP

├── OU=Groups

│ ├── OU=Global

│ └── OU=Local

├── OU=Computers

│ ├── OU=Workstations

│ └── OU=Laptops

├── OU=Servers

│ ├── OU=MemberServers

│ └── OU=DomainControllers

└── OU=Admins





> Remplir :

\- Company OU : \[À REMPLIR]

\- Domaine DN : \[À REMPLIR] (ex: DC=equitable,DC=local)



---



\## 2) Conventions de nommage



\### Utilisateurs

\- Prénom Nom : `firstname.lastname` (ou `f.lastname`)

\- Exemples : `wassim.ben-younes`, `s.support`



\### Groupes (recommandé)

\- Globaux (GG\_) : appartenance “qui”

\- Locaux domaine (DL\_) : “sur quoi” (ressource)



Exemples :

\- `GG-IT-Helpdesk`

\- `GG-IT-Admins`

\- `GG-Users-Standard`

\- `DL-Share-Finance-RW` (si tu ajoutes plus tard des partages)



---



\## 3) RBAC (exemples)

| Rôle | Groupe | Droits |

|------|--------|--------|

| Helpdesk | GG-IT-Helpdesk | reset password, unlock user, join computers |

| IT Admin | GG-IT-Admins | admin système (selon politique) |

| Utilisateurs | GG-Users-Standard | accès standard |



---



\## 4) Délégations (à documenter)

À faire (selon besoin) :

\- Délégation Helpdesk sur `OU=Users` :

&nbsp; - Reset Password

&nbsp; - Read/Write account restrictions

&nbsp; - Unlock account

\- Délégation sur `OU=Computers` :

&nbsp; - Join computers to domain



---



\## 5) Preuves (Evidence)

À déposer dans `evidence/` :

\- Captures de l’arborescence OU

\- Exports (optionnel)

\- `Get-ADOrganizationalUnit` / `Get-ADGroup` outputs



