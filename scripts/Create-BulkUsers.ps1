# ============================================================
# Create-BulkUsers.ps1
# Description: Bulk user creation for Active Directory lab
# Domain: lab.local
# Author: Diago Gonzalez
# ============================================================

Import-Module ActiveDirectory

$users = @(
    @{FullName="John Smith"; Username="jsmith"; Department="IT"},
    @{FullName="Diago Gonzalez"; Username="DiGonz"; Department="IT"},
    @{FullName="Amy Hernandez"; Username="Ahernandez"; Department="HR"},
    @{FullName="Robert Johnson"; Username="rjohnson"; Department="HR"},
    @{FullName="Ariel Rodriguez"; Username="ArielRs"; Department="Finance"},
    @{FullName="Michael Brown"; Username="mbrown"; Department="Finance"},
    @{FullName="Carla Baralt"; Username="cbaralt"; Department="Management"},
    @{FullName="Emily Martinez"; Username="emartinez"; Department="Management"}
)

$password = ConvertTo-SecureString "Welcome1234!" -AsPlainText -Force

foreach ($user in $users) {
    New-ADUser -Name $user.FullName -SamAccountName $user.Username -UserPrincipalName "$($user.Username)@lab.local" -Path "OU=$($user.Department),DC=lab,DC=local" -AccountPassword $password -Enabled $true -PasswordNeverExpires $false -ChangePasswordAtLogon $true
    Write-Host "Created: $($user.FullName) in OU=$($user.Department)" -ForegroundColor Green
}

Write-Host "All users created successfully" -ForegroundColor Cyan
