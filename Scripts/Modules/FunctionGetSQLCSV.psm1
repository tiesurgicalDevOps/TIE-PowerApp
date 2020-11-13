Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
Function get-sql-csv() {
    [CmdletBinding()]
    param (
        [Parameter()][String] $filePath,
        [Parameter()][String] $SQLSyntax
    )
    
    $SQLServer = "TIE-SQL2\TIESYSTEMS"  
    $SQLDBName = "JobSysData"  
    $delimiter = ","

#SQL Query  
#$SqlQuery = #"SELECT [Job Number],[Name],[Tracer] FROM [JobSysData].[dbo].[IS-vwJobItems_test];"  
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection  
$SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; Integrated Security = True;"  
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand  
$SqlCmd.CommandText = $SQLSyntax  
$SqlCmd.Connection = $SqlConnection  
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter  
$SqlAdapter.SelectCommand = $SqlCmd   
#Creating Dataset  
$DataSet = New-Object System.Data.DataSet  
$SqlAdapter.Fill($DataSet)  
#$DataSet.Tables[0] |-Delimiter $delimiter out-file "Z:\JobSystem\TEST\test.csv"
$DataSet.Tables[0] | export-csv -Delimiter $delimiter -Path $filePath -NoTypeInformation 
}

