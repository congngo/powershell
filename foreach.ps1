$a = 5
$b = 6
$c = 7
$d = $a,$b,$c
echo "foreach loop"
foreach ($i in $d)
{
    $i +5
}

echo "ForEach-Object"
$d|ForEach-Object {$_ + 5}

echo "same ForEach-Object"
$d | % { $_ + 5 }

echo "same"
$a,$b,$c | ForEach-Object {
     echo "$_"
     $_ + 5 
     }

$a.GetType().Name
$e = [string]$a + " hello"
echo $e
Write-Host "Green " -ForegroundColor Green;
Write-Host "Whole text is in red with background Yellow" -ForegroundColor Red -BackgroundColor Yellow;
#cd Z:\ -ErrorAction Continue ; Write-Host "execution continued!!"
#Write-Error 'The file does not exist' -ErrorAction Stop
Write-Error "Error encountered" -ErrorAction Stop ; Write-Host "execution continued!!"
echo hello