# ============================================================
# Create-SecurityGroups.ps1
# Description: Creates department Security Groups and adds members
# Domain: lab.local
# Author: Diago Gonzalez
# ============================================================

Import-Module ActiveDirectory

# Create Security Groups
New-ADGroup -Name "IT-Team" -GroupScope Global -GroupCategory Security -Path "OU=IT,DC=lab,DC=local"
New-ADGroup -Name "HR-Team" -GroupScope Global -GroupCategory Security -Path "OU=HR,DC=lab,DC=local"
New-ADGroup -Name "Finance-Team" -GroupScope Global -GroupCategory Security -Path "OU=Finance,DC=lab,DC=local"
New-ADGroup -Name "Management-Team" -GroupScope Global -GroupCategory Security -Path "OU=Management,DC=lab,DC=local"

Write-Host "Security Groups created successfully" -ForegroundColor Green

# Add members to groups
Add-ADGroupMember -Identity "IT-Team" -Members "jsmith","DiGonz"
Add-ADGroupMember -Identity "HR-Team" -Members "Ahernandez","rjohnson"
Add-ADGroupMember -Identity "Finance-Team" -Members "ArielRs","mbrown"
Add-ADGroupMember -Identity "Management-Team" -Members "cbaralt","emartinez"

Write-Host "Members added to all groups successfully" -ForegroundColor Cyan
