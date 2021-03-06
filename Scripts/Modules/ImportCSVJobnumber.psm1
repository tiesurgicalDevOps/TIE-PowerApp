Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

Function GetImportCSVdatasource()
{
    [CmdletBinding()]
    
      param
        (
            [Parameter(Mandatory=$true, position=0)] [String] $CSVFileDir,
            [Parameter(Mandatory=$true, position=1)] [string] $SPOListName,
            [Parameter(Mandatory=$true, position=2)] [int] $Option
        )
    
    

$URL = "https://tiesurgical.sharepoint.com/sites/QA/"

Connect-PnPOnline -Url $URL #-UseWebLogin
#-Credentials  $Creds

$CustomerData = "C:\AzureDevOps\PowerShell\tie\data\TracerFile1.csv"
$listName = "TracerData" #$SPOListName 
Write-Host "1st line " $CSVFileDir " -- table " $SPOListName " -- Option " $Option.ToString() 
$X=0


switch ($Option) {
    1 { #condition 
    

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
    2 {
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
                    "Jobnumber"= $_.Jobnumber;
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
                    "Jobnumber"= $_.Jobnumber;
                    "TracerName"= $_.TracerName;
                    "FileImportDateStamp" ="Insert rec" + $DateStamp
                    }
                }
        }
    }
    3 {
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
    4 {
        Import-Csv -Path $CustomerData | ForEach-Object {

            $checkitem = $null
            $tarTitle= [Int]::Parse($_.OurStaffID)
            
$caml=@"
            <View>  
                <Query> 
                    <Where><Eq><FieldRef Name='OurStaffID' /><Value Type='Number'>$tarTitle</Value></Eq></Where> 
                </Query> 
            </View>  -PageSize 1
"@
            $DateStamp= Get-Date -Format " dd/MM/yyyy HH:mm K"
            $checkitem= Get-PnPListItem -List $listName -Query $caml
            Write-Host $caml "<--"
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
                    "FileImportDateStamp" = "Insert rec" + $DateStamp
                  
                    }
                }
        }
    }
    } #end of Switch

}#End of Function
Clear-Host
#GetImportCSVdatasource -CSVFileDir "C:\AzureDevOps\PowerShell\tie\data\TracerFile1.csv" -SPOListName "TracerData" -Option 2
