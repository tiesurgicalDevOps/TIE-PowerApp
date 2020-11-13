
Set-ExecutionPolicy Unrestricted
Set-ExecutionPolicy -ExecutionPolicy AllSigned -Scope CurrentUser
Get-ExecutionPolicy -List
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
#region List import data and process
Import-Module C:\devops\TIE-PowerApp\Scripts\Modules\ImportCSVJobnumber.psm1
Import-Module C:\devops\TIE-PowerApp\Scripts\Modules\FunctionGetSQLCSV.psm1
#endregion

#Install-Module SharePointPnPPowerShellOnline 
$URL = "https://tiesurgical.sharepoint.com/sites/QA/"
#$Creds = get-credential
#Add-PnPStoredCredential -Name $URL -Username $Creds.UserName -Password $Creds.Password
#Get-PnPStoredCredential -Name $Creds -Type PSCredential
Connect-PnPOnline -Url $URL -Credentials  M365Access

#region Get SQL data for SPO import process
get-sql-csv -SQLSyntax "SELECT [JobNumber],[TracerName],[Tracer] FROM [JobSysData].[dbo].[IS-vwJobItems_pwerapp];" -filePath "Z:\JobSystem\PowerApp Data\TracerFile.csv"
get-sql-csv -SQLSyntax "SELECT [SupplierID],[Supplier Name],[ExternalRepairer] FROM [JobSysData].[dbo].[IS-vwERList];" -filePath "Z:\JobSystem\PowerApp Data\SupplierFile.csv"
get-sql-csv -SQLSyntax "SELECT [Customer],[Job Number] as Jobnumber,[ClientID]  FROM [JobSysData].[dbo].[IS-vwJobList];" -filePath "Z:\JobSystem\PowerApp Data\JobNumberFile.csv"
get-sql-csv -SQLSyntax "SELECT *  FROM [JobSysData].[dbo].[vwStaff];" -filePath "Z:\JobSystem\PowerApp Data\StaffFile.csv"
#endregion

#region Update SPO list
GetImportCSVdatasource -CSVFileDir "Z:\JobSystem\PowerApp Data\StaffFile.csv" -SPOListName "StaffFile" -Option 4
GetImportCSVdatasource -CSVFileDir "Z:\JobSystem\PowerApp Data\JobNumberFile.csv" -SPOListName "JobNumber" -Option 1
GetImportCSVdatasource -CSVFileDir "Z:\JobSystem\PowerApp Data\TracerFile.csv" -SPOListName "TracerFile" -Option 2
GetImportCSVdatasource -CSVFileDir "Z:\JobSystem\PowerApp Data\StaffFile.csv" -SPOListName "StaffFile" -Option 3
#endregion


<#$Files = Get-ChildItem "Z:\JobSystem\PowerApp Data\"
foreach($File in $Files){
    #$File = $Files[0]
    Add-PnPFile -Folder "Shared Documents/General" -Path $File.FullName
   # Write-Host "Uploading csv import" $File.FullName
}
#>
