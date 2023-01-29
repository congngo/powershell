#https://www.youtube.com/watch?v=AcR9UvEnW98&list=WL&index=14&t=1549s
#https://github.com/hhorn76/PowerShell/blob/master/YouTube/How%20to%20-%20XML.ps1
$strXml= "$env:USERPROFILE\OneDrive\Documents\powershell\simple_test.xml"
$obj=New-Object -TypeName PSObject -Property @{"Jobtitle"="PowerShell Admin";"Department"="IT";"Name"="Heiko Horn"}
$xml=ConvertTo-Xml -InputObject $obj -As Document
$xml.Save($strXml)
Get-Content $strXml
#Demonstrate ConvertTo-XML with NoTypeInformation
$xml=ConvertTo-Xml -InputObject $obj -NoTypeInformation
$xml.Save($strXml)
Get-Content $strXml
ii $strXml
$xml.Objects.Object.Property
$xml.Objects.Object.Property.InnerText

$xml=ConvertTo-Xml -InputObject $obj -As Document
$xml.Objects.Object.Property.Type
$xml.Objects.Object.Property.InnerText
$xml.Objects.Object.Property.'#text'