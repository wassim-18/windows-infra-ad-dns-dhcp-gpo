\# DHCP — Configuration Avancée



\## Objectif

Mettre en place un service DHCP centralisé, sécurisé et documenté :

\- Étendues standardisées

\- Options réseau cohérentes

\- Réservations automatisées

\- Journalisation

\- Validation



\## Portée

\- Serveur : SRV-DC01

\- Réseau principal : \[X.X.X.0/24]



\## Étendue



| Paramètre | Valeur |

|-----------|---------|

| Nom | LAN-MAIN |

| Réseau | \[X.X.X.0] |

| Masque | 255.255.255.0 |

| Plage | \[X.X.X.100 - X.X.X.200] |

| Exclusions | \[X.X.X.1 - X.X.X.20] |



\## Options DHCP



| Option | Description | Valeur |

|--------|-------------|--------|

| 003 | Router | \[Gateway] |

| 006 | DNS | \[IP DC] |

| 015 | DNS Suffix | \[Domaine] |



\## Réservations

Importées depuis CSV (MAC → IP).



\## Sécurité

\- Autorisation AD du serveur DHCP

\- Limitation accès console

\- Logs activés



\## Validation

\- Attribution IP dynamique

\- Options correctes

\- Logs vérifiés



\## Evidence

\- Export config DHCP

\- Captures console

\- Logs







✅ 4) Activer \& vérifier les logs DHCP



Sur le DC :



Get-DhcpServerAuditLog





Logs ici :



C:\\Windows\\System32\\dhcp\\DhcpSrvLog-\*.log





Copie 1 log → evidence/logs/



✅ 5) Tests à faire



Sur un client :



ipconfig /release

ipconfig /renew

ipconfig /all

