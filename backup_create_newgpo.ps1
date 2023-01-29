# this script backup all gpo and create new blank gpo
$date = Get-Date -Format MMddyy
$Backupgpo_dir = "C:\GPO_Backup"

# start the script prompt
$confirmation = Read-Host "Starting backup_create_newgpo script? [y/n]"
while($confirmation -ne "y")
{
    if ($confirmation -eq 'n') {exit}
    $confirmation = Read-Host "Starting backup_create_newgpo script? [y/n]"
}

# Get a list of all Computer Objects and OS
#Get-ADComputer -Filter * -Properties * | Format-Table Name, OperatingSystem -wrap -AutoSize

# Backup all GPO
# create folder for GPO backup
if (!(Test-Path $Backupgpo_dir)) {
    New-Item -ItemType Directory -Path $Backupgpo_dir
}
if (!(Test-Path $Backupgpo_dir\$date)) {
    New-Item -ItemType Directory -Path $Backupgpo_dir\$date
}
Get-GPO -All | foreach {
    #write-host "test$_.DisplayName"
    $bak_dir = "C:\GPO_Backup\" + $date + "\" + $_.DisplayName
    # avoid output to screen
    $null = New-Item  $bak_dir -ItemType Directory 
    Backup-GPO -Name $_.Displayname -Path $bak_dir
}

# Create Empty Group Policy Objects
#New-GPO -Name "DoD Microsoft Edge Computer V1R4" -Domain "STEVELAB.LOCAL"
#New-GPO -Name "DoD Mozilla Firefox Computer V6R2" -Domain "STEVELAB.LOCAL"
#New-GPO -Name "DoD Mozilla Firefox User V6R2" -Domain "STEVELAB.LOCAL"
#New-GPO -Name "DoD Google Chrome Computer V2R6" -Domain "STEVELAB.LOCAL"
#New-GPO -Name "DoD Internet Explorer 11 Computer V2R1" -Domain "STEVELAB.LOCAL"
#New-GPO -Name "DoD Internet Explorer 11 User V2R1" -Domain "STEVELAB.LOCAL"
#New-GPO -Name "DoD Windows 10 Computer V2R4" -Domain "STEVELAB.LOCAL"
#New-GPO -Name "DoD Windows 10 User V2R4" -Domain "STEVELAB.LOCAL"
#New-GPO -Name "DoD Windows Server 2016 DC Computer V2R4" -Domain "STEVELAB.LOCAL"
#New-GPO -Name "DoD Windows Server 2016 DC User V2R4" -Domain "STEVELAB.LOCAL"
#New-GPO -Name "DoD Windows Server 2016 MS Computer V2R4" -Domain "STEVELAB.LOCAL"
New-GPO -Name "DoD Windows Server 2016 MS User V2R4" -Domain "STEVELAB.LOCAL"
