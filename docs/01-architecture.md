\# Architecture



\## Machines



| Nom       | OS                  | Rôle                    | IP              |

|-----------|---------------------|--------------------------|-----------------|

| SRV-DC01  | Windows Server      | AD / DNS / DHCP / GPO    | \[IP STATIQUE]   |

| PC-CL01   | Windows Client      | Client domaine           | DHCP            |



\## Réseau



\- Réseau : \[X.X.X.0/24]

\- Passerelle : \[X.X.X.1]

\- DNS : \[IP DC]

\- DHCP : SRV-DC01



\## Domaine



\- Nom DNS : \[exemple.local]

\- NetBIOS : \[EXEMPLE]



\## Virtualisation



\- Plateforme : \[VirtualBox / VMware / Hyper-V]

\- Mode réseau : \[NAT / Bridge / Host-only]



