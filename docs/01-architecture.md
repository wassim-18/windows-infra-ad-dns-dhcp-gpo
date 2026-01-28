\# Architecture du lab



\## Machines



| Nom       | OS                  | Rôle                    | IP              |

|-----------|---------------------|--------------------------|-----------------|

| SRV-DC01  | Windows Server 2022 | AD DS / DNS / DHCP / GPO | 192.168.56.10   |

| PC-CL01   | Windows 11          | Client domaine           | DHCP            |



\## Réseau



\- Réseau : 192.168.56.0/24

\- Passerelle : 192.168.56.1

\- DNS : 192.168.56.10

\- DHCP : SRV-DC01



\## Domaine



\- Nom DNS : equitable.local

\- NetBIOS : EQUITABLE



\## Virtualisation



\- Hyperviseur : VirtualBox / VMware / Hyper-V

\- Mode réseau : Host-only / NAT / Bridge



