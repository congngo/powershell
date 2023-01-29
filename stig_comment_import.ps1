$rhel6_checklist_file = @("test2","test2-jtid","test2-tkng","test2-smar")
$rhel6_comment = "$env:USERPROFILE\OneDrive\Documents\powershell\rhel6_comment.csv"
$folder_path = "$env:USERPROFILE\OneDrive\Documents\powershell\result"

# Preserve normal xml format otherwise won't able to load to stigviewer 
$xmlAttr = New-Object System.Xml.XmlDocument
$xmlAttr.PreserveWhitespace = $true

function save-checklist {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory=$true, Position=0)]
		[string[]] $os_host_list,
        [Parameter(Mandatory=$true, Position=1)]
        [string] $os_comment_list
	)

    # list of checklist not found
    $file_not_found = @()

    foreach ($item in $os_host_list) {
        # add extension to file name
        $file_name = $item + ".ckl"
        # for xml_save
        $filename_save = $item + "_completed.ckl"
        $file_found = (Get-ChildItem -Path $folder_path -Filter $file_name -Recurse -File).Fullname

        if ($file_found) { 
            # get full folder path
            $path_name = (Get-Item $file_found).DirectoryName 
            # get full pathfile name to save i.e. c:\users\test\amvc2_completed.ckl
            $file_completed = $path_name + "\" + $filename_save
            #write-host "completed $file_completed" 
            # load checklist.ckl file
            $xmlAttr.Load($file_found)
                 
            $file_import = Import-Csv -Path $os_comment_list
            foreach ($item in $file_import) {
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
            }
            $xmlAttr.Save($file_completed)
        } else {
            $file_not_found += "Can not find $file_name in $folder_path."
        }      
    }
    # list for stig checklist not found
    if ($file_not_found.Count -gt 0) {
        foreach ($item in $file_not_found) {
            write-host $item -ForegroundColor "red"
        }
    }
}

#save-checklist $rhel6_checklist_file $rhel6_comment
save-checklist -os_host_list $rhel6_checklist_file -os_comment_list $rhel6_comment 