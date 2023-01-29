$party = 'cleric','fighter','rogue','wizard'

function test-array {
param( [string[]] $foo )
    $i = 0
    foreach ( $line in $foo ) {
        write "[$i] $line"
        $i++
    }
}

test-array $party
#(Get-Command test-array).Parameters

function Get-Widget {
    [CmdletBinding()]
    param()
    [pscustomobject]@{
        FileName = 'foo.txt'
        Path = 'C:\foo.txt'
    }
}
function Remove-Widget {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [pscustomobject]$Widget
    )
    Write-Host "Remove-Widget: I see a `$Widget property FileName [$($Widget.FileName)] and property Path is [$($Widget.Path)]"
}
 Get-Widget | Remove-Widget