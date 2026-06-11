# ============================================================
# Manage-AccountLockout.ps1
# Description: Help Desk triage script for account lockouts
# Domain: lab.local
# Author: Diago Gonzalez
# ============================================================

Import-Module ActiveDirectory

# Find all locked out accounts
Write-Host "=== Checking for locked out accounts ===" -ForegroundColor Yellow
Search-ADAccount -LockedOut | Select-Object Name, SamAccountName, LockedOut

# Check specific user status
Write-Host "=== Checking DiGonz account status ===" -ForegroundColor Yellow
Get-ADUser -Identity "DiGonz" -Properties LockedOut,BadLogonCount,LastBadPasswordAttempt | Select-Object Name,LockedOut,BadLogonCount,LastBadPasswordAttempt

# Unlock specific account
Write-Host "=== Unlocking DiGonz account ===" -ForegroundColor Yellow
Unlock-ADAccount -Identity "DiGonz"
Write-Host "Account unlocked successfully" -ForegroundColor Green

# Verify unlock
Write-Host "=== Verifying unlock ===" -ForegroundColor Yellow
Search-ADAccount -LockedOut | Select-Object Name, SamAccountName, LockedOut
Write-Host "If no accounts appear above, all accounts are unlocked" -ForegroundColor Cyan
