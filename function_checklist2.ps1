$rhel6_checklist_file = @("test2","test2-jtid","test2-tkng","test2-smar")
$folder_path = "$env:USERPROFILE\OneDrive\Documents\powershell\result"
$rhel6_import = "$env:USERPROFILE\OneDrive\Documents\powershell\rhel6_import.csv"
$file_not_found = @()

function test-array {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory=$true, Position=0)]
		[string[]] $os_name,
        [Parameter(Mandatory=$true, Position=1)]
        [string] $os_import
	)

    foreach ($item in $os_name) {
        # add extension to file name
        $file_name = $item + ".ckl"
        # for xml_save
        $filename_save = $item + "_completed.ckl"
        $file_found = (Get-ChildItem -Path $folder_path -Filter $file_name -Recurse -File).Fullname

        if ($file_found) { 
            # get folder path
            $path_name = (Get-Item $file_found).DirectoryName 
            # get file name to save i.e. amvc2_completed.ckl
            $file_completed = $path_name + "\" + $filename_save
            write-host "completed $file_completed" 
            # load checklist.ckl file
            $xmlAttr.Load($file_found)
                 
            $os_import = Import-Csv -Path $rhel6_import
            foreach ($item in $os_import) {
                #write-host "ID = $($item.ID)"
                $xmlAttr.CHECKLIST.STIGS.iSTIG.VULN |  Where-Object {$_.STIG_DATA.ATTRIBUTE_DATA[0] -eq "$($item.ID)"}| ForEach-Object {
                if ($($item.COM) -like "*NA*") {
                    $_.STATUS = "Open" 
                    $_.COMMENTS = "$($item.COM)"
                    write-host $($item.ID) $_.STATUS $($item.COM)
                } else {
                    $_.COMMENTS = "$($item.COM)"
                }
            }
            $xmlAttr.Save($file_completed)
        } 
    }
}

#test-array $party
test-array -os_name $rhel6_checklist_file -os_import $rhel6_import