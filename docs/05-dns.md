\# DNS (template)



\## Objectif

Configurer DNS pour :

\- résolution interne du domaine

\- zone directe + inverse

\- enregistrements A/PTR



\## Configuration

\- DNS sur : SRV-DC01

\- Zone : \[domaine.local]

\- Reverse zone : \[X.X.X].in-addr.arpa



\## Commandes utiles

```powershell

Get-DnsServerZone

Get-DnsServerResourceRecord -ZoneName "\[domaine.local]"

nslookup srv-dc01



