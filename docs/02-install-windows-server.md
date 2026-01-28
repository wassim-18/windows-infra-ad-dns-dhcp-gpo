\# Installation Windows Server (template)



\## Objectif

Installer et préparer Windows Server pour héberger AD DS / DNS / DHCP.



\## Pré-requis

\- ISO Windows Server : \[À REMPLIR]

\- VM/Physique : \[À REMPLIR]

\- Ressources : 2 vCPU / 4-8GB RAM / 40GB+



\## Étapes

1\. Installer Windows Server

2\. Définir nom machine : `SRV-DC01` (exemple)

3\. Configurer IP statique :

&nbsp;  - IP : \[À REMPLIR]

&nbsp;  - Mask : \[À REMPLIR]

&nbsp;  - GW : \[À REMPLIR]

&nbsp;  - DNS : (lui-même) \[IP DC]

4\. Activer RDP (optionnel)

5\. Mettre à jour Windows (Windows Update)

6\. Installer rôles (script PowerShell) :

&nbsp;  - `scripts/powershell/01-install-roles.ps1`



\## Validation

\- `winver`

\- `ipconfig /all`

\- Accès réseau OK



