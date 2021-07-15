#Load SharePoint CSOM Assemblies
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"
[Net.ServicePointManager]::SecurityProtocol = 'TLS11','TLS12','ssl3'  
### Variables for Processing
$WebUrl = "https://tiesurgical.sharepoint.com/sites/QA/"
$LibraryName ="Documents"
$SourceFolder="Z:\JobSystem\PowerApp Data\"
$UserName ="spdev@tiesurgical.com.au"
$Password ="ToolInst2017"
  
#Setup Credentials to connect
$Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($UserName,(ConvertTo-SecureString $Password -AsPlainText -Force))
  
#Set up the context
$Context = New-Object Microsoft.SharePoint.Client.ClientContext($WebUrl) 
$Context.Credentials = $Credentials
 
#Get the Library
$Library =  $Context.Web.Lists.GetByTitle($LibraryName)
 
#upload each file from the directory
Foreach ($File in  (dir $SourceFolder -File))
{
    #Get the file from disk
    $FileStream = ([System.IO.FileInfo] (Get-Item $File.FullName)).OpenRead()
   
    #Upload the File to SharePoint Library
    $FileCreationInfo = New-Object Microsoft.SharePoint.Client.FileCreationInformation
    $FileCreationInfo.Overwrite = $true
    $FileCreationInfo.ContentStream = $FileStream
    $FileCreationInfo.URL = $File
    $FileUploaded = $Library.RootFolder.Files.Add($FileCreationInfo)
  
    #powershell to upload files to sharepoint online
    $Context.Load($FileUploaded) 
    $Context.ExecuteQuery() 
 
    #Close file stream
   
 
    write-host "File: $($File) has been uploaded!"
} 
 $FileStream.Close()