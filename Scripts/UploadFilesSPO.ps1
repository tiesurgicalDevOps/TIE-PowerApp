
Set-ExecutionPolicy Unrestricted
Set-ExecutionPolicy -ExecutionPolicy AllSigned -Scope CurrentUser
Get-ExecutionPolicy -List
#First times 
#Install-Module SharePointPnPPowerShellOnline 
$URL = "https://tiesurgical.sharepoint.com/sites/QA/"
$Creds = get-credential
#Add-PnPStoredCredential -Name $URL -Username $Creds.UserName -Password $Creds.Password
Get-PnPStoredCredential -Name $Creds -Type PSCredential
Connect-PnPOnline -Url $URL -Credentials  $Creds

$Files = Get-ChildItem "Z:\JobSystem\PowerApp Data\"
foreach($File in $Files){
    #$File = $Files[0]
    Add-PnPFile -Folder "Shared Documents/General" -Path $File.FullName
   # Write-Host "Uploading csv import" $File.FullName
}
