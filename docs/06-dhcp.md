\# DHCP — Configuration



\## Objectif

Fournir automatiquement aux postes clients :

\- Adresse IP

\- Passerelle par défaut

\- Serveur DNS

\- Suffixe DNS



Le service DHCP est centralisé sur le contrôleur de domaine.



---



\## Environnement



\- Serveur DHCP : SRV-DC01

\- Réseau : \[X.X.X.0/24]

\- Domaine : \[domaine.local]



---



\## Étendue



| Paramètre | Valeur |

|-----------|--------|

| Nom | LAN-MAIN |

| Réseau | \[X.X.X.0] |

| Plage | \[X.X.X.100 - X.X.X.200] |

| Exclusions | \[X.X.X.1 - X.X.X.20] |



---



\## Options DHCP



| Option | Description | Valeur |

|--------|-------------|--------|

| 003 | Gateway | \[X.X.X.1] |

| 006 | DNS | \[IP DC] |

| 015 | Suffixe DNS | \[domaine.local] |



---



\## Réservations



Les adresses IP fixes sont gérées via fichier CSV :



configs/dhcp/reservations.sample.csv





Format :



Name,IPAddress,ClientId,Description





---



\## Sécurité



\- Serveur DHCP autorisé dans AD

\- Accès console limité aux admins

\- Logs activés



---



\## Validation



Sur client :



```powershell

ipconfig /release

ipconfig /renew

ipconfig /all

Vérifier :



IP correcte



DNS correct



Gateway valide



Evidence

Export DHCP (scopes, options, réservations)



Logs DHCP





