\# Délégation Helpdesk (RBAC)



\## Objectif

Déléguer au groupe Helpdesk la capacité de :

\- Réinitialiser les mots de passe

\- Déverrouiller les comptes

\- Forcer “User must change password at next logon”

sur une OU dédiée (Users), sans privilèges admin.



\## Prérequis

\- Groupe AD : `GG-IT-Helpdesk`

\- OU cible : `OU=Users,OU=\[Company],DC=\[...],DC=\[...]`



\## Étapes (résumé)

1\. Créer/valider l’OU `Users`

2\. Appliquer la délégation via `dsacls`

3\. Tester avec un compte Helpdesk (non-admin)

4\. Déposer les preuves dans `evidence/reports/`



\## Commandes de validation

\- Vérifier permissions (extrait) :

&nbsp; ```powershell

&nbsp; dsacls "\[OU\_USERS\_DN]"



Test fonctionnel :



Se connecter sur une machine avec un compte Helpdesk



Ouvrir Active Directory Users and Computers



Tenter reset password / unlock sur un user dans l’OU Users



Evidence à fournir



Capture ADUC montrant le reset password réussi



Export dsacls :



evidence/reports/dsacls-users-ou.txt

