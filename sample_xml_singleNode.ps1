$c = [xml]'<?xml version="1.0" encoding="utf-16"?>
<root>
  <User_Blob>
    <Item>
      <Key>LogonMethod</Key>
      <Value>prompt</Value>
    </Item>
    <Item>
      <Key>ServerURLEntered</Key>
      <Value>http://myserver/config.xml</Value>
    </Item>
    <Item>
      <Key>ServerURLListUsers</Key>
      <Value>
        <LSOption>http://myurl/config.xml</LSOption>
        <LSOption>http://myurl</LSOption>
      </Value>
    </Item>
    <Item>
      <Key>UserDisplayDimensions</Key>
      <Value>fullscreen</Value>
    </Item>
  </User_Blob></root>'
($c | Select-Xml -XPath "//Item[Key = 'LogonMethod']").Node.Value

[xml]$xml = $c
$xml.SelectSingleNode("//*[Key='LogonMethod']").Value