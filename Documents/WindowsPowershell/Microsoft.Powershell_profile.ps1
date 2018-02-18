<#-----------------------------------------------------------------------------
�y�֐��̈�z
-----------------------------------------------------------------------------#>
cd ($NS_DIR="C:\Users\hiroya\Documents\NaughtySlave\")

<#-------------------------------------
[�A�Z���u���ǂݍ���]
-------------------------------------#>
Add-Type -AssemblyName System.Windows.Forms

<#-------------------------------------
[�S�Ă̊֐��ǂݍ���]
-------------------------------------#>
ls $NS_DIR*.ps1 -name|%{. $NS_DIR$_}

<#-----------------------------------------------------------------------------
�y��������`�̈�z
-----------------------------------------------------------------------------#>
cd ($WBS_DIR="C:\Users\hiroya\Documents\WBS")

<#-------------------------------------
[���K�w��ProjectList�쐬]
-------------------------------------#>
CreateDirInfo -WorkDir $WBS_DIR -Header "DummyCode,AreaCode,ProjectCode,WorkDir" -OutFile "ProjectList.csv"

<#-------------------------------------
[���K�w��WorkList�쐬]
-------------------------------------#>
ipcsv ProjectList.csv -Encoding Default|%{
	pushd $_.WorkDir
	CreateDirInfo -Header "AreaCode,ProjectCode,WorkCode,WorkDir" -OutFile "_WorkList.csv"
<#-------------------------------------
[���K�w��DefineSheet�쐬]
-------------------------------------#>
	ls -name *.csv -Exclude _*|%{CreateDefineSheet $_}
	popd
}
<#-------------------------------------
[���K�w�ɂ�WBS�쐬]
-------------------------------------#>
ls -dir -name|%{
	$WBS+=(ipcsv (Join-Path $_ _WorkList.csv) -Encoding Default)}
	$WBS|select AreaCode,ProjectCode,WorkCode,WorkDir|Export-CSV WBS.csv -Encoding Default -NoTypeInformation
	ls -name *.csv -Exclude _*|%{$DataList+=@{$_=(ipcsv $_ -Encoding Default)}
}

<#-----------------------------------------------------------------------------
�y���S�������̈�z
-----------------------------------------------------------------------------#>
cd ($DB_DIR="C:\Users\hiroya\Documents\My Data Sources\")

<#-------------------------------------
[���K�w��DataBaseList�쐬]
-------------------------------------#>
CreateDirInfo -WorkDir $DB_DIR -Header "DummyCode,AreaCode,DataBaseCode,WorkDir" -OutFile "DataBaseList.csv"

<#-------------------------------------
[���K�w��TableList�쐬]
-------------------------------------#>
ipcsv DataBaseList.csv -Encoding Default|%{
	pushd $_.WorkDir
	createdirinfo -Header "AreaCode,DataBaseCode,TableCode,WorkDir" -OutFile "_TableList.csv"
<#-------------------------------------
[���K�w�̊eCSV�t�@�C����$DataList�ɉ�����]
-------------------------------------#>
	ls -name *.csv -Exclude _*|%{$DataList+=@{$_=(ipcsv $_ -Encoding Default)}}
	popd
}

<#-------------------------------------
[���K�w�ɂ�TableList����]
-------------------------------------#>
ls -dir -name|%{
	$TableList+=(ipcsv (join-path $_ _TableList.csv) -Encoding Default)}
	$TableList|select AreaCode,DataBaseCode,TableCode,WorkDir|Export-Csv TableList.csv -Encoding Default -NoTypeInformation
	ls -name *.csv -Exclude _*|%{$DataList+=@{$_=(ipcsv $_ -Encoding Default)}
}

<#-------------------------------------
[�ċA�I�ɊeTable�ɔz�u���ꂽTicket�����s]
-------------------------------------#>
$TableList|%{
	pushd $_.WorkDir;
	if(Test-Path _TicketList_1.Path.csv){ExeTicketPath};
	if(Test-Path _TicketList_2.File.csv){ExeTicketFile};
	if(Test-Path _TicketList_3.Data.csv){ExeTicketData};
	popd
}

<#-------------------------------------
[���t�n�ϐ���`]
-------------------------------------#>
Set-variable -name YYYYMM -value (Get-Date).ToString("yyyyMM") -option constant
Set-variable -name YYYYMMDD -value (Get-Date).ToString("yyyyMMdd") -option constant

<#-------------------------------------
[Alias��`]
<#-----------------------------------#>
$DataList.'AppList.csv'|%{if($_.AliasCode){Set-Alias $_.AliasCode $_.ExeCode}}

<#-------------------------------------
[Excel��Display�A���[�g����]
-------------------------------------#>
(New-Object -ComObject Excel.Application).DisplayAlerts=$false

