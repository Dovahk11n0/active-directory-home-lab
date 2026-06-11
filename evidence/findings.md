# Evidence — Active Directory Home Lab

## Lab Summary

| Field | Value |
|---|---|
| Domain | lab.local |
| Domain Controller | DC01 — 192.168.1.10 |
| Client Machine | CLIENT01 — 192.168.1.100 |
| Network | VirtualBox Internal Network (AD-Lab) |
| Total Users Created | 8 |
| Total OUs Created | 4 |
| Total Groups Created | 4 |

## Scenario 7 — Account Lockout Triage

### Incident Details

| Field | Value |
|---|---|
| Affected User | Diago Gonzalez (DiGonz) |
| Account Status | Locked Out |
| Failed Attempts | 5 |
| Lockout Threshold | 5 invalid attempts |
| Last Bad Password | 6/11/2026 |
| Resolved By | Unlock-ADAccount |

### Triage Steps

| Step | Command | Result |
|---|---|---|
| 1. Identify lockout | Search-ADAccount -LockedOut | DiGonz — LockedOut: True |
| 2. Confirm status | Get-ADUser -Identity "DiGonz" -Properties LockedOut | LockedOut: True |
| 3. Unlock account | Unlock-ADAccount -Identity "DiGonz" | Success |
| 4. Verify resolution | Search-ADAccount -LockedOut | Empty — no locked accounts |

### Analyst Disposition

True Positive — Account lockout triggered by 5 consecutive failed login attempts.
Resolved by Help Desk administrator using Unlock-ADAccount.
User advised to use correct credentials and contact Help Desk if issue persists.

## Group Policy Verification

| Setting | Configured Value | Location |
|---|---|---|
| Lockout threshold | 5 attempts | Default Domain Policy |
| Lockout duration | 30 minutes | Default Domain Policy |
| Reset lockout counter | 30 minutes | Default Domain Policy |
| Minimum password length | 12 characters | Default Domain Policy |
| Password complexity | Enabled | Default Domain Policy |
|
