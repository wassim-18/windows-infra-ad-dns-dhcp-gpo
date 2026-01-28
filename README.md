# Windows Enterprise Infrastructure Lab  
**Active Directory | DNS | DHCP | GPO | Security Baseline | RBAC**

---

## 📌 Présentation

Ce projet présente la conception, le déploiement et la sécurisation
d’une infrastructure Windows type entreprise.

Il a été réalisé dans un contexte académique et professionnel
afin de démontrer mes compétences en administration systèmes,
réseaux et cybersécurité.

---

## 🎯 Objectifs

- Concevoir un domaine Active Directory structuré
- Implémenter une gestion des accès (RBAC)
- Mettre en place DNS & DHCP centralisés
- Appliquer un durcissement via GPO
- Automatiser avec PowerShell
- Produire des preuves techniques

---

## 🏗️ Architecture

| Composant | Description |
|-----------|-------------|
| Domaine | [À REMPLIR] |
| DC | Windows Server 2022 |
| Clients | Windows 10/11 |
| Réseau | [À REMPLIR] |
| Hyperviseur | [À REMPLIR] |

> Voir : `docs/01-architecture.md`

---

## ⚙️ Technologies

- Windows Server 2022
- Active Directory (AD DS)
- DNS / DHCP
- Group Policy Management
- PowerShell
- GPMC / RSAT
- VirtualBox / VMware / Hyper-V

---

## 🔐 Sécurité & Gouvernance

- RBAC (Helpdesk / Admin / Users)
- Délégation contrôlée
- GPO Baseline
- Pare-feu Windows
- Politique mots de passe
- Audit & logs

---

## 🤖 Automatisation

Scripts PowerShell pour :

- Installation des rôles
- Création OU / groupes / users
- Délégation RBAC
- Configuration DHCP
- Export rapports

Dossier : `scripts/powershell/`

---

## 📂 Structure du projet

docs/ → Documentation technique
scripts/ → Automatisation PowerShell
configs/ → Fichiers de configuration
evidence/ → Rapports et preuves


---

## ✅ Validation & Evidence

- dcdiag / repadmin
- gpresult
- Rapports GPO
- Exports DHCP
- Logs système

Dossier : `evidence/`

---

## 💼 Compétences démontrées

✔️ Administration Windows Server  
✔️ Gestion Active Directory  
✔️ Sécurisation système  
✔️ RBAC & délégation  
✔️ Automatisation  
✔️ Documentation technique  
✔️ Méthodologie IT professionnelle  

---

## 📈 Évolutions prévues

- LAPS
- Defender for Endpoint
- MFA / Entra ID
- Hybrid AD
- WSUS

---

## ▶️ How to Use — Guide d’installation

Cette section explique comment déployer l’infrastructure
à partir de ce dépôt.

---

### 1️⃣ Préparer le serveur

Sur Windows Server :

- Installer Windows Server 2022
- Configurer une IP statique
- Renommer le serveur (ex: SRV-DC01)
- Redémarrer

Configurer DNS primaire = IP du serveur.

---

### 2️⃣ Cloner le projet

Installer Git (si nécessaire), puis :

```powershell
git clone https://github.com/wassim-18/-windows-infra-ad-dns-dhcp-gpo.git
cd windows-infra-ad-dns-dhcp-gpo

3️⃣ Autoriser temporairement les scripts
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

4️⃣ Adapter les variables

Avant d’exécuter les scripts, modifier les fichiers :

02-create-ous-groups.ps1

03-dns-records.ps1

04-dhcp-scope.ps1

06-create-users-and-rbac.ps1

07-delegation-helpdesk.ps1

08-delegation-join-domain.ps1

09-gpo-baseline.ps1

10-dhcp-advanced.ps1

Et remplacer :

DC=example,DC=local
example.local
192.168.X.X
Company


Par les valeurs réelles.

5️⃣ Exécuter les scripts (dans l’ordre)

Ouvrir PowerShell en Administrateur :

cd scripts\powershell


Puis :

.\01-install-roles.ps1
# Reboot si demandé

.\02-create-ous-groups.ps1
.\03-dns-records.ps1
.\04-dhcp-scope.ps1
.\06-create-users-and-rbac.ps1
.\07-delegation-helpdesk.ps1
.\08-delegation-join-domain.ps1
.\09-gpo-baseline.ps1
.\10-dhcp-advanced.ps1
.\05-export-reports.ps1

6️⃣ Validation

Sur serveur :

dcdiag
repadmin /replsummary


Sur client :

gpupdate /force
gpresult /h report.html
ipconfig /all

7️⃣ Evidence

Les rapports sont générés dans :

evidence/reports/



## 👤 Auteur

**Wassim Ben Younes**  
Étudiant — Infrastructure informatique & cybersécurité (AEC, Québec)  

🔗 GitHub : https://github.com/wassim-18  


---

## 📜 Licence

Projet éducatif — Usage démonstratif

)



