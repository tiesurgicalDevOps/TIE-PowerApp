Function GetImportCSVdatasource()
{
    [CmdletBinding()]
    
      param
        (
            [Parameter(Mandatory=$true, position=0)] [String] $CSVFileDir,
            [Parameter(Mandatory=$true, position=1)] [string] $SPOListName,
            [Parameter(Mandatory=$true, position=1)] [integer] $Option
        )
    
    

$URL = "https://tiesurgical.sharepoint.com/sites/QA/"
#$Creds = get-credential
#Add-PnPStoredCredential -Name $URL -Username $Creds.UserName -Password $Creds.Password
#Get-PnPStoredCredential -Name $Creds -Type PSCredential
Connect-PnPOnline -Url $URL -UseWebLogin
#-Credentials  $Creds

$CustomerData = $CSVFileDir #“C:\temp\JobNumberFile.csv”
$listName = $SPOListName #"Jobnumber"

$X=0


if($Option=1)
{
Import-Csv -Path $CustomerData | ForEach-Object {

    $checkitem = $null
    $tarTitle= $_.Jobnumber
    
$caml=@"
    <View>  
        <Query> 
            <Where><Eq><FieldRef Name='JobNumberID' /><Value Type='Text'>$tarTitle</Value></Eq></Where> 
        </Query> 
    </View>  -PageSize 1
"@
    $DateStamp= Get-Date -Format " dd/MM/yyyy HH:mm K"
    $checkitem= Get-PnPListItem -List $listName -Query $caml
   $X++
   if($checkitem)
        {
        Write-Host "this item exists:" $_.Jobnumber "  " $X
        Set-PnPListItem -List $listName -identity $checkitem -Values @{
            "Customer"= $_.Customer;
            "JobNumberID"= $_.Jobnumber;
            "ClientID"= $_.ClientID;
            "FileImportDateStamp" = "Update rec" + $DateStamp
            }
        }
    else
        {
        Write-Host "this item does not exist:" $_.Jobnumber "  " $X
        #//add item
        Add-PnPListItem -List $listName -Values @{
            "Customer"= $_.Customer;
            "JobNumberID"= $_.Jobnumber;
            "ClientID"= $_.ClientID;
            "FileImportDateStamp" ="Insert rec" + $DateStamp
            }
        }
}
}
elseif ($Option=2)    
{
    Import-Csv -Path $CustomerData | ForEach-Object {

        $checkitem = $null
        $tarTitle= $_.Tracer
        
$caml=@"
        <View>  
            <Query> 
                <Where><Eq><FieldRef Name='Tracer' /><Value Type='Text'>$tarTitle</Value></Eq></Where> 
            </Query> 
        </View>  -PageSize 1
"@
        $DateStamp= Get-Date -Format " dd/MM/yyyy HH:mm K"
        $checkitem= Get-PnPListItem -List $listName -Query $caml
       $X++
       if($checkitem)
            {
            Write-Host "this item exists:" $_.Tracer "  " $X
            Set-PnPListItem -List $listName -identity $checkitem -Values @{
                "Tracer"= $_.Tracer;
                "JobNumber"= $_.Jobnumber;
                "TracerName"= $_.TracerName;
                "FileImportDateStamp" = "Update rec" + $DateStamp
                }
            }
        else
            {
            Write-Host "this item does not exist:" $_.Tracer "  " $X
            #//add item
            Add-PnPListItem -List $listName -Values @{
                "Tracer"= $_.Tracer;
                "JobNumber"= $_.Jobnumber;
                "TracerName"= $_.TracerName;
                "FileImportDateStamp" ="Insert rec" + $DateStamp
                }
            }
    }
}
elseif ($Option=3) {
    Import-Csv -Path $CustomerData | ForEach-Object {

        $checkitem = $null
        $tarTitle= $_.SupplierID
        
$caml=@"
        <View>  
            <Query> 
                <Where><Eq><FieldRef Name='SupplierID' /><Value Type='Text'>$tarTitle</Value></Eq></Where> 
            </Query> 
        </View>  -PageSize 1
"@
        $DateStamp= Get-Date -Format " dd/MM/yyyy HH:mm K"
        $checkitem= Get-PnPListItem -List $listName -Query $caml
       $X++
       if($checkitem)
            {
            Write-Host "this item exists:" $_.SupplierID "  " $X
            Set-PnPListItem -List $listName -identity $checkitem -Values @{
                "SupplierID"= $_.SupplierID;
                "Supplier Name"= $_.SupplierName;
                "FileImportDateStamp" = "Update rec" + $DateStamp
                }
            }
        else
            {
            Write-Host "this item does not exist:" $_.SupplierID "  " $X
            #//add item
            Add-PnPListItem -List $listName -Values @{
                "SupplierID"= $_.SupplierID;
                "Supplier Name"= $_.SupplierName;
                "FileImportDateStamp" = "Insert rec" + $DateStamp
              
                }
            }
    }
    
}
elseif ($Option=4) {
    Import-Csv -Path $CustomerData | ForEach-Object {

        $checkitem = $null
        $tarTitle= $_.OurStaffID
        
$caml=@"
        <View>  
            <Query> 
                <Where><Eq><FieldRef Name='OurStaffID' /><Value Type='Text'>$tarTitle</Value></Eq></Where> 
            </Query> 
        </View>  -PageSize 1
"@
        $DateStamp= Get-Date -Format " dd/MM/yyyy HH:mm K"
        $checkitem= Get-PnPListItem -List $listName -Query $caml
       $X++
       if($checkitem)
            {
            Write-Host "this item exists:" $_.OurStaffID "  " $X
            Set-PnPListItem -List $listName -identity $checkitem -Values @{
                "OurStaffID"= $_.OurStaffID;
                "FirstName"= $_.FirstName;
                "Surname"= $_.Surname;
                "WindowsAlias"= $_.WindowsAlias;
                "FullName"= $_.FullName;
                "Inactive"= $_.Inactive;
                "IsPerson"= $_.IsPerson;
                "EmailAddress"= $_.EmailAddress;
                "FileImportDateStamp" = "Update rec" + $DateStamp
                }
            }
        else
            {
            Write-Host "this item does not exist:" $_.OurStaffID "  " $X
            #//add item
            Add-PnPListItem -List $listName -Values @{
                "OurStaffID"= $_.OurStaffID;
                "FirstName"= $_.FirstName;
                "Surname"= $_.Surname;
                "WindowsAlias"= $_.WindowsAlias;
                "FullName"= $_.FullName;
                "Inactive"= $_.Inactive;
                "IsPerson"= $_.IsPerson;
                "EmailAddress"= $_.EmailAddress;
                "FileImportDateStamp" = "Update rec" + $DateStamp
              
                }
            }
    }
    
}

}#End of Functionsasas
Clear-Host

