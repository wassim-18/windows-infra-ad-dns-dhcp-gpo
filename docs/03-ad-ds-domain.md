\# Installation Active Directory (AD DS)



\## Prérequis



\- IP statique configurée

\- Nom du serveur défini

\- Accès administrateur local



\## Étapes



\### 1. Installation du rôle



```powershell

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools







2\. Promotion en contrôleur de domaine

Nouveau domaine : \[Nom domaine]



Forêt : \[Nom domaine]



Niveau fonctionnel : \[Version]



Mot de passe DSRM : \[Sécurisé]



3\. Vérification

dcdiag

Get-ADDomain

Résultat attendu

Domaine fonctionnel



DNS intégré



SYSVOL partagé

