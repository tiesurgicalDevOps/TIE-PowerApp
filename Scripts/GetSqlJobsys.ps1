
#Set-ExecutionPolicy Unrestricted
#Set-ExecutionPolicy -ExecutionPolicy AllSigned -Scope CurrentUser
#Get-ExecutionPolicy -List
#Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
#region List import data and process
Import-Module C:\Users\spdev\Documents\GitHub\TIE-PowerApp\Scripts\Modules\FunctionGetSQLCSV.psm1


#region Get SQL data for SPO import process
get-sql-csv -SQLSyntax "SELECT [JobNumber],[TracerName],[Tracer] FROM [JobSysData].[dbo].[IS-vwJobItemsTracerDaily];" -filePath "Z:\JobSystem\PowerApp Data\TracerFile.csv"
#get-sql-csv -SQLSyntax "SELECT [SupplierID],[Supplier Name],[ExternalRepairer] FROM [JobSysData].[dbo].[IS-vwERList];" -filePath "Z:\JobSystem\PowerApp Data\SupplierFile.csv"
get-sql-csv -SQLSyntax "SELECT [Customer],[Job Number] as Jobnumber,[ClientID]  FROM [JobSysData].[dbo].[IS-vwJobList_daily];" -filePath "Z:\JobSystem\PowerApp Data\JobNumberFile.csv"
#get-sql-csv -SQLSyntax "SELECT *  FROM [JobSysData].[dbo].[vwStaff];" -filePath "Z:\JobSystem\PowerApp Data\StaffFile.csv"
#endregion


