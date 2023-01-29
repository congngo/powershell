#$targetfolder='D:\Virtual machines'
Function Check_Folder {
    Param(
        [parameter(Mandatory=$true)]
        [ValidateScript({ 
            if(Test-Path $_ -PathType Container) {
                return $true
            } elseif (Test-Path $_ -PathType Leaf) {
                throw "The Path parameter must be a folder. File paths are not allowed."
            } else {
                throw "Invalid Folder Path"
            }
        })]
        [String] $targetfolder
    )

    $dataColl = @()
    Get-ChildItem -force $targetfolder -ErrorAction SilentlyContinue | Where-Object { $_ -is [io.directoryinfo] } | ForEach-Object {
        $len = 0
        Get-ChildItem -recurse -force $_.fullname -ErrorAction SilentlyContinue | ForEach-Object { $len += $_.length }
        $foldername = $_.fullname
        $foldersize= '{0:N2}' -f ($len / 1Gb)
        $dataObject = New-Object PSObject
        Add-Member -inputObject $dataObject -memberType NoteProperty -name “foldername” -value $foldername
        Add-Member -inputObject $dataObject -memberType NoteProperty -name “foldersizeGb” -value $foldersize
        $dataColl += $dataObject
    }
    $dataColl | Sort-Object foldersizeGb -Descending | Out-GridView -Title “Size of subdirectories”
}

# run function here
Check_Folder -targetfolder "D:\"
Check_Folder -targetfolder "E:\Virtual machine"
