#https://adamtheautomator.com/powershell-parse-xml/
$xml_file = "C:\Users\cong\OneDrive\Documents\powershell\computers.xml"
$search_path = "/Computers/Computer"

#Select-Xml -Path $xml_file -XPath $search_path | ForEach-Object { $_.Node.InnerXML }
[xml]$xmlAttr = Get-Content -Path $xml_file
#$xmlAttr.CHECKLIST.STIGS.iSTIG.VULN.STIG_DATA | Where-Object ATTRIBUTE_DATA eq "SRG-OS-000257-GPOS-00098"

 ## looping through computers set with include="true"
 $xmlAttr.Computers.Computer | Where-Object include -eq 'true' |  ForEach-Object {
	 write-host $_.name $_.ip
 }