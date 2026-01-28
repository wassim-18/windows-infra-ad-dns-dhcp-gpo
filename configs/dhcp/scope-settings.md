\## DHCP Scope Settings (template)



\- Scope Name : \[À REMPLIR]

\- Network    : \[X.X.X.0/24]

\- Range      : \[X.X.X.100] - \[X.X.X.200]

\- Exclusions : \[X.X.X.1] - \[X.X.X.20]



\### Options

\- 003 Router (Gateway) : \[X.X.X.1]

\- 006 DNS Servers      : \[IP DC]

\- 015 DNS Suffix       : \[domaine.local]



\### Notes

\- DHCP server must be authorized in AD (if domain-joined).

\- Reservations imported from: `reservations.sample.csv`



