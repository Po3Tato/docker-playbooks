# Script checks for all users and groups on the server
# along with AD certs and prints out info
# Import required modules
Import-Module ActiveDirectory
Import-Module PKI

# Function to get local administrators
function Get-LocalAdministrators {
    Write-Output "Local Administrators:"
    Get-LocalGroupMember -Group "Administrators" | Format-Table Name
}

# Function to get domain administrators
function Get-DomainAdministrators {
    Write-Output "Domain Admins:"
    Get-ADGroupMember -Identity "Domain Admins" | Format-Table Name
}

# Function to get AD-related certificates
function Get-ADRelatedCertificates {
    $domain = (Get-ADDomain).Name
    Write-Output "AD Related Certificates:"
    Get-ChildItem -Path cert:\LocalMachine\My\ -Recurse | 
        Where-Object { $_.Subject -like "*CN=*.${domain}" } | 
        Format-Table Subject, NotAfter, Thumbprint
}

# Main script
try {
    Get-LocalAdministrators
    Get-DomainAdministrators
    Get-ADRelatedCertificates
} catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
}
