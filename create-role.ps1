Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false

$cvRole = Read-Host "The name of the role you want to create"
$cvRolePermFile = "vrops_role_ids.txt"

$viserver = Read-Host "Your vCenter hostname or ip address"

$creds = Get-Credential

Connect-VIServer -server $viServer -credential $creds

$cvRoleIds = @()

Get-Content $cvRolePermFile | Foreach-Object{
    $cvRoleIds += $_
}

New-VIRole -name $cvRole -Privilege (Get-VIPrivilege -Server $viserver -id $cvRoleIds) -Server $viserver

Set-VIRole -Role $cvRole -AddPrivilege (Get-VIPrivilege -Server $viserver -id $cvRoleIds) -Server $viserver
