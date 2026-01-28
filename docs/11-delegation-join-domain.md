\# Délégation — Join Computers to Domain



\## Objectif

Autoriser le groupe Helpdesk à :

\- Joindre des ordinateurs au domaine

\- Créer des comptes ordinateur dans l’OU Computers



Sans droits administrateur complets.



\## Prérequis

\- Groupe : GG-IT-Helpdesk

\- OU cible : OU=Computers,OU=\[Company],DC=\[...],DC=\[...]



\## Principe

Pour joindre un PC au domaine, un utilisateur doit pouvoir :

\- Créer des objets computer

\- Modifier certains attributs machine



La délégation se fait via dsacls.



\## Étapes

1\. Appliquer la délégation via script PowerShell

2\. Tester depuis un poste client

3\. Exporter les permissions (preuve)



\## Validation

Depuis un compte Helpdesk :



\- Paramètres système

\- Nom du PC → Domaine

\- Entrer identifiants Helpdesk

\- Vérifier création du compte dans AD



\## Evidence

\- Capture join domain réussi

\- Export dsacls :

&nbsp; evidence/reports/dsacls-computers-ou.txt







✅ 3) Export preuve



Sur le DC :



dsacls "OU=Computers,OU=\[Company],DC=\[...],DC=\[...]" > evidence\\reports\\dsacls-computers-ou.txt





(Remplace DN.)



✅ 4) Test réel (important pour ton portfolio)



Depuis un PC client :



Avec compte Helpdesk



Paramètres système



Renommer ce PC (facultatif)



Joindre domaine



Identifiants Helpdesk



Redémarrer



➡️ Vérifie dans AD : ordinateur créé dans OU=Computers.



📸 Capture écran → evidence/screenshots/

