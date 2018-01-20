
$sqlservers = Get-ChildItem -path SQLSERVER:\sql\
$DBSizes = @()
foreach($s in $sqlservers){
    $MachName = $sqlservers.MachineName
    $Insts = Get-ChildItem -path "SQLSERVER:\sql\$MachName"
    foreach($i in $Insts){
        $instsName = $i.name
        foreach($InstsDB in $i.databases){
        $DBSizes += $InstsDB |Select-Object @{Name="ServerName";Expression={$instsName}}, @{Name="DBName";Expression={$instsdb.name}}, @{Name="Status";Expression={$instsdb.Status.ToString(50)}}, size, DataSpaceUsage, IndexSpaceUsage, SpaceAvailable,  @{Name="Timestamp";Expression={$(Get-Date -Format "yyyy-MM-dd HH:mm:ss")}}
        }
    }
}
$DBSizes | Format-Table -AutoSize
Write-SqlTableData -ServerInstance "localhost\namedinstance" -database "emptydatabase" -schema "dbo" -TableName "DBSize" -InputData $DBSizes
