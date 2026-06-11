---
title: Active Directory Home Lab
stack:
  - Windows Server 2022
  - Windows 10 Pro
  - Active Directory Domain Services
  - DNS Server
  - Group Policy Management
  - PowerShell
difficulty: beginner-intermediate
estimated_time: 8-10 hours
status: complete
focus:
  - Active Directory administration
  - User and group management
  - Group Policy configuration
  - Account lifecycle management
  - Help Desk triage workflows
---

## Lab Scenarios

### Scenario 1 — Domain Controller Setup
Installed Windows Server 2022, configured static IP, renamed server to DC01, installed AD DS and DNS roles, and promoted the server to Domain Controller for the lab.local domain.

### Scenario 2 — Organizational Unit Structure
Created four OUs representing company departments using Active Directory Users and Computers:
- IT
- HR
- Finance
- Management

### Scenario 3 — Bulk User Provisioning with PowerShell
Created 8 domain users across all departments using a PowerShell script. Each user was assigned to their department OU with a temporary password and forced password change at first logon — replicating real employee onboarding workflow.

### Scenario 4 — Security Groups
Created department Security Groups (IT-Team, HR-Team, Finance-Team, Management-Team) and added users to their respective groups using PowerShell. Demonstrated how group membership controls resource access in enterprise environments.

### Scenario 5 — Group Policy Configuration
Configured Password Policy and Account Lockout Policy via Default Domain Policy:

**Password Policy:**
| Setting | Value |
|---|---|
| Enforce password history | 10 passwords |
| Maximum password age | 90 days |
| Minimum password age | 1 day |
| Minimum password length | 12 characters |
| Password complexity | Enabled |
| Reversible encryption | Disabled |

**Account Lockout Policy:**
| Setting | Value |
|---|---|
| Lockout threshold | 3 invalid attempts |
| Lockout duration | 30 minutes |
| Reset lockout counter | 30 minutes |

### Scenario 6 — Domain Join
Configured CLIENT01 with static IP and DNS pointing to DC01, then joined the machine to lab.local. Verified domain membership using `whoami` and `%logonserver%` commands.

### Scenario 7 — Account Lockout Triage
Simulated a Help Desk ticket: user DiGonz triggered account lockout after 3 failed login attempts. Investigated using PowerShell, confirmed lockout, and resolved using `Unlock-ADAccount` — replicating the most common Help Desk workflow in AD environments.

## Detection and Triage Commands

```powershell
# Find all locked out accounts
Search-ADAccount -LockedOut | Select-Object Name, SamAccountName, LockedOut

# Check specific user status
Get-ADUser -Identity "DiGonz" -Properties LockedOut, BadLogonCount, LastBadPasswordAttempt | Select-Object Name, LockedOut, BadLogonCount, LastBadPasswordAttempt

# Unlock account
Unlock-ADAccount -Identity "DiGonz"

# Verify unlock
Search-ADAccount -LockedOut | Select-Object Name, SamAccountName, LockedOut

# Force Group Policy update
gpupdate /force

# Verify domain membership
whoami
echo %logonserver%
```

## Evidence

| Screenshot | Description |
|---|---|
| 01-server-manager-dashboard.png | Windows Server 2022 installed and running |
| 02-static-ip-config.png | DC01 static IP configuration |
| 03-bulk-users-created.png | PowerShell bulk user creation output |
| 04-groups-and-members.png | IT-Team group members in AD |
| 05-password-policy.png | Password Policy GPO settings |
| 06-lockout-policy.png | Account Lockout Policy GPO settings |
| 07-domain-verification.png | whoami and logonserver confirmation |
| 08-account-lockout-triggered.png | Lockout message on CLIENT01 |
| 09-lockout-confirmed-ad.png | Search-ADAccount showing LockedOut: True |
| 10-account-unlocked.png | Account successfully unlocked |

## Help Desk Workflow Demonstrated

User calls: "I can't log into my account"  
→ Run: Search-ADAccount -LockedOut  
→ Find: DiGonz — LockedOut: True  
→ Run: Unlock-ADAccount -Identity "DiGonz"  
→ Verify: Search-ADAccount -LockedOut → empty list  
→ Ticket resolved
