Import-Module ActiveDirectory

$Users = Import-Csv -Delimiter ";" -Path "C:\ADUsers.csv"            

foreach ($User in $Users)            
{            
    $Displayname = $User.FirstName + " " + $User.Lastname            
    $UserFirstname = $User.Firstname            
    $UserLastname = $User.Lastname            
    $OU = $User.OU           
    $SAM = $User.SAM            
    $UPN = $User.Firstname + $User.Lastname + "@" + $User.MailDomain            
    $Description = $User.Description            
    $Password = $User.Password       
    New-ADUser -Name $Displayname -DisplayName $Displayname -SamAccountName $SAM -UserPrincipalName $UPN -GivenName $UserFirstname -Surname $UserLastname -Description $Description -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path "$OU" -ChangePasswordAtLogon $false –PasswordNeverExpires $true
    Write-Host $User.SAM "created successfully"
}
