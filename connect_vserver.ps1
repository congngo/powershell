#Connect-VIServer esxi2 -User root
$vserver = "esxi2"
$user_name = "root"
$PASSWORD = "test"
$global:DefaultVIServers.count
If (-NOT ($global:DefaultVIServers)) {
    Write-Host "not connected. Exit Now"
    exit
    } Else {
    Write-Host "is connected"
}

Foreach( $vc in $global:DefaultVIServers ) {
   #Get-VM -Server $vc
   Write-Host "single $vc"
}
Write-Host "very usefull variable Get-Variable, Remove-Variable DefaultVIServer"
#Get-VM | 
#      Sort-Object -Property Name |
#      Get-View -Property @("Name", "Config.GuestFullName", "Guest.GuestFullName") |
#      Select-Object -Property Name, @{N="Configured OS";E={$_.Config.GuestFullName}}, @{N="Running OS";E={$_.Guest.GuestFullName}}
#Disconnect-VIServer $vcenter -force -Confirm:$false -WarningAction SilentlyContinue -ErrorAction SilentlyContinue | Out-Null
#try {
 #   Connect-VIServer -Server $vserver -User user_name -Password PASSWORD -ErrorAction SilentlyContinue
#}
#catch {
#  $Error[0]
#  }
$vm_name = "rhel-temp3"
$vm_item = "Get-HardDisk"
#$vm_item = "Get-HardDisk | Format-List"
$a = "Get-VM $vm_name"
iex $a
Invoke-Expression "$a | $vm_item"