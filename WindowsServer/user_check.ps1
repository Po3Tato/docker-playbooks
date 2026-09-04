# Script checks for all users and groups on the server
# along with AD certs and prints out info
Import-Module ActiveDirectory
Import-Module PKI

# Get members of the 'Administrators' group on the local computer
$localAdmins = Get-LocalGroupMember -Group "Administrators" | Select-Object -ExpandProperty Name
Write-Output "Local Administrators: $localAdmins"

# Get members of 'Domain Admins' group in AD
$domainAdmins = Get-ADGroupMember -Identity "Domain Admins" | Select-Object -ExpandProperty Name
Write-Output "Domain Admins: $domainAdmins"

# List AD-related certificates in the local machine store
$certs = Get-ChildItem -Path cert:\LocalMachine\My\ -Recurse | Where-Object {
    $_.Subject -like "*CN=*.yourdomain.com" # Replace 'yourdomain.com'
}
foreach ($cert in $certs) {
    Write-Output "AD Related Certificate: $($cert.Subject)"
}
