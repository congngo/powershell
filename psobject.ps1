$object1 = New-Object PSObject

Add-Member -InputObject $object1 -MemberType NoteProperty -Name prop1 -Value "value1"
Add-Member -InputObject $object1 -MemberType NoteProperty -Name prop2 -Value "value2"

$object1
$object1.GetType()

$object2 = [PSCustomObject]@{
    prop1 = "value1"
    prop2 = "value2"
}

$object2