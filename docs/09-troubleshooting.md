\# Troubleshooting — Dépannage



Ce document regroupe les problèmes rencontrés et leurs solutions.



---



\## Active Directory



\### Impossible de joindre le domaine

Cause :

\- DNS client incorrect



Solution :

\- Vérifier DNS = IP du DC

```powershell

ipconfig /all

DNS

Résolution impossible

Cause :



Zone manquante



Enregistrement absent



Pare-feu bloquant



Solution :



nslookup srv-dc01

Restart-Service DNS

DHCP

Pas d’adresse IP

Cause :



Scope désactivé



DHCP non autorisé



Pare-feu



Solution :



Get-DhcpServerv4Scope

Get-DhcpServerInDC

GPO

GPO non appliquée

Cause :



Mauvais lien OU



Héritage bloqué



Réplication



Solution :



gpupdate /force

gpresult /r

Général

Problème réseau

ping 8.8.8.8

ping srv-dc01

Logs utiles

Event Viewer



DHCP Logs : C:\\Windows\\System32\\dhcp\\



Security Logs

