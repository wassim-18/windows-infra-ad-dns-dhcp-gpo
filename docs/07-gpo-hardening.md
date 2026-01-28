\# GPO — Durcissement



\## Objectifs



\- Sécuriser les postes clients

\- Appliquer les politiques mots de passe

\- Restreindre l’accès utilisateur

\- Renforcer les paramètres système



\## GPO Implémentées



| Nom GPO              | Cible        | Description              |

|----------------------|-------------|--------------------------|

| Baseline-Computer    | Computers   | Sécurité système         |

| Baseline-User        | Users       | Restrictions utilisateur|

| Password-Policy      | Domain      | Politique mots de passe  |



\## Paramètres clés



\- Complexité mot de passe : Activée

\- Longueur minimale : \[X]

\- Verrouillage : \[X tentatives]

\- Pare-feu : Activé

\- Windows Update : Auto



\## Validation



```powershell

gpresult /h result.html



