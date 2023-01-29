Write-Host "psedit foo.pst"

Write-Host "then you can edit this file"

Write-Host "and debug it too"

#$confirmation = Read-Host "Ready? [y/n]"
#while($confirmation -ne "y")
#{
#    if ($confirmation -eq 'n') {exit}
#    $confirmation = Read-Host "Ready? [y/n]"
#}

Write-Host "continued on"
if ( Get-Service | Where {$_.Status -eq "Stopped"} ) {
    Write-Host "true"
}

#$test = Get-VM rhel-temp2
#$test.ExtensionData.Config.GuestFullName
#$test | Get-NetworkAdapter | select -ExpandProperty MacAddress
