#====================================================================================================================================
# Author Rebuild: Nam, Pham <Nam.Pham@Office365VietNam.info>
#
# Date rebuild:	4/November/2020
#
# Purpose:
#		- Support Organization management Microsoft 365 via PowerShell
#



#Require run as Administrator permission
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
	$arguments = "& '" + $myinvocation.mycommand.definition + "'"
	Start-Process powershell -Verb runAs -ArgumentList $arguments
	Break
}


Set-ExecutionPolicy Unrestricted

#Make folder for log files
md c:\O365Temp
cd c:\O365Temp\

#Define licenses type 
# view SKU Lineces: Get-MsolAccountSku

$Person.UsageLocation = "VN"

#Replace License
#For Edu
$EDU1 = "abceduvn:STANDARDWOFFPACK_FACULTY"
$EDU2 = "abceduvn:STANDARDWOFFPACK_STUDENT"
$EDU3 = "abceduvn:ENTERPRISEPACK_FACULTY"
$EDU4 = "abceduvn:ENTERPRISEPACK_FACULTY"
$EDU5 = "abceduvn:RIGHTSMANAGEMENT_STANDARD_FACULTY"
$EDU6 = "abceduvn:RIGHTSMANAGEMENT_STANDARD_FACULTY"

$Loop = $true
While ($Loop)
{
    write-host
    write-host ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    write-host 		"Microsoft 365 management  | PowerShell Script menu"
    write-host ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    write-host
    write-host -ForegroundColor green  'Connect PowerShell session to AD Azure and Exchange Online'
    write-host -ForegroundColor green  '--------------------------------------------------------------'
	write-host
    write-host -ForegroundColor Red    						' 1)   Login in using your Office 365 Administrator credentials'
    #write-host
	write-host -ForegroundColor green  '---------------------------'
    write-host -ForegroundColor white  -BackgroundColor Blue 'Section A: Create Multi User'
    write-host -ForegroundColor green  '---------------------------'
    write-host
    write-host                                              ' 2)    View all lineces type in O365'
	write-host                                              ' 3)    Create multi user with password with "Script-ImportUser-OPwd-tmpl.csv"'
	write-host                                             	' 3.1)  Create multi user with not require changing password for 1st login with "Script-ImportUser-OPwd-tmpl.csv"'
	write-host -ForegroundColor Cyan                                          	' 3.2)  Create multi user with password with "Script-ImportUser-OPwd-tmpl-full-detail.csv"'
	write-host -ForegroundColor Cyan                                           	' 3.3)  Create multi user with not require changing password for 1st login with "Script-ImportUser-OPwd-tmpl-full-detail.csv"'
	write-host                                             	' 3.4)  Update multi user information with "Script-UpdateUser-Info-tmpl-full-detail.csv"'
	write-host                                             	' 3.5)  Change UserName with "Script-ChangeUserName-List.csv"'
	#write-host
	write-host -ForegroundColor green  '---------------------------'
    write-host -ForegroundColor white  -BackgroundColor Blue 'Section B: Set Roles'
    write-host -ForegroundColor green  '---------------------------'
    write-host
	write-host                                              ' 4)    Set roles multi user with "Script-SetAdminRole-tmpl.csv"'
	write-host                                              ' 4.1)  Remove all roles for multi user with "Script-SetAdminRole-tmpl.csv"'
	#write-host
    write-host -ForegroundColor green  '---------------------------'
    write-host -ForegroundColor white  -BackgroundColor Blue 'Section C: Set Password never expired'
    write-host -ForegroundColor green  '---------------------------'
    write-host
	write-host                                              ' 5)    Set Password never expired for a specific user'
	write-host                                              ' 5.1)  Set Password for multi user with "Script-ChangeUser-Password-tmpl.csv"'
	write-host                                              ' 5.2)  Set Password for multi user not require changing password for 1st login with "Script-ChangeUser-Password-tmpl.csv"'
	write-host                                              ' 6)    Disable Password never expired option for a specific user'
	write-host                                              ' 7)    Set Password never expired for all Office 365 users (BULK Mode)'
	#write-host
	write-host -ForegroundColor green  '---------------------------'
    write-host -ForegroundColor white  -BackgroundColor Blue ' Section D: Troubleshooting  '
    write-host -ForegroundColor green  '---------------------------'
    write-host
	write-host                                              ' 8)   Export information about Office 365 user password settings'
	#write-host
	write-host -ForegroundColor green  '---------------------------'
    write-host -ForegroundColor white  -BackgroundColor Blue ' Section E: Delete Account  '
    write-host -ForegroundColor green  '---------------------------'
    write-host
	write-host                                              ' 9)   Delete Account with "Script-DeleteUser-List.csv"'
	write-host                                              ' 9.1) Delete all users in "Deleted Users" Office 365'
	#write-host
	write-host -ForegroundColor green  '---------------------------'
    write-host -ForegroundColor white  -BackgroundColor Blue ' Section F: ReAssign Licenses  '
    write-host -ForegroundColor green  '---------------------------'
    write-host
	write-host                                              ' 10)   Assign Licenses with "Script-ReAssignLicenses-List-tmpl.csv"'
	write-host                                              ' 10.1) Remove All Licenses with "Script-ReAssignLicenses-List-tmpl.csv"'
	#write-host
	write-host -ForegroundColor green  '---------------------------'
    write-host -ForegroundColor white  -BackgroundColor Blue ' Section G: Microsoft Teams  '
    write-host -ForegroundColor green  '---------------------------'
    write-host
	write-host                                           ' 11)   Prevent normal users create team/group/planner/SharePoint'
	write-host                                              ' 11.1) Allow normal users create team/group/planner/SharePoint'
	write-host                                              ' 11.2) Add users into ALLOW TEAM CREATION group with "Script-AddUser-intoGroup-tmpl.csv"'
	write-host -ForegroundColor Cyan                                         ' 11.3) Auto Add users with A1 Faculty licenses into ALLOW TEAM CREATION group'
	#write-host
	write-host -ForegroundColor green  '---------------------------'
    write-host -ForegroundColor Blue  -BackgroundColor Yello ' Exit\Disconnect '
    write-host -ForegroundColor green  '---------------------------'
    write-host
    write-host  -ForegroundColor Yellow                      ' 03)  Disconnect PowerShell session'
	write-host
	write-host  -ForegroundColor Yellow                      ' 0)   Exit'
	write-host
	#write-host



    $opt = Read-Host "Select an option [0-11]"
    write-host $opt
	switch ($opt)
	
	

{

	
		#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		# Step -  Create a Remote PowerShell session to AD Azure and Exchange Online
		#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


	1
	{

				# Specify your administrative user credentials on the line below

				$user = “Admin@.....”

				# This will pop-up a dialogue and request your password

				Write-host "Vui long cho trong giay lat!!!"

				#——– Import the Local Microsoft Online PowerShell Module Cmdlets and  Establish an Remote PowerShell Session to AD Azure
				
				Import-Module MSOnline -Force
				Install-module AzureADPreview -Force
				

				#———— Establish an Remote PowerShell Session to Exchange Online ———————

				$msoExchangeURL = “https://outlook.office365.com/powershell-liveid/”
				$connected = $false
				$i = 0
				while ( -not ($connected)) {
					$i++
					if($i -eq 4){


						Write-host
						Write-host -ForegroundColor White	ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
						Write-host
						Write-host -ForegroundColor Red    "Too many incorrect login attempts. Good bye."
						Write-host
						Write-host -ForegroundColor White	ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
						Write-host


						exit
					}
					$cred = Get-Credential -Credential $user
					try
					{
						#Login Azure
						Connect-AzureAD #-Credential -$cred -ErrorAction stop
						
						#Login O365
						$session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $msoExchangeURL -Credential $cred -Authentication Basic -AllowRedirection  -ErrorAction stop
						Connect-MsolService -Credential $cred -ErrorAction stop
						Import-PSSession $session -AllowClobber
						
						$connected = $true
					}
					catch
					{
						Write-host
						Write-host -ForegroundColor Yellow	ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
						Write-host
						Write-host -ForegroundColor Red     "There is something wrong with the global administrator credentials"
						Write-host
						Write-host -ForegroundColor Yellow	ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
						Write-host
					}

				}

				$host.ui.RawUI.WindowTitle = ("Windows Azure Active Directory | Connected to Office 365 using: " + $Cred.UserName.ToString()  )




			}


	
	#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	# Section A: Create Multi User
	#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	2{
		Get-MsolAccountSku

		Write-Host "Lay Tat ca AccountSkuId: dien vao #Replace License "
		Write-Host
		pause
	}

	3{


	$csvfile  = Read-Host "Nhan dia chi file Script-ImportUser-OPwd-tmpl.csv vd: c:\Script-ImportUser-OPwd-tmpl.csv"

	If ($csvfile -ne "")
	{
	Write-Host "Processing "$csvfile

	$outFile = ".\UserList_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
	$outfileheader = "DisplayName,UserPrincipalName,Password,AssignedLicense,DetailLogs"
	Out-File -FilePath $outFile -InputObject $outfileheader
	$OF = $null
	$x = $null

	$LogFile = ".\LogFile_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
	$LF = $null


	$UserList = IMPORT-CSV $csvfile -Delimiter ","
	Write-Host $UserList.count"So luong ban ghi..."

	

	$Created = 0
	$Skipped = 0

	FOREACH($Person in $UserList)
	{

	if (get-msoluser -userprincipalname $person.userprincipalname -erroraction silentlycontinue)
	{
	 $lf = $person.userprincipalname + " da ton tai"
	 out-file -filepath $logfile -append -noclobber -inputobject $lf
	 $lf = $null
	 $skipped++
	}
	elseif($Person.AssignedLicense -eq "EDU1")
	 {

	  $x = New-MsolUser -UserPrincipalName $Person.UserPrincipalName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -UsageLocation $Person.UsageLocation -Department $Person.Department -LicenseAssignment $EDU1
	  $OF = $Person.DisplayName + "," + $Person.UserPrincipalName + "," + $Person.Password + "," + $EDU1 + "," + $Error[0].Exception.Message
	  Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
	  $OF = $null
	  $x = $null
	  $Created++
	 }
	 elseif($Person.AssignedLicense -eq "EDU2")
	 {

	  $x = New-MsolUser -UserPrincipalName $Person.UserPrincipalName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -UsageLocation $Person.UsageLocation -Department $Person.Department -LicenseAssignment $EDU2
	  $OF = $Person.DisplayName + "," + $Person.UserPrincipalName + "," + $Person.Password + "," + $EDU2 + "," + $Error[0].Exception.Message
	  Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
	  $OF = $null
	  $x = $null
	  $Created++
	 }
	 elseif($Person.AssignedLicense -eq "EDU3")
	 {

	  $x = New-MsolUser -UserPrincipalName $Person.UserPrincipalName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -UsageLocation $Person.UsageLocation -Department $Person.Department -LicenseAssignment $EDU3
	  $OF = $Person.DisplayName + "," + $Person.UserPrincipalName + "," + $Person.Password + "," + $EDU3 + "," + $Error[0].Exception.Message
	  Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
	  $OF = $null
	  $x = $null
	  $Created++
	 }
	 elseif($Person.AssignedLicense -eq "EDU4")
	 {

	  $x = New-MsolUser -UserPrincipalName $Person.UserPrincipalName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -UsageLocation $Person.UsageLocation -Department $Person.Department -LicenseAssignment $EDU4
	  $OF = $Person.DisplayName + "," + $Person.UserPrincipalName + "," + $Person.Password + "," + $EDU4 + "," + $Error[0].Exception.Message
	  Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
	  $OF = $null
	  $x = $null
	  $Created++
	 }
	 elseif($Person.AssignedLicense -eq "EDU5")
	 {

	  $x = New-MsolUser -UserPrincipalName $Person.UserPrincipalName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -UsageLocation $Person.UsageLocation -Department $Person.Department -LicenseAssignment $EDU5
	  $OF = $Person.DisplayName + "," + $Person.UserPrincipalName + "," + $Person.Password + "," + $EDU5 + "," + $Error[0].Exception.Message
	  Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
	  $OF = $null
	  $x = $null
	  $Created++
	 }
	 elseif($Person.AssignedLicense -eq "EDU6")
	 {

	  $x = New-MsolUser -UserPrincipalName $Person.UserPrincipalName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -UsageLocation $Person.UsageLocation -Department $Person.Department -LicenseAssignment $EDU6
	  $OF = $Person.DisplayName + "," + $Person.UserPrincipalName + "," + $Person.Password + "," + $EDU6 + "," + $Error[0].Exception.Message
	  Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
	  $OF = $null
	  $x = $null
	  $Created++
	 }	 
	 else
	 {

	  $LF = $Person.userprincipalname + " Khong dung License"
	  Out-File -FilePath $LogFile -Append -NoClobber -InputObject $LF
	  $LF = $null
	  $Skipped++
	 }
	 }
	}
	Else{
		Write-Host "Chua nhap dia chi file *.csv"
	}
	Write-Host "Da hoan thanh"
	Write-Host $Created" ban ghi da duoc khoi tao..."
	Write-Host $Skipped" ban ghi da bi bo qua..."

	pause

	}

	3.1{


	$csvfile  = Read-Host "Nhan dia chi file Script-ImportUser-OPwd-tmpl.csv vd: c:\Script-ImportUser-OPwd-tmpl.csv"

	If ($csvfile -ne "")
	{
	Write-Host "Processing "$csvfile

	$outFile = ".\UserList_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
	$outfileheader = "DisplayName,UserPrincipalName,Password,AssignedLicense,DetailLogs"
	Out-File -FilePath $outFile -InputObject $outfileheader
	$OF = $null
	$x = $null

	$LogFile = ".\LogFile_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
	$LF = $null


	$UserList = IMPORT-CSV $csvfile -Delimiter ","
	Write-Host $UserList.count"So luong ban ghi..."

	

	$Created = 0
	$Skipped = 0

	FOREACH($Person in $UserList)
	{

	if (get-msoluser -userprincipalname $person.userprincipalname -erroraction silentlycontinue)
	{
	 $lf = $person.userprincipalname + " da ton tai"
	 out-file -filepath $logfile -append -noclobber -inputobject $lf
	 $lf = $null
	 $skipped++
	}
	 elseif($Person.AssignedLicense -eq "EDU1")
	 {

	  $x = New-MsolUser -UserPrincipalName $Person.UserPrincipalName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -UsageLocation $Person.UsageLocation -Department $Person.Department -LicenseAssignment $EDU1 -ForceChangePassword $False
	  $OF = $Person.DisplayName + "," + $Person.UserPrincipalName + "," + $Person.Password + "," + $EDU1 + "," + $Error[0].Exception.Message
	  Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
	  $OF = $null
	  $x = $null
	  $Created++
	 }
	 elseif($Person.AssignedLicense -eq "EDU2")
	 {

	  $x = New-MsolUser -UserPrincipalName $Person.UserPrincipalName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -UsageLocation $Person.UsageLocation -Department $Person.Department -LicenseAssignment $EDU2 -ForceChangePassword $False
	  $OF = $Person.DisplayName + "," + $Person.UserPrincipalName + "," + $Person.Password + "," + $EDU2 + "," + $Error[0].Exception.Message
	  Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
	  $OF = $null
	  $x = $null
	  $Created++
	 }
	 elseif($Person.AssignedLicense -eq "EDU3")
	 {

	  $x = New-MsolUser -UserPrincipalName $Person.UserPrincipalName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -UsageLocation $Person.UsageLocation -Department $Person.Department -LicenseAssignment $EDU3 -ForceChangePassword $False
	  $OF = $Person.DisplayName + "," + $Person.UserPrincipalName + "," + $Person.Password + "," + $EDU3 + "," + $Error[0].Exception.Message
	  Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
	  $OF = $null
	  $x = $null
	  $Created++
	 }
	 elseif($Person.AssignedLicense -eq "EDU4")
	 {

	  $x = New-MsolUser -UserPrincipalName $Person.UserPrincipalName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -UsageLocation $Person.UsageLocation -Department $Person.Department -LicenseAssignment $EDU4 -ForceChangePassword $False
	  $OF = $Person.DisplayName + "," + $Person.UserPrincipalName + "," + $Person.Password + "," + $EDU4 + "," + $Error[0].Exception.Message
	  Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
	  $OF = $null
	  $x = $null
	  $Created++
	 }
	 elseif($Person.AssignedLicense -eq "EDU5")
	 {

	  $x = New-MsolUser -UserPrincipalName $Person.UserPrincipalName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -UsageLocation $Person.UsageLocation -Department $Person.Department -LicenseAssignment $EDU5 -ForceChangePassword $False
	  $OF = $Person.DisplayName + "," + $Person.UserPrincipalName + "," + $Person.Password + "," + $EDU5 + "," + $Error[0].Exception.Message
	  Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
	  $OF = $null
	  $x = $null
	  $Created++
	 }
	 elseif($Person.AssignedLicense -eq "EDU6")
	 {

	  $x = New-MsolUser -UserPrincipalName $Person.UserPrincipalName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -UsageLocation $Person.UsageLocation -Department $Person.Department -LicenseAssignment $EDU6 -ForceChangePassword $False
	  $OF = $Person.DisplayName + "," + $Person.UserPrincipalName + "," + $Person.Password + "," + $EDU6 + "," + $Error[0].Exception.Message
	  Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
	  $OF = $null
	  $x = $null
	  $Created++
	 }	 
	 else
	 {

	  $LF = $Person.userprincipalname + " Khong dung License"
	  Out-File -FilePath $LogFile -Append -NoClobber -InputObject $LF
	  $LF = $null
	  $Skipped++
	 }
	 }
	 

	}
	Else{
		Write-Host "Chua nhap dia chi file *.csv"
	}
	Write-Host "Da hoan thanh"
	Write-Host $Created" ban ghi da duoc khoi tao..."
	Write-Host $Skipped" ban ghi da bi bo qua..."

	pause

	}

	3.2{


		#Create multi user with password with "Script-ImportUser-OPwd-tmpl-full-detail.csv"'
	
		$csvfile  = Read-Host "Nhan dia chi file Script-ImportUser-OPwd-tmpl-full-detail.csv vd: c:\Script-ImportUser-OPwd-tmpl-full-detail.csv"
	
		If ($csvfile -ne "")
		{
		Write-Host "Processing "$csvfile
	
		$outFile = ".\UserList_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$outfileheader = "DisplayName,UserName,Password,AssignedLicense,DetailLogs"
		Out-File -FilePath $outFile -InputObject $outfileheader
		$OF = $null
		$x = $null
	
		$LogFile = ".\LogFile_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$LF = $null
	
	
		$UserList = IMPORT-CSV $csvfile -Delimiter ","
		Write-Host $UserList.count" So luong ban ghi..."
	
		
	
		$Created = 0
		$Skipped = 0
	
		FOREACH($Person in $UserList)
		{
	
		if (get-msoluser -userprincipalname $person.UserName -erroraction silentlycontinue)
		{
		 $lf = $person.UserName + " da ton tai"
		 out-file -filepath $logfile -append -noclobber -inputobject $lf
		 $lf = $null
		 $skipped++
		}
		elseif($Person.AssignedLicense -eq "EDU1")
		 {
	
		  $x = New-MsolUser -UserPrincipalName $Person.UserName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -Title $Person.JobTitle -Department $Person.Department -Office $Person.OfficeNumber -PhoneNumber $Person.OfficePhone -MobilePhone $Person.MobilePhone -Fax $Person.Fax -StreetAddress $Person.Address -City $Person.City -State $Person.StateorProvince -PostalCode $Person.ZIPorPostalCode -UsageLocation $Person.CountryorRegion -LicenseAssignment $EDU1
		  $OF = $Person.DisplayName + "," + $Person.UserName + "," + $Person.Password + "," + $EDU1 + "," + $Error[0].Exception.Message
		  Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
		  $OF = $null
		  $x = $null
		  $Created++
		 }
		 elseif($Person.AssignedLicense -eq "EDU2")
		 {
	
		  $x = New-MsolUser -UserPrincipalName $Person.UserName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -Title $Person.JobTitle -Department $Person.Department -Office $Person.OfficeNumber -PhoneNumber $Person.OfficePhone -MobilePhone $Person.MobilePhone -Fax $Person.Fax -StreetAddress $Person.Address -City $Person.City -State $Person.StateorProvince -PostalCode $Person.ZIPorPostalCode -UsageLocation $Person.CountryorRegion -LicenseAssignment $EDU2
		  $OF = $Person.DisplayName + "," + $Person.UserName + "," + $Person.Password + "," + $EDU2 + "," + $Error[0].Exception.Message
		  Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
		  $OF = $null
		  $x = $null
		  $Created++
		 }
		 elseif($Person.AssignedLicense -eq "EDU3")
		 {
	
		  $x = New-MsolUser -UserPrincipalName $Person.UserName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -Title $Person.JobTitle -Department $Person.Department -Office $Person.OfficeNumber -PhoneNumber $Person.OfficePhone -MobilePhone $Person.MobilePhone -Fax $Person.Fax -StreetAddress $Person.Address -City $Person.City -State $Person.StateorProvince -PostalCode $Person.ZIPorPostalCode -UsageLocation $Person.CountryorRegion -LicenseAssignment $EDU3
		  $OF = $Person.DisplayName + "," + $Person.UserName + "," + $Person.Password + "," + $EDU3 + "," + $Error[0].Exception.Message
		  Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
		  $OF = $null
		  $x = $null
		  $Created++
		 }
		 elseif($Person.AssignedLicense -eq "EDU4")
		 {
	
		  $x = New-MsolUser -UserPrincipalName $Person.UserName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -Title $Person.JobTitle -Department $Person.Department -Office $Person.OfficeNumber -PhoneNumber $Person.OfficePhone -MobilePhone $Person.MobilePhone -Fax $Person.Fax -StreetAddress $Person.Address -City $Person.City -State $Person.StateorProvince -PostalCode $Person.ZIPorPostalCode -UsageLocation $Person.CountryorRegion -LicenseAssignment $EDU4
		  $OF = $Person.DisplayName + "," + $Person.UserName + "," + $Person.Password + "," + $EDU4 + "," + $Error[0].Exception.Message
		  Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
		  $OF = $null
		  $x = $null
		  $Created++
		 }
		 elseif($Person.AssignedLicense -eq "EDU5")
		 {
	
		  $x = New-MsolUser -UserPrincipalName $Person.UserName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -Title $Person.JobTitle -Department $Person.Department -Office $Person.OfficeNumber -PhoneNumber $Person.OfficePhone -MobilePhone $Person.MobilePhone -Fax $Person.Fax -StreetAddress $Person.Address -City $Person.City -State $Person.StateorProvince -PostalCode $Person.ZIPorPostalCode -UsageLocation $Person.CountryorRegion -LicenseAssignment $EDU5
		  $OF = $Person.DisplayName + "," + $Person.UserName + "," + $Person.Password + "," + $EDU5 + "," + $Error[0].Exception.Message
		  Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
		  $OF = $null
		  $x = $null
		  $Created++
		 }
		 elseif($Person.AssignedLicense -eq "EDU6")
		 {
	
		  $x = New-MsolUser -UserPrincipalName $Person.UserName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -Title $Person.JobTitle -Department $Person.Department -Office $Person.OfficeNumber -PhoneNumber $Person.OfficePhone -MobilePhone $Person.MobilePhone -Fax $Person.Fax -StreetAddress $Person.Address -City $Person.City -State $Person.StateorProvince -PostalCode $Person.ZIPorPostalCode -UsageLocation $Person.CountryorRegion -LicenseAssignment $EDU6
		  $OF = $Person.DisplayName + "," + $Person.UserName + "," + $Person.Password + "," + $EDU6 + "," + $Error[0].Exception.Message
		  Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
		  $OF = $null
		  $x = $null
		  $Created++
		 }		 
		 else
		 {
	
		  $LF = $Person.userprincipalname + " Khong dung License"
		  Out-File -FilePath $LogFile -Append -NoClobber -InputObject $LF
		  $LF = $null
		  $Skipped++
		 }
		 
		 }
	
		}
		Else{
			Write-Host "Chua nhap dia chi file *.csv"
		}
		Write-Host "Da hoan thanh"
		Write-Host $Created" ban ghi da duoc khoi tao..."
		Write-Host $Skipped" ban ghi da bi bo qua..."
	
		pause
	
		}

	3.3{


		#Create multi user with not require changing password for 1st login with "Script-ImportUser-OPwd-tmpl-full-detail.csv"'
	
		$csvfile  = Read-Host "Nhan dia chi file Script-ImportUser-OPwd-tmpl-full-detail.csv vd: c:\Script-ImportUser-OPwd-tmpl-full-detail.csv"
	
		If ($csvfile -ne "")
		{
		Write-Host "Processing "$csvfile
	
		$outFile = ".\UserList_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$outfileheader = "DisplayName,UserName,Password,AssignedLicense,DetailLogs"
		Out-File -FilePath $outFile -InputObject $outfileheader
		$OF = $null
		$x = $null
	
		$LogFile = ".\LogFile_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$LF = $null
	
	
		$UserList = IMPORT-CSV $csvfile -Delimiter ","
		Write-Host $UserList.count" So luong ban ghi..."
	
		
	
		$Created = 0
		$Skipped = 0
	
		FOREACH($Person in $UserList)
		{
	
		if (get-msoluser -userprincipalname $person.UserName -erroraction silentlycontinue)
		{
			$lf = $person.UserName + " da ton tai"
			out-file -filepath $logfile -append -noclobber -inputobject $lf
			$lf = $null
			$skipped++
		}
		else
		{
			if($Person.AssignedLicense -eq "EDU1")
			{
	
			$x = New-MsolUser -UserPrincipalName $Person.UserName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -Title $Person.JobTitle -Department $Person.Department -Office $Person.OfficeNumber -PhoneNumber $Person.OfficePhone -MobilePhone $Person.MobilePhone -Fax $Person.Fax -StreetAddress $Person.Address -City $Person.City -State $Person.StateorProvince -PostalCode $Person.ZIPorPostalCode -UsageLocation $Person.CountryorRegion -LicenseAssignment $EDU1 -ForceChangePassword $False
			$OF = $Person.DisplayName + "," + $Person.UserName + "," + $Person.Password + "," + $EDU1 + "," + $Error[0].Exception.Message
			Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
			$OF = $null
			$x = $null
			$Created++
			}
			elseif($Person.AssignedLicense -eq "EDU2")
			{
	
			$x = New-MsolUser -UserPrincipalName $Person.UserName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -Title $Person.JobTitle -Department $Person.Department -Office $Person.OfficeNumber -PhoneNumber $Person.OfficePhone -MobilePhone $Person.MobilePhone -Fax $Person.Fax -StreetAddress $Person.Address -City $Person.City -State $Person.StateorProvince -PostalCode $Person.ZIPorPostalCode -UsageLocation $Person.CountryorRegion -LicenseAssignment $EDU2 -ForceChangePassword $False
			$OF = $Person.DisplayName + "," + $Person.UserName + "," + $Person.Password + "," + $EDU2 + "," + $Error[0].Exception.Message
			Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
			$OF = $null
			$x = $null
			$Created++
			}
			elseif($Person.AssignedLicense -eq "EDU3")
			{
	
			$x = New-MsolUser -UserPrincipalName $Person.UserName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -Title $Person.JobTitle -Department $Person.Department -Office $Person.OfficeNumber -PhoneNumber $Person.OfficePhone -MobilePhone $Person.MobilePhone -Fax $Person.Fax -StreetAddress $Person.Address -City $Person.City -State $Person.StateorProvince -PostalCode $Person.ZIPorPostalCode -UsageLocation $Person.CountryorRegion -LicenseAssignment $EDU3 -ForceChangePassword $False
			$OF = $Person.DisplayName + "," + $Person.UserName + "," + $Person.Password + "," + $EDU3 + "," + $Error[0].Exception.Message
			Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
			$OF = $null
			$x = $null
			$Created++
			}
			elseif($Person.AssignedLicense -eq "EDU4")
			{
	
			$x = New-MsolUser -UserPrincipalName $Person.UserName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -Title $Person.JobTitle -Department $Person.Department -Office $Person.OfficeNumber -PhoneNumber $Person.OfficePhone -MobilePhone $Person.MobilePhone -Fax $Person.Fax -StreetAddress $Person.Address -City $Person.City -State $Person.StateorProvince -PostalCode $Person.ZIPorPostalCode -UsageLocation $Person.CountryorRegion -LicenseAssignment $EDU4 -ForceChangePassword $False
			$OF = $Person.DisplayName + "," + $Person.UserName + "," + $Person.Password + "," + $EDU4 + "," + $Error[0].Exception.Message
			Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
			$OF = $null
			$x = $null
			$Created++
			}
			elseif($Person.AssignedLicense -eq "EDU5")
			{
	
			$x = New-MsolUser -UserPrincipalName $Person.UserName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -Title $Person.JobTitle -Department $Person.Department -Office $Person.OfficeNumber -PhoneNumber $Person.OfficePhone -MobilePhone $Person.MobilePhone -Fax $Person.Fax -StreetAddress $Person.Address -City $Person.City -State $Person.StateorProvince -PostalCode $Person.ZIPorPostalCode -UsageLocation $Person.CountryorRegion -LicenseAssignment $EDU5 -ForceChangePassword $False
			$OF = $Person.DisplayName + "," + $Person.UserName + "," + $Person.Password + "," + $EDU5 + "," + $Error[0].Exception.Message
			Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
			$OF = $null
			$x = $null
			$Created++
			}
			elseif($Person.AssignedLicense -eq "EDU6")
			{
	
			$x = New-MsolUser -UserPrincipalName $Person.UserName -Password $Person.Password -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -Title $Person.JobTitle -Department $Person.Department -Office $Person.OfficeNumber -PhoneNumber $Person.OfficePhone -MobilePhone $Person.MobilePhone -Fax $Person.Fax -StreetAddress $Person.Address -City $Person.City -State $Person.StateorProvince -PostalCode $Person.ZIPorPostalCode -UsageLocation $Person.CountryorRegion -LicenseAssignment $EDU6 -ForceChangePassword $False
			$OF = $Person.DisplayName + "," + $Person.UserName + "," + $Person.Password + "," + $EDU6 + "," + $Error[0].Exception.Message
			Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
			$OF = $null
			$x = $null
			$Created++
			}				
			else
			{
	
			$LF = $Person.userprincipalname + " Khong dung License"
			Out-File -FilePath $LogFile -Append -NoClobber -InputObject $LF
			$LF = $null
			$Skipped++
			}
			}
			}
	
		}
		Else{
			Write-Host "Chua nhap dia chi file *.csv"
		}
		Write-Host "Da hoan thanh"
		Write-Host $Created" ban ghi da duoc khoi tao..."
		Write-Host $Skipped" ban ghi da bi bo qua..."
	
		pause
	
		}

	3.4{

		#Update multi user information with "Script-UpdateUser-Info-tmpl-full-detail.csv"'
	
		$csvfile  = Read-Host "Nhan dia chi file Script-UpdateUser-Info-tmpl-full-detail.csv vd: c:\Script-UpdateUser-Info-tmpl-full-detail.csv"
	
		If ($csvfile -ne "")
		{
		Write-Host "Processing "$csvfile
	
		$outFile = ".\UserList_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$outfileheader = "UserName,FirstName,FirstName,DisplayName,JobTitle,Department,OfficeNumber,OfficePhone,MobilePhone,Fax,Address,City,StateorProvince,ZIPorPostalCode,CountryorRegion,DetailLogs"
		Out-File -FilePath $outFile -InputObject $outfileheader
		$OF = $null
		$x = $null
	
		$LogFile = ".\LogFile_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$LF = $null
	
	
		$UserList = IMPORT-CSV $csvfile -Delimiter ","
		Write-Host $UserList.count" So luong ban ghi..."
	
		
	
		$Created = 0
		$Skipped = 0
	
			FOREACH($Person in $UserList)
			{
		
				if (get-msoluser -userprincipalname $person.UserName -erroraction silentlycontinue)
				{					
					$x = Set-MsolUser -UserPrincipalName $Person.UserName -DisplayName $Person.DisplayName -FirstName $Person.FirstName -LastName $Person.LastName -Title $Person.JobTitle -Department $Person.Department -Office $Person.OfficeNumber -PhoneNumber $Person.OfficePhone -MobilePhone $Person.MobilePhone -Fax $Person.Fax -StreetAddress $Person.Address -City $Person.City -State $Person.StateorProvince -PostalCode $Person.ZIPorPostalCode -UsageLocation $Person.CountryorRegion
					$OF = $Person.UserName + "," + $Person.FirstName + "," + $Person.LastName + "," + $Person.DisplayName + "," + $Person.JobTitle + "," + $Person.Department + "," + $Person.OfficeNumber + "," + $Person.OfficePhone + "," + $Person.MobilePhone + "," + $Person.Fax + "," + $Person.Address + "," + $Person.City + "," + $Person.StateorProvince + "," + $Person.ZIPorPostalCode + "," + $Person.CountryorRegion + "," + $Error[0].Exception.Message
					Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
					$OF = $null
					$x = $null
					$Created++	
				}
				else
				{
					$lf = $person.UserName + " khong ton tai user"
					out-file -filepath $logfile -append -noclobber -inputobject $lf
					$lf = $null
					$skipped++			
				
				}
			}
		}
		Else{
			Write-Host "Chua nhap dia chi file *.csv"
		}
		Write-Host "Da hoan thanh"
		Write-Host $Created" ban ghi da duoc update..."
		Write-Host $Skipped" ban ghi da bi bo qua..."
	
		pause
	
	}

	3.5{

		#Change UserName with "Script-ChangeUserName-List.csv"'
	
		$csvfile  = Read-Host "Nhan dia chi file Script-ChangeUserName-List.csv vd: c:\Script-ChangeUserName-List.csv"
	
		If ($csvfile -ne "")
		{
		Write-Host "Processing "$csvfile
	
		$outFile = ".\UserList_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$outfileheader = "UserPrincipalName,UserPrincipalNameNew,DetailLogs"
		Out-File -FilePath $outFile -InputObject $outfileheader
		$OF = $null
		$x = $null
	
		$LogFile = ".\LogFile_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$LF = $null
	
	
		$UserList = IMPORT-CSV $csvfile -Delimiter ","
		Write-Host $UserList.count" So luong ban ghi..."
	
		
	
		$Created = 0
		$Skipped = 0
	
			FOREACH($Person in $UserList)
			{
		
				if (get-msoluser -userprincipalname $person.UserPrincipalName -erroraction silentlycontinue)
				{					
					$x = Set-MsolUserPrincipalName -UserPrincipalName $Person.UserPrincipalName -NewUserPrincipalName $Person.UserPrincipalNameNew
					$OF = $Person.UserPrincipalName + "," + $Person.UserPrincipalNameNew + "," + $Error[0].Exception.Message
					Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
					$OF = $null
					$x = $null
					$Created++	
				}
				else
				{
					$lf = $person.UserName + " khong ton tai user"
					out-file -filepath $logfile -append -noclobber -inputobject $lf
					$lf = $null
					$skipped++			
				
				}
			}
		}
		Else{
			Write-Host "Chua nhap dia chi file *.csv"
		}
		Write-Host "Da hoan thanh"
		Write-Host $Created" ban ghi da duoc update..."
		Write-Host $Skipped" ban ghi da bi bo qua..."
	
		pause
	
	}
		
	#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	# Section B: Set Roles
	#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

	4{

		#Set role multi user with "Script-SetAdminRole-tmpl.csv"
		# Param(
			# [Parameter(Mandatory=$true,Position=1,HelpMessage="Nhap dia chia file csv")][String]$csvfile = ""
		# )


		$csvfile  = Read-Host "Nhan dia chi file Script-SetAdminRole-tmpl.csv vd: c:\Script-SetAdminRole-tmpl.csv"

		If ($csvfile -ne "")
		{
		Write-Host "Processing "$csvfile

		$outFile = ".\UserRoleList_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$outfileheader = "UserPrincipalName,Role,DetailLogs"
		Out-File -FilePath $outFile -InputObject $outfileheader
		$OF = $null
		$x = $null

		$LogFile = ".\LogFile_UserRoleList_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$LF = $null


		$UserList = IMPORT-CSV $csvfile -Delimiter ","
		Write-Host $UserList.count"So luong ban ghi..."
		Write-Host ==================================================
		Write-Host UAA:  User Account Administrator - Can manage all aspects of users and groups, including resetting passwords for limited admins.
		Write-Host HA:   Helpdesk Administrator - Can reset passwords for non-administrators and Helpdesk Administrators.
		Write-Host EXA:  Exchange Service Administrator - Can manage all aspects of the Exchange product.
		Write-Host SSA:  SharePoint Service Administrator - Can manage all aspects of the SharePoint service.
		Write-Host GR:   Global Reader - Can read everything that a global admin can read but not update anything.
		Write-Host PA:   Password Administrator - Can reset passwords for non-administrators and Password Administrators.
		Write-Host GRA:  Groups Administrator - Members of this role can create/manage groups, create/manage groups settings like naming and expiration policies, and view...
		Write-Host TA:   Teams Service Administrator - Can manage the Microsoft Teams service.
		Write-Host CA:   Global Admin/Company Administrator - Can manage all aspects of Azure AD and Microsoft services that use Azure AD identities.
		Write-Host ==================================================
		Write-Host

		$UAA = "User Account Administrator"
		$HA = "Helpdesk Administrator"
		$EXA = "Exchange Service Administrator"
		$SSA = "SharePoint Service Administrator"
		$GR = "Global Reader"
		$PA = "Password Administrator"
		$GRA = "Groups Administrator"
		$TA = "Teams Service Administrator"
		$CA = "Company Administrator"

		$Created = 0
		#$Skipped = 0

		FOREACH($Person in $UserList)
		{ 	#$RoleMembers = Get-MsolRole -RoleName "Company Administrator"
		try{
			if($Person.Role -eq "UAA")
			{
				$x = Add-MsolRoleMember -RoleMemberEmailAddress $Person.UserPrincipalName -RoleName $UAA
				 $OF = $Person.UserPrincipalName + "," + $UAA + "," + $Error[0].Exception.Message
				 Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
				 $OF = $null
				 $x = $null
				 $Created++
			}elseif($Person.Role -eq "HA")
			{
				$x = Add-MsolRoleMember -RoleMemberEmailAddress $Person.UserPrincipalName -RoleName $HA
				 $OF = $Person.UserPrincipalName + "," + $HA + "," + $Error[0].Exception.Message
				 Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
				 $OF = $null
				 $x = $null
				 $Created++
			}
			elseif($Person.Role -eq "EXA")
			{
				$x = Add-MsolRoleMember -RoleMemberEmailAddress $Person.UserPrincipalName -RoleName $EXA
				 $OF = $Person.UserPrincipalName + "," + $EXA + "," + $Error[0].Exception.Message
				 Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
				 $OF = $null
				 $x = $null
				 $Created++
			}
			elseif($Person.Role -eq "SSA")
			{
				$x = Add-MsolRoleMember -RoleMemberEmailAddress $Person.UserPrincipalName -RoleName $SSA
				 $OF = $Person.UserPrincipalName + "," + $SSA + "," + $Error[0].Exception.Message
				 Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
				 $OF = $null
				 $x = $null
				 $Created++
			}
			elseif($Person.Role -eq "GR")
			{
				$x = Add-MsolRoleMember -RoleMemberEmailAddress $Person.UserPrincipalName -RoleName $GR
				 $OF = $Person.UserPrincipalName + "," + $GR + "," + $Error[0].Exception.Message
				 Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
				 $OF = $null
				 $x = $null
				 $Created++
			}
			elseif($Person.Role -eq "PA")
			{
				$x = Add-MsolRoleMember -RoleMemberEmailAddress $Person.UserPrincipalName -RoleName $PA
				 $OF = $Person.UserPrincipalName + "," + $PA + "," + $Error[0].Exception.Message
				 Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
				 $OF = $null
				 $x = $null
				 $Created++
			}
			elseif($Person.Role -eq "GRA")
			{
				$x = Add-MsolRoleMember -RoleMemberEmailAddress $Person.UserPrincipalName -RoleName $GRA
				 $OF = $Person.UserPrincipalName + "," + $GRA + "," + $Error[0].Exception.Message
				 Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
				 $OF = $null
				 $x = $null
				 $Created++
			}elseif($Person.Role -eq "TA")
			{
				$x = Add-MsolRoleMember -RoleMemberEmailAddress $Person.UserPrincipalName -RoleName $TA
				 $OF = $Person.UserPrincipalName + "," + $TA + "," + $Error[0].Exception.Message
				 Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
				 $OF = $null
				 $x = $null
				 $Created++
			}
			elseif($Person.Role -eq "CA")
			{
				$x = Add-MsolRoleMember -RoleMemberEmailAddress $Person.UserPrincipalName -RoleName $CA
				 $OF = $Person.UserPrincipalName + "," + $CA + "," + $Error[0].Exception.Message
				 Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
				 $OF = $null
				 $x = $null
				 $Created++
			}
		}
		catch {
			#Write-Host "An error occurred:"
			#Write-Host $_

			#$LF = $Person.userprincipalname + $_
			#Out-File -FilePath $LogFile -Append -NoClobber -InputObject $LF
			}
		}

		}
		else{
			Write-Host "Chua nhap dia chi file *.csv"
			$LF = $Person.UserPrincipalName + " Chua nhap dia chi file *.csv"
			Out-File -FilePath $LogFile -Append -NoClobber -InputObject $LF
		}
		Write-Host "Da hoan thanh"
		Write-Host $Created" ban ghi da duoc khoi tao..."
		#Write-Host $Skipped" ban ghi da bi bo qua..."
		pause

		}
	4.1{

		#Set role multi user with "Script-SetAdminRole-tmpl.csv"
		# Param(
			# [Parameter(Mandatory=$true,Position=1,HelpMessage="Nhap dia chia file csv")][String]$csvfile = ""
		# )


		$csvfile  = Read-Host "Nhan dia chi file Script-SetAdminRole-tmpl.csv vd: c:\Script-SetAdminRole-tmpl.csv"

		If ($csvfile -ne "")
		{
		Write-Host "Processing "$csvfile

		$outFile = ".\UserRoleList_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$outfileheader = "UserPrincipalName,Role,DetailLogs"
		Out-File -FilePath $outFile -InputObject $outfileheader
		$OF = $null
		$x = $null

		$LogFile = ".\LogFile_UserRoleList_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$LF = $null


		$UserList = IMPORT-CSV $csvfile -Delimiter ","
		Write-Host $UserList.count"So luong ban ghi..."
		Write-Host ==================================================
		Write-Host Removing all roles of users.
		Write-Host ==================================================


		$Created = 0
		#$Skipped = 0
		$Userroles = Get-MsolRole | %{$role = $_.name; Get-MsolRoleMember -RoleObjectId $_.objectid} | select @{Name="Role"; Expression = {$role}}, DisplayName, EmailAddress

		FOREACH($Person in $UserList)
		{
			FOREACH($uRole in $Userroles)
			{
				try{
					if($uRole.EmailAddress -eq $Person.UserPrincipalName)
					{
						$x = Remove-MsolRoleMember -RoleName $uRole.Role -RoleMemberType User -RoleMemberEmailAddress $Person.UserPrincipalName

						 $OF = $Person.UserPrincipalName + "," + $uRole.Role + "," + $Error[0].Exception.Message
						 Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
						 $OF = $null
						 $x = $null
						 $Created++
					}
				}
				catch{}
			}
		}
		}
		else{
			Write-Host "Chua nhap dia chi file *.csv"
			$LF = $Person.UserPrincipalName + " Chua nhap dia chi file *.csv"
			Out-File -FilePath $LogFile -Append -NoClobber -InputObject $LF
		}
		Write-Host "Da hoan thanh"
		Write-Host $Created" ban ghi da duoc khoi tao..."
		#Write-Host $Skipped" ban ghi da bi bo qua..."
		pause

		}

	#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	# Section C: Set Password never expired
	#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

	5{


	#####################################################################
	#   Set password never expired for a specific user
	#####################################################################

	# Section 1: information

	clear-host

	write-host
	write-host
	write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
	write-host  -ForegroundColor white		Information
	write-host  -ForegroundColor white		----------------------------------------------------------------------------
	write-host  -ForegroundColor white  	'This option will: '
	write-host  -ForegroundColor white  	'Set user password never expired option for a specific user '
	write-host  -ForegroundColor white  	'(By default Office 365 user password will expire every 90 days.)  '
	write-host  -ForegroundColor white		----------------------------------------------------------------------------
	write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
	write-host  -ForegroundColor Yellow  	'Set-msoluser –UserPrincipalName <user UPN> -PasswordNeverExpires $True  '
	write-host
	write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
	write-host
	write-host

						# Section 2: user input

						write-host -ForegroundColor white	'User input '
						write-host -ForegroundColor white	----------------------------------------------------------------------------
						write-host -ForegroundColor Yellow	"You will need to provide 1 parameter:"
						write-host
						write-host -ForegroundColor Yellow	"1. The Office 365 user UPN  "
						write-host -ForegroundColor Yellow	"For example:  John@o365info.com"
						write-host
						$userUPN  = Read-Host "Type the the Office 365 user UPN "
						write-host
						write-host



	# Section 3: PowerShell Command

	Set-msoluser –UserPrincipalName $userUPN -PasswordNeverExpires $True


	# Section 4:  Indication

	write-host
	write-host

	if ($lastexitcode -eq 1)
	{
		write-host "The command Failed :-(" -ForegroundColor red
	}
	else
	{
	write-host -------------------------------------------------------------
	write-host -ForegroundColor Yellow	"The command complete successfully !"
	write-host
	write-host -ForegroundColor Yellow	"The password of user: " -nonewline; write-host "$userUPN".ToUpper() -ForegroundColor White
	write-host -ForegroundColor Yellow	"was set to never expired "
	write-host -------------------------------------------------------------
	}

	#———— End of Indication ———————

	# Section 4: Display Information

	write-host
	write-host ---------------------------------------------------------------------------
	write-host -ForegroundColor white	Display Password information for the user:   "$userUPN".ToUpper()
	write-host ---------------------------------------------------------------------------

	Get-MsolUser -UserPrincipalName $userUPN  |FL  DisplayName , PasswordNeverExpires | Out-String


	#Section 5: End the Command
	write-host
	write-host
	Read-Host "Press Enter to continue..."
	write-host
	write-host

	}

	5.1{


		#####################################################################
		#   Set Password for multi user with "Script-ChangeUser-Password-tmpl.csv"
		#####################################################################
	
		# Section 1: information
	
		clear-host
	
		write-host
		write-host
		write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
		write-host  -ForegroundColor white		Information
		write-host  -ForegroundColor white		----------------------------------------------------------------------------
		write-host  -ForegroundColor white  	'This option will: '
		write-host  -ForegroundColor white  	'Set user password for multi user '
		write-host  -ForegroundColor white  	'(By default Office 365 user password will expire every 90 days.)  '
		write-host  -ForegroundColor white		----------------------------------------------------------------------------
		write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
		write-host
		write-host
		$csvfile  = Read-Host "Nhan dia chi file Script-ChangeUser-Password-tmpl.csv vd: c:\Script-ChangeUser-Password-tmpl.csv"
	
		If ($csvfile -ne "")
		{
		Write-Host "Processing "$csvfile
	
		$outFile = ".\UserList_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$outfileheader = "UserName,Password,DetailLogs"
		Out-File -FilePath $outFile -InputObject $outfileheader
		$OF = $null
		$x = $null
	
		$LogFile = ".\LogFile_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$LF = $null
	
	
		$UserList = IMPORT-CSV $csvfile -Delimiter ","
		Write-Host $UserList.count" So luong ban ghi..."
	
		
	
		$Created = 0
		$Skipped = 0
	
			FOREACH($Person in $UserList)
			{
		
				if (get-msoluser -userprincipalname $person.UserName -erroraction silentlycontinue)
				{					
					$x = Set-MsolUserPassword -UserPrincipalName $Person.UserName -NewPassword $Person.Password -ForceChangePassword $true
					$OF = $Person.UserName + "," + $Person.Password + "," + $Error[0].Exception.Message
					Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
					$OF = $null
					$x = $null
					$Created++	
				}
				else
				{
					$lf = $person.UserName + " khong ton tai user"
					out-file -filepath $logfile -append -noclobber -inputobject $lf
					$lf = $null
					$skipped++			
				
				}
			}
		}
		Else{
			Write-Host "Chua nhap dia chi file *.csv"
		}
		Write-Host "Da hoan thanh"
		Write-Host $Created" ban ghi da duoc update..."
		Write-Host $Skipped" ban ghi da bi bo qua..."
	
		pause
	
	}

	5.2{


		#####################################################################
		#   Set Password for multi user not require changing password for 1st login with "Script-ChangeUser-Password-tmpl.csv"
		#####################################################################
	
		# Section 1: information
	
		clear-host
	
		write-host
		write-host
		write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
		write-host  -ForegroundColor white		Information
		write-host  -ForegroundColor white		----------------------------------------------------------------------------
		write-host  -ForegroundColor white  	'This option will: '
		write-host  -ForegroundColor white  	'Set Password for multi user not require changing password for 1st login'
		write-host  -ForegroundColor white  	'(By default Office 365 user password will expire every 90 days.)  '
		write-host  -ForegroundColor white		----------------------------------------------------------------------------
		write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
		write-host
		write-host
		$csvfile  = Read-Host "Nhan dia chi file Script-ChangeUser-Password-tmpl.csv vd: c:\Script-ChangeUser-Password-tmpl.csv"
	
		If ($csvfile -ne "")
		{
		Write-Host "Processing "$csvfile
	
		$outFile = ".\UserList_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$outfileheader = "UserName,Password,DetailLogs"
		Out-File -FilePath $outFile -InputObject $outfileheader
		$OF = $null
		$x = $null
	
		$LogFile = ".\LogFile_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$LF = $null
	
	
		$UserList = IMPORT-CSV $csvfile -Delimiter ","
		Write-Host $UserList.count" So luong ban ghi..."
	
		
	
		$Created = 0
		$Skipped = 0
	
			FOREACH($Person in $UserList)
			{
		
				if (get-msoluser -userprincipalname $person.UserName -erroraction silentlycontinue)
				{					
					$x = Set-MsolUserPassword -UserPrincipalName $Person.UserName -NewPassword $Person.Password -ForceChangePassword $False
					$OF = $Person.UserName + "," + $Person.Password + "," + $Error[0].Exception.Message
					Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
					$OF = $null
					$x = $null
					$Created++	
				}
				else
				{
					$lf = $person.UserName + " khong ton tai user"
					out-file -filepath $logfile -append -noclobber -inputobject $lf
					$lf = $null
					$skipped++			
				
				}
			}
		}
		Else{
			Write-Host "Chua nhap dia chi file *.csv"
		}
		Write-Host "Da hoan thanh"
		Write-Host $Created" ban ghi da duoc update..."
		Write-Host $Skipped" ban ghi da bi bo qua..."
	
		pause
	
	}

	6{


	#####################################################################
	#  Disable password never expired option for a specific user
	#####################################################################

	# Section 1: information




	clear-host

	write-host
	write-host
	write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
	write-host  -ForegroundColor white		Information
	write-host  -ForegroundColor white		----------------------------------------------------------------------------
	write-host  -ForegroundColor white  	'This option will: '
	write-host  -ForegroundColor white  	'Disable the option of - Password never expired option for a specific user '
	write-host  -ForegroundColor white		----------------------------------------------------------------------------
	write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
	write-host  -ForegroundColor Yellow  	'Set-msoluser –UserPrincipalName <user UPN> -PasswordNeverExpires $False  '
	write-host
	write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
	write-host
	write-host

						# Section 2: user input

						write-host -ForegroundColor white	'User input '
						write-host -ForegroundColor white	----------------------------------------------------------------------------
						write-host -ForegroundColor Yellow	"You will need to provide 1 parameter:"
						write-host
						write-host -ForegroundColor Yellow	"1. The Office 365 user UPN  "
						write-host -ForegroundColor Yellow	"For example:  John@o365info.com"
						write-host
						$userUPN  = Read-Host "Type the the Office 365 user UPN "
						write-host
						write-host



			# Section 3: PowerShell Command

			Set-msoluser –UserPrincipalName $userUPN -PasswordNeverExpires $False



			# Section 4:  Indication

			write-host
			write-host

			if ($lastexitcode -eq 1)
			{
				write-host "The command Failed :-(" -ForegroundColor red
			}
			else
			{
			write-host -------------------------------------------------------------
			write-host -ForegroundColor Yellow	"The command complete successfully !"
			write-host
			write-host -ForegroundColor Yellow	"The password of user: " -nonewline; write-host "$userUPN".ToUpper() -ForegroundColor White
			write-host -ForegroundColor Yellow	"was set to expired "
			write-host -ForegroundColor Yellow	"(By default Office 365 user password will expire every 90 days.)  "
			write-host -------------------------------------------------------------
			}

			#———— End of Indication ———————

			# Section 4: Display Information

			write-host
			write-host ---------------------------------------------------------------------------
			write-host -ForegroundColor white	Display Password information for the user:  "$userUPN".ToUpper()
			write-host ---------------------------------------------------------------------------

			Get-MsolUser -UserPrincipalName $userUPN  |FL  DisplayName , PasswordNeverExpires | Out-String


			#Section 5: End the Command
			write-host
			write-host
			Read-Host "Press Enter to continue..."
			write-host
			write-host

	}

	7{


	#####################################################################
	#  Set Password never expired for all Office 365 users (BULK Mode)
	#####################################################################

	# Section 1: information

	clear-host

	write-host
	write-host
	write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
	write-host  -ForegroundColor white		Information
	write-host  -ForegroundColor white		----------------------------------------------------------------------------
	write-host  -ForegroundColor white  	'This option will: '
	write-host  -ForegroundColor white  	'Set user password NEVER expired option for ALL Office 365 users '
	write-host  -ForegroundColor white  	'(By default Office 365 user password will expire every 90 days.)  '
	write-host  -ForegroundColor white  	'Be Patience, it will take some time :-) '
	write-host  -ForegroundColor white  	'(Depend on the number of Office 365 users) '
	write-host  -ForegroundColor white		----------------------------------------------------------------------------
	write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
	write-host  -ForegroundColor Yellow  	'Get-MsolUser | Set-MsolUser –PasswordNeverExpires $True  '
	write-host
	write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
	write-host
	write-host


	# Section 2: user input


	# Section 3: PowerShell Command

	Get-MsolUser | Set-MsolUser –PasswordNeverExpires $True



	# Section 4:  Indication

	write-host
	write-host

	if ($lastexitcode -eq 1)
	{
		write-host "The command Failed :-(" -ForegroundColor red
	}
	else
	{
	write-host -------------------------------------------------------------
	write-host -ForegroundColor Yellow	"The command complete successfully !"
	write-host
	write-host -ForegroundColor Yellow	"The password for all Office 365 users was set to NEVER expired "
	write-host -------------------------------------------------------------
	}

	#———— End of Indication ———————

	# Section 4: Display Information
	write-host
	write-host
	write-host ------------------------------------------------------
	write-host List of all users and their Password settings -ForegroundColor white
	write-host -------------------------------------------------------

	Get-MsolUser | Select UserPrincipalName, PasswordNeverExpires | Out-String
	write-host
	write-host
	write-host -------------------------------------------------------


	#Section 5: End the Command
	write-host
	write-host
	Read-Host "Press Enter to continue..."
	write-host
	write-host

	}



	
	#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	# Section D: Troubleshooting
	#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

	8{

	####################################################################################################
	# Export information: MEGA EXPORT: Exchange online + Office 365 objects
	######################################################################################################



	# Section 1: information

	clear-host

	write-host
	write-host
	write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
	write-host  -ForegroundColor white		Information
	write-host  -ForegroundColor white		----------------------------------------------------------------------------
	write-host  -ForegroundColor white  	'This option will: '
	write-host  -ForegroundColor white  	'Export information: MEGA EXPORT: Exchange online + Office 365 objects  '
	write-host  -ForegroundColor white		----------------------------------------------------------------------------
	write-host  -ForegroundColor white  	'The export command will create a folder named: INFO in c:\ drive '
	write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
	write-host





	#----------------------------------------------------------
	# AD Azure Online objects
	#----------------------------------------------------------

	#----------------------------------------------------------
	# Office_365_objects


	$B =    "C:\INFO\1.Office 365 info"
	$B1A =  "C:\INFO\1.Office 365 info\Reports"




	if (!(Test-Path -path $B1A ))
	{
	New-Item $B1A -type directory
	}


	#----------------------------------------------------------

	#___________________________________________________
	# 2.Office 365 info\2.1 All object
	#___________________________________________________

	#----------------------------------------------------------
	#@@@@@@@@@@ Get-MsolUser @@@@@@@@@

	###TXT####
	Get-MsolUser -all | Select UserPrincipalName, PasswordNeverExpires  >$B1\"Msoluser Password settings.txt"
	##########

	###CSV####
	Get-MsolUser -all | Select UserPrincipalName, PasswordNeverExpires  |  Export-CSV $B1A\"Msoluser Password settings.CSV"
	##########


	###HTML####
	Get-MsolUser -all | Select UserPrincipalName, PasswordNeverExpires  | ConvertTo-Html -head $htstyle -Body "<H1>Office 365 users - Password settings</H1>"   | Out-File $B1A\"Msoluser Password settings.html"
	##########

	#----------------------------------------------------------



	pause


	}



	#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	# Section E: Delete Account
	#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

	9{

	# Param (
		# [Parameter(Mandatory=$true,Position=1,HelpMessage="Duong dan tro toi file CSV danh sach nguoi dung can xoa")][String]$csvfile = ""
	# )

	$csvfile  = Read-Host "Nhan dia chi file Script-DeleteUser-List.csv vd: c:\Script-DeleteUser-List.csv"


	#Neu khong co file CSV, tu dong thoat ra
	if($csvfile -eq "")
		{
			write-host -ForegroundColor Red "Chon duong dan tro toi file CSV da chuan bi san roi lam lai..."
			exit 0
		}

	#Starting
	Write-Host "Processing "$csvfile

	####Logfile

	$OF = $null
	$x = $null

	$LogFile = ".\LogFile_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
	$LF = $null

	#Import user list
	$UserList = IMPORT-CSV $csvfile -Delimiter ","
	Write-Host $UserList.count"So luong ban ghi..."

	#counter to count completed records
	$Deleted = 0
	$Skipped = 0

	####Loop thru each record
	FOREACH ($Person in $UserList) {

	If (Get-MsolUser -UserPrincipalName $Person.UserPrincipalName -ErrorAction SilentlyContinue)
	{
		$x = Remove-MsolUser -UserPrincipalName $Person.UserPrincipalName -Force
		$x = $null
		$Deleted++
	}
	Else
	{
		$LF = $Person.UserPrincipalName + "Khong ton tai de xoa"
		Out-File -FilePath $LogFile -Append -NoClobber -InputObject $LF
		$LF = $null
		$Skipped++
	}


	}

	Write-Host "Da hoan thanh"
	Write-Host $Deleted" ban ghi da bi xoa..."
	Write-Host $Skipped" ban ghi da bi bo qua..."
	Pause

	}
	
	9.1{
		
		#Starting
		Write-Host "Processing... "

		####Logfile

		$OF = $null
		$x = $null

		$LogFile = ".\LogFile_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$LF = $null


		#counter to count completed records
		$Deleted = 0		
		

		
		$x = Get-MsolUser -all -ReturnDeletedUsers | Remove-MsolUser -RemoveFromRecycleBin -Force
		$Deleted++
		

		Write-Host "Da hoan thanh"
		Write-Host $Deleted " ban ghi da bi xoa..."
		Pause

		}


	#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	# Section F: ReAssign Licenses
	#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


	10{

	
	# Param(
		# [Parameter(Mandatory=$true,Position=1,HelpMessage="Duong dan tro toi file CSV danh sach nguoi dung can xoa")][String]$csvfile = ""
	# )
	$csvfile  = Read-Host "Nhan dia chi file Script-ReAssignLicenses-List-tmpl.csv vd: c:\Script-ReAssignLicenses-List-tmpl.csv"

	#Neu khong co file CSV, tu dong thoat ra
	if ($csvfile -eq "")
		{
			write-host -ForegroundColor Red "Chon duong dan tro toi file CSV da chuan bi san roi lam lai..."
			exit 0
		}

	#Starting
	Write-Host "Processing "$csvfile

	####Logfile

	$OF = $null
	$x = $null

	$LogFile = ".\LogFile_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
	$LF = $null

	#Import user list
	$UserList = IMPORT-CSV $csvfile -Delimiter ","
	Write-Host $UserList.count"So luong ban ghi..."

	#counter to count completed records
	$Assinged = 0
	$Skipped = 0

	####Loop thru each record
	FOREACH ($Person in $UserList) {

	If (Get-MsolUser -UserPrincipalName $Person.UserPrincipalName -ErrorAction SilentlyContinue)
	{
		if($Person.Licenses -eq "EDU1")
		{
			$x = Set-MsolUserLicense -UserPrincipalName $Person.UserPrincipalName -AddLicenses $EDU1
			$x = $null
			$Assigned++	
		}
		elseif($Person.Licenses -eq "EDU2")
		{
			$x = Set-MsolUserLicense -UserPrincipalName $Person.UserPrincipalName -AddLicenses $EDU2
			$x = $null
			$Assigned++	
		}
		elseif($Person.Licenses -eq "EDU3")
		{
			$x = Set-MsolUserLicense -UserPrincipalName $Person.UserPrincipalName -AddLicenses $EDU3
			$x = $null
			$Assigned++	
		}
		elseif($Person.Licenses -eq "EDU4")
		{
			$x = Set-MsolUserLicense -UserPrincipalName $Person.UserPrincipalName -AddLicenses $EDU4
			$x = $null
			$Assigned++	
		}
		elseif($Person.Licenses -eq "EDU5")
		{
			$x = Set-MsolUserLicense -UserPrincipalName $Person.UserPrincipalName -AddLicenses $EDU5
			$x = $null
			$Assigned++	
		}
		elseif($Person.Licenses -eq "EDU6")
		{
			$x = Set-MsolUserLicense -UserPrincipalName $Person.UserPrincipalName -AddLicenses $EDU6
			$x = $null
			$Assigned++	
		}		
	}
	Else
	{
		$LF = $Person.UserPrincipalName + "Khong ton tai de gan license"
		Out-File -FilePath $LogFile -Append -NoClobber -InputObject $LF
		$LF = $null
		$Skipped++
	}

	}

	Write-Host "Da hoan thanh"
	Write-Host -ForegroundColor Green $Deteted" ban ghi nguoi dung da duoc gan License moi, vui long xem file Log de biet chi tiet..."
	Write-Host $Assinged" ban ghi nguoi dung da bi bo qua..."

	Pause

	}



	10.1{
	
	$csvfile  = Read-Host "Nhan dia chi file Script-ReAssignLicenses-List-tmpl.csv vd: c:\Script-ReAssignLicenses-List-tmpl.csv"

	#Neu khong co file CSV, tu dong thoat ra
	if ($csvfile -eq "")
		{
			write-host -ForegroundColor Red "Chon duong dan tro toi file CSV da chuan bi san roi lam lai..."
			exit 0
		}

	#Starting
	Write-Host "Processing "$csvfile

	####Logfile

	$OF = $null
	$x = $null

	$LogFile = ".\LogFile_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
	$LF = $null

	#Import user list
	$UserList = IMPORT-CSV $csvfile -Delimiter ","
	Write-Host $UserList.count"So luong ban ghi..."

	#counter to count completed records
	$Assinged = 0
	$Skipped = 0
	
	
 
	foreach ($user in $UserList) {
		Write-Verbose "Processing licenses for user $($user.UserPrincipalName)"
		try { $user = Get-MsolUser -UserPrincipalName $user.UserPrincipalName -ErrorAction Stop }
		catch { continue }
		 
		$SKUs = @($user.Licenses)
		if (!$SKUs) { Write-Verbose "No Licenses found for user $($user.UserPrincipalName), skipping..." ; continue }
		 
		foreach ($SKU in $SKUs) {
			if (($SKU.GroupsAssigningLicense.Guid -ieq $user.ObjectId.Guid) -or (!$SKU.GroupsAssigningLicense.Guid)) {
				Write-Verbose "Removing license $($Sku.AccountSkuId) from user $($user.UserPrincipalName)"
				Set-MsolUserLicense -UserPrincipalName $user.UserPrincipalName -RemoveLicenses $SKU.AccountSkuId
				$x = $null
				$Assigned++	
			}
			else {
			#Write-Host "Da hoan thanh"
			#Write-Host -ForegroundColor Green $Deteted" ban ghi nguoi dung da duoc REMOVE License, vui long xem file Log de biet chi tiet..."
			#Write-Host $Assinged" ban ghi nguoi dung da bi bo qua..."
			#Write-Verbose "License $($Sku.AccountSkuId) is assigned via Group, use the Azure AD blade to remove it!"
			continue
			}
			
			$LF = $user.UserPrincipalName + "Da remove license!"
			Out-File -FilePath $LogFile -Append -NoClobber -InputObject $LF
			$LF = $null
			$Skipped++
		
		}
	}			
	
			Write-Host "Da hoan thanh"
			Write-Host -ForegroundColor Green $Deteted" ban ghi nguoi dung da duoc REMOVE License, vui long xem file Log de biet chi tiet..."
			Write-Host $Assinged" ban ghi nguoi dung da bi bo qua..."
			Pause
	}

		#+++++++++++++++++++
		# Step Finish
		##++++++++++++++++++

	11{
	##########################################
	# Prevent normal users create team/group/planner/sharepoint
	##########################################
	Write-Host ==================================================
	Write-Host 1. This command will create an ALLOW TEAMS CREATION group
	Write-Host and Prevent normal users create team/group/planner/sharepoint
	Write-Host 2. To allow create team/group/planner, you need add users to ALLOW TEAM CREATION groups!
	Write-Host You can use (14.2) command to add users into ALLOW TEAM CREATION groups
	Write-Host ==================================================
	Write-Host
	#Create Security group
	try{
		if (get-msolgroup -all | where {$_.Displayname -eq "Allow Team Creation"} -erroraction silentlycontinue)
		{	
			Write-Host "The group: Allow Team Creation is already exist!"
		}else{
			$logincm = New-MsolGroup -DisplayName "Allow Team Creation" -Description "Allow create team/group/planner..."
			Write-Host "Created Allow Team Creation group"
		}
		
	}
	catch{
		Write-Host "Error: " + $logincm[0].Exception.Message
	}
	#set permission

		$GroupName = "Allow Team Creation"
		$AllowGroupCreation = "False"

		$settingsObjectID = (Get-AzureADDirectorySetting | Where-object -Property Displayname -Value "Group.Unified" -EQ).id
		if(!$settingsObjectID)
		{
			$template = Get-AzureADDirectorySettingTemplate | Where-object {$_.displayname -eq "group.unified"}
			$settingsCopy = $template.CreateDirectorySetting()
			New-AzureADDirectorySetting -DirectorySetting $settingsCopy
			$settingsObjectID = (Get-AzureADDirectorySetting | Where-object -Property Displayname -Value "Group.Unified" -EQ).id
		}

		$settingsCopy = Get-AzureADDirectorySetting -Id $settingsObjectID
		$settingsCopy["EnableGroupCreation"] = $AllowGroupCreation

		if($GroupName)
		{
			$settingsCopy["GroupCreationAllowedGroupId"] = (Get-AzureADGroup -SearchString $GroupName).objectid
		}
		 else {
			$settingsCopy["GroupCreationAllowedGroupId"] = $GroupName
		}
		Set-AzureADDirectorySetting -Id $settingsObjectID -DirectorySetting $settingsCopy

		(Get-AzureADDirectorySetting -Id $settingsObjectID).Values

		Write-Host "To allow create team/group/planner, you need add users to ALLOW TEAM CREATION Groups."
		Pause
	}
	
	11.1{
	##########################################
	# Allow normal users create team/group/planner/sharepoint
	##########################################
	Write-Host ==================================================
	Write-Host This command will delete ALLOW TEAMS CREATION group
	Write-Host and allow normal users create team/group/planner/sharepoint
	Write-Host ==================================================
	Write-Host
	#Delete Security group
	try{
		if (get-msolgroup -all | where {$_.Displayname -eq "Allow Team Creation"} -erroraction silentlycontinue)
		{	
			$GroupId = $securityGroup = Get-MsolGroup -All -GroupType "Security" | Where-Object {$_.DisplayName -eq "Allow Team Creation"}
			Remove-MsolGroup -objectid $securityGroup.ObjectId -Force
			Write-Host "Deleted group: Allow Team Creation"
		}else{
			Write-Host "The group: Allow Team Creation is NOT exist!"
		}
	}
	catch{
		Write-Host "Error: " + $logincm[0].Exception.Message
	}
	
	#set permission

		$GroupName = ""
		$AllowGroupCreation = "True"

		$settingsObjectID = (Get-AzureADDirectorySetting | Where-object -Property Displayname -Value "Group.Unified" -EQ).id
		if(!$settingsObjectID)
		{
			$template = Get-AzureADDirectorySettingTemplate | Where-object {$_.displayname -eq "group.unified"}
			$settingsCopy = $template.CreateDirectorySetting()
			New-AzureADDirectorySetting -DirectorySetting $settingsCopy
			$settingsObjectID = (Get-AzureADDirectorySetting | Where-object -Property Displayname -Value "Group.Unified" -EQ).id
		}

		$settingsCopy = Get-AzureADDirectorySetting -Id $settingsObjectID
		$settingsCopy["EnableGroupCreation"] = $AllowGroupCreation

		if($GroupName)
		{
			$settingsCopy["GroupCreationAllowedGroupId"] = (Get-AzureADGroup -SearchString $GroupName).objectid
		}
		 else {
			$settingsCopy["GroupCreationAllowedGroupId"] = $GroupName
		}
		Set-AzureADDirectorySetting -Id $settingsObjectID -DirectorySetting $settingsCopy

		(Get-AzureADDirectorySetting -Id $settingsObjectID).Values

		Write-Host "All users can create team/group/planner/sharepoint now."
		Pause
	}
	
	11.2{
	##########################################
	# Add users into ALLOW TEAM CREATION group with "Script-AddUser-intoGroup-tmpl.csv"
	##########################################
		$csvfile  = Read-Host "Nhan dia chi file Script-AddUser-intoGroup-tmpl.csv vd: c:\Script-AddUser-intoGroup-tmpl.csv"

		If ($csvfile -ne "")
		{
			Write-Host "Processing "$csvfile

			$outFile = ".\UserList_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
			$outfileheader = "UserPrincipalName,Group,DetailLogs"
			Out-File -FilePath $outFile -InputObject $outfileheader
			$OF = $null
			$x = $null

			$LogFile = ".\LogFile_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
			$LF = $null


			$UserList = IMPORT-CSV $csvfile -Delimiter ","
			Write-Host $UserList.count"So luong ban ghi..."
			Write-Host ==================================================
			Write-Host This command will add users from Script-AddUser-intoGroup-tmpl.csv file
			Write-Host into ALLOW TEAMS CREATION group.
			Write-Host Note: (14.2) is supported for (14).
			Write-Host ==================================================
			Write-Host
			

			$Created = 0
			$Skipped = 0		
			
			
			$group = get-msolgroup -all | where {$_.Displayname -eq "Allow Team Creation"}
			if (get-msolgroup -all | where {$_.Displayname -eq "Allow Team Creation"} -erroraction silentlycontinue)
			{
				$securityGroup = Get-MsolGroup -all -GroupType "Security" | Where-Object {$_.DisplayName -eq "Allow Team Creation"}
				foreach($person in $UserList)
				{				
					$member = Get-MsolUser -UserPrincipalName $person.UserPrincipalName
					$runCM = Add-MsolGroupMember -GroupObjectId $securityGroup.ObjectId -GroupMemberType "User" -GroupMemberObjectId $member.ObjectId
					
					$OF = $person.UserPrincipalName + "," + "Allow Team Creation" + "," + $Error[0].Exception.Message
					Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
					$OF = $null
					$x = $null
					$Created++		
				}
			
			}
			else
			{
			 $lf = " Group " + "Allow Team Creation" + " khong ton tai!"
			 out-file -filepath $logfile -append -noclobber -inputobject $lf
			 $lf = $null
			 $skipped++
			}
			

		}
		Else{
			Write-Host "Chua nhap dia chi file *.csv"
		}
		Write-Host "Da hoan thanh"
		Write-Host $Created" ban ghi da duoc khoi tao..."
		Write-Host $Skipped" ban ghi da bi bo qua..."

		pause


	}

	11.3{
		##########################################
		# Auto Add users with A1 Faculty licenses into ALLOW TEAM CREATION group
		##########################################

		$outFile = ".\UserList_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$outfileheader = "UserPrincipalName,Group,DetailLogs"
		Out-File -FilePath $outFile -InputObject $outfileheader
		$OF = $null
		$x = $null

		$LogFile = ".\LogFile_{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)
		$LF = $null

		Write-Host ==================================================
		Write-Host This command will add all users with A1 Faculty licenses into ALLOW TEAM CREATION group
		Write-Host ==================================================
		Write-Host

		$Created = 0
		$Skipped = 0		

		$typeOfLicense = $EDU1
		$liceneseType = @{n="Licenses Type";e={$_.Licenses.AccountSKUid}}
		$proxyUser = @{n="ProxyAddresses";e={$_.ProxyAddresses}}
		$UserWithA1Faculty = Get-MsolUser -All |Where {$_.IsLicensed -eq $true } |Select DisplayName,UsageLocation,$liceneseType,SignInName,UserPrincipalName,$proxyUser
		$group = get-msolgroup -all | where {$_.Displayname -eq "Allow Team Creation"}
		if (get-msolgroup -all | where {$_.Displayname -eq "Allow Team Creation"} -erroraction silentlycontinue)
		{
			$securityGroup = Get-MsolGroup -all -GroupType "Security" | Where-Object {$_.DisplayName -eq "Allow Team Creation"}
			ForEach ($User in $UserWithA1Faculty)
			{
				#Filter user with A1 Faculty license
				if( $User.'Licenses Type' -eq $typeOfLicense )
				{
					$member = Get-MsolUser -UserPrincipalName $User.UserPrincipalName
					$runCM = Add-MsolGroupMember -GroupObjectId $securityGroup.ObjectId -GroupMemberType "User" -GroupMemberObjectId $member.ObjectId
					
					$OF = $User.UserPrincipalName + "," + "Allow Team Creation" + "," + $Error[0].Exception.Message
					Out-File -FilePath $OutFile -Append -NoClobber -InputObject $OF
					$OF = $null
					$x = $null
					$Created++
						
				}
			}
		}
		else
		{
			$lf = " Group " + "Allow Team Creation" + " khong ton tai! You have to run 14 first!"
			out-file -filepath $logfile -append -noclobber -inputobject $lf
			$lf = $null
			$skipped++
		}
		
		Write-Host "Da hoan thanh"
		Write-Host $Created" ban ghi da duoc khoi tao..."
		Write-Host $Skipped" ban ghi da bi bo qua..."

		pause		
	}
	
	03{

	##########################################
	# Disconnect PowerShell session
	##########################################


	write-host -ForegroundColor Yellow Choosing this option will Disconnect the current PowerShell session

	Disconnect-AzureAD
	Function Disconnect-ExchangeOnline {Get-PSSession | Where-Object {$_.ConfigurationName -eq "Microsoft.Exchange"} | Remove-PSSession}
	Disconnect-ExchangeOnline -confirm

	write-host
	write-host

	#———— Indication ———————

	if ($lastexitcode -eq 0)
	{
		write-host -------------------------------------------------------------
		write-host "The command complete successfully !" -ForegroundColor Yellow
		write-host "The PowerShell session is disconnected" -ForegroundColor Yellow
		write-host -------------------------------------------------------------
	}
	else

	{
		write-host "The command Failed :-(" -ForegroundColor red

	}

	#———— End of Indication ———————


	}




	0{

	##########################################
	# Exit
	##########################################


	$Loop = $true
	Exit
	}

}


}

