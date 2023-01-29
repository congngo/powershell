<#
.NOTES 
    Purpose  : VMware_vSphere_7.x_VM_STIG_Remediation
    Author     : Cong Ngo
    Version    : 1.0

for one host
$host_name = @(
    "host1"
)

for two hosts
$host_name = @(
    "host1",
    "host2"      <--- no comma
)

#>

# ----------modified host here-----------
$host_name = @(
    "rhel-temp2",
    "rhel-temp3"
)
$vm_setting = @{
    "isolation.tools.copy.disable" = $true
    "isolation.tools.dnd.disable" = $true
    "isolation.tools.paste.disable" = $true
    "isolation.tools.diskShrink.disable" = $true
    "isolation.tools.diskWiper.disable" = $true
    "isolation.tools.hgfsServerSet.disable" = $true
    "RemoteDisplay.maxConnections" = "1"
    "RemoteDisplay.vnc.enabled" = $false
    "tools.setinfo.sizeLimit" = "1048576"
    "isolation.device.connectable.disable" = $true
    "tools.guestlib.enableHostInfo" = $false
    # Windows
    #"tools.guest.desktop.autolock" = $true              
}
$manual_check = @(
    "Get-CDDrive | Where {`$_.extensiondata.connectable.connected -eq `$true } | Select Parent,Name",
    "Where {`$_.ExtensionData.Config.Hardware.Device.DeviceInfo.Label -match 'usb'}",
    "Get-UsbDevice",
    "Get-AdvancedSetting -Name isolation.tools.copy.disable"
)

# start the script prompt
$confirmation = Read-Host "Starting the script? [y/n]"
while($confirmation -ne "y")
{
    if ($confirmation -eq 'n') {exit}
    $confirmation = Read-Host "Starting the script? [y/n]"
}

# check if connect to vcenter or esxi 
If (-NOT ($global:DefaultVIServers)) {
    Write-Host "not connected to vcenter or ESXI. Exit Now" -ForegroundColor YelloW -BackgroundColor Red
    Write-Host "run Connect-VIServer esxi before run this script." -ForegroundColor YelloW -BackgroundColor Red
    exit
}

# checking for valid hostname
$host_name | ForEach-Object {
    if ( -NOT (Get-VM -Name "$_")) {
        Write-Host "VM $_ not found. Exiting script" -ForegroundColor YelloW -BackgroundColor Red
        Exit
        }
}

foreach ($setting in $vm_setting.GetEnumerator()) {
    foreach ($name in $host_name) {
        Write-Host "`nUpdating Config on $name"
        Invoke-Expression "Get-VM $name | New-AdvancedSetting -Name $($setting.Name) -Value $($setting.Value) -force -confirm:`$false"
        }
} 

# manual checking these items
foreach ($item in $manual_check) {
    foreach ($name in $host_name) {
        if (Invoke-Expression "Get-VM $name | $item") {
            Write-Host "`nPlease check these items on $name" -ForegroundColor Red 
            Write-Host "$item" -ForegroundColor Red -BackgroundColor Yellow
        }         
    }
}



