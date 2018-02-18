<#-----------------------------------------------------------------------------
yŠÖ”—Ìˆæz
-----------------------------------------------------------------------------#>
cd ($NS_DIR="C:\Users\hiroya\Documents\NaughtySlave\")

<#-------------------------------------
[ƒAƒZƒ“ƒuƒŠ“Ç‚Ýž‚Ý]
-------------------------------------#>
Add-Type -AssemblyName System.Windows.Forms

<#-------------------------------------
[‘S‚Ä‚ÌŠÖ”“Ç‚Ýž‚Ý]
-------------------------------------#>
ls $NS_DIR*.ps1 -name|%{. $NS_DIR$_}

<#-----------------------------------------------------------------------------
yŽ©“®‰»’è‹`—Ìˆæz
-----------------------------------------------------------------------------#>
cd ($WBS_DIR="C:\Users\hiroya\Documents\WBS")

<#-------------------------------------
[‘æˆêŠK‘w‚ÉProjectListì¬]
-------------------------------------#>
CreateDirInfo -WorkDir $WBS_DIR -Header "DummyCode,AreaCode,ProjectCode,WorkDir" -OutFile "ProjectList.csv"

<#-------------------------------------
[‘æ“ñŠK‘w‚ÉWorkListì¬]
-------------------------------------#>
ipcsv ProjectList.csv -Encoding Default|%{
	pushd $_.WorkDir
	CreateDirInfo -Header "AreaCode,ProjectCode,WorkCode,WorkDir" -OutFile "_WorkList.csv"
<#-------------------------------------
[‘æ“ñŠK‘w‚ÉDefineSheetì¬]
-------------------------------------#>
	ls -name *.csv -Exclude _*|%{CreateDefineSheet $_}
	popd
}
<#-------------------------------------
[‘æˆêŠK‘w‚É‚ÄWBSì¬]
-------------------------------------#>
ls -dir -name|%{
	$WBS+=(ipcsv (Join-Path $_ _WorkList.csv) -Encoding Default)}
	$WBS|select AreaCode,ProjectCode,WorkCode,WorkDir|Export-CSV WBS.csv -Encoding Default -NoTypeInformation
	ls -name *.csv -Exclude _*|%{$DataList+=@{$_=(ipcsv $_ -Encoding Default)}
}

<#-----------------------------------------------------------------------------
yŠ®‘SŽ©“®‰»—Ìˆæz
-----------------------------------------------------------------------------#>
cd ($DB_DIR="C:\Users\hiroya\Documents\My Data Sources\")

<#-------------------------------------
[‘æˆêŠK‘w‚ÉDataBaseListì¬]
-------------------------------------#>
CreateDirInfo -WorkDir $DB_DIR -Header "DummyCode,AreaCode,DataBaseCode,WorkDir" -OutFile "DataBaseList.csv"

<#-------------------------------------
[‘æ“ñŠK‘w‚ÉTableListì¬]
-------------------------------------#>
ipcsv DataBaseList.csv -Encoding Default|%{
	pushd $_.WorkDir
	createdirinfo -Header "AreaCode,DataBaseCode,TableCode,WorkDir" -OutFile "_TableList.csv"
<#-------------------------------------
[‘æ“ñŠK‘w‚ÌŠeCSVƒtƒ@ƒCƒ‹‚ð$DataList‚É‰Á‚¦‚é]
-------------------------------------#>
	ls -name *.csv -Exclude _*|%{$DataList+=@{$_=(ipcsv $_ -Encoding Default)}}
	popd
}

<#-------------------------------------
[‘æˆêŠK‘w‚É‚ÄTableList“‡]
-------------------------------------#>
ls -dir -name|%{
	$TableList+=(ipcsv (join-path $_ _TableList.csv) -Encoding Default)}
	$TableList|select AreaCode,DataBaseCode,TableCode,WorkDir|Export-Csv TableList.csv -Encoding Default -NoTypeInformation
	ls -name *.csv -Exclude _*|%{$DataList+=@{$_=(ipcsv $_ -Encoding Default)}
}

<#-------------------------------------
[Ä‹A“I‚ÉŠeTable‚É”z’u‚³‚ê‚½Ticket‚ðŽÀs]
-------------------------------------#>
$TableList|%{
	pushd $_.WorkDir;
	if(Test-Path _TicketList_1.Path.csv){ExeTicketPath};
	if(Test-Path _TicketList_2.File.csv){ExeTicketFile};
	if(Test-Path _TicketList_3.Data.csv){ExeTicketData};
	popd
}

<#-------------------------------------
[“ú•tŒn•Ï”’è‹`]
-------------------------------------#>
Set-variable -name YYYYMM -value (Get-Date).ToString("yyyyMM") -option constant
Set-variable -name YYYYMMDD -value (Get-Date).ToString("yyyyMMdd") -option constant

<#-------------------------------------
[Alias’è‹`]
<#-----------------------------------#>
$DataList.'AppList.csv'|%{if($_.AliasCode){Set-Alias $_.AliasCode $_.ExeCode}}

<#-------------------------------------
[Excel‚ÌDisplayƒAƒ‰[ƒgÁ‚·]
-------------------------------------#>
(New-Object -ComObject Excel.Application).DisplayAlerts=$false

