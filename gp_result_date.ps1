# must run as admin
$user = $env:USERNAME
$file = "$env:USERPROFILE\Desktop\GPRESULT_$(get-date -f MM-dd-yyyy).html"

Get-GPResultantSetOfPolicy -user $user -Computer WIN7 -ReportType Html -Path $file
