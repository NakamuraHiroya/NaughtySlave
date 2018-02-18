<#-----------------------------------------------------------------------------
【関数領域】
-----------------------------------------------------------------------------#>
cd ($NS_DIR="C:\Users\hiroya\Documents\NaughtySlave\")

<#-------------------------------------
[アセンブリ読み込み]
-------------------------------------#>
Add-Type -AssemblyName System.Windows.Forms

<#-------------------------------------
[全ての関数読み込み]
-------------------------------------#>
ls $NS_DIR*.ps1 -name|%{. $NS_DIR$_}

<#-----------------------------------------------------------------------------
【自動化定義領域】
-----------------------------------------------------------------------------#>
cd ($WBS_DIR="C:\Users\hiroya\Documents\WBS")

<#-------------------------------------
[第一階層にProjectList作成]
-------------------------------------#>
CreateDirInfo -WorkDir $WBS_DIR -Header "DummyCode,AreaCode,ProjectCode,WorkDir" -OutFile "ProjectList.csv"

<#-------------------------------------
[第二階層にWorkList作成]
-------------------------------------#>
ipcsv ProjectList.csv -Encoding Default|%{
	pushd $_.WorkDir
	CreateDirInfo -Header "AreaCode,ProjectCode,WorkCode,WorkDir" -OutFile "_WorkList.csv"
<#-------------------------------------
[第二階層にDefineSheet作成]
-------------------------------------#>
	ls -name *.csv -Exclude _*|%{CreateDefineSheet $_}
	popd
}
<#-------------------------------------
[第一階層にてWBS作成]
-------------------------------------#>
ls -dir -name|%{
	$WBS+=(ipcsv (Join-Path $_ _WorkList.csv) -Encoding Default)}
	$WBS|select AreaCode,ProjectCode,WorkCode,WorkDir|Export-CSV WBS.csv -Encoding Default -NoTypeInformation
	ls -name *.csv -Exclude _*|%{$DataList+=@{$_=(ipcsv $_ -Encoding Default)}
}

<#-----------------------------------------------------------------------------
【完全自動化領域】
-----------------------------------------------------------------------------#>
cd ($DB_DIR="C:\Users\hiroya\Documents\My Data Sources\")

<#-------------------------------------
[第一階層にDataBaseList作成]
-------------------------------------#>
CreateDirInfo -WorkDir $DB_DIR -Header "DummyCode,AreaCode,DataBaseCode,WorkDir" -OutFile "DataBaseList.csv"

<#-------------------------------------
[第二階層にTableList作成]
-------------------------------------#>
ipcsv DataBaseList.csv -Encoding Default|%{
	pushd $_.WorkDir
	createdirinfo -Header "AreaCode,DataBaseCode,TableCode,WorkDir" -OutFile "_TableList.csv"
<#-------------------------------------
[第二階層の各CSVファイルを$DataListに加える]
-------------------------------------#>
	ls -name *.csv -Exclude _*|%{$DataList+=@{$_=(ipcsv $_ -Encoding Default)}}
	popd
}

<#-------------------------------------
[第一階層にてTableList統合]
-------------------------------------#>
ls -dir -name|%{
	$TableList+=(ipcsv (join-path $_ _TableList.csv) -Encoding Default)}
	$TableList|select AreaCode,DataBaseCode,TableCode,WorkDir|Export-Csv TableList.csv -Encoding Default -NoTypeInformation
	ls -name *.csv -Exclude _*|%{$DataList+=@{$_=(ipcsv $_ -Encoding Default)}
}

<#-------------------------------------
[再帰的に各Tableに配置されたTicketを実行]
-------------------------------------#>
$TableList|%{
	pushd $_.WorkDir;
	if(Test-Path _TicketList_1.Path.csv){ExeTicketPath};
	if(Test-Path _TicketList_2.File.csv){ExeTicketFile};
	if(Test-Path _TicketList_3.Data.csv){ExeTicketData};
	popd
}

<#-------------------------------------
[日付系変数定義]
-------------------------------------#>
Set-variable -name YYYYMM -value (Get-Date).ToString("yyyyMM") -option constant
Set-variable -name YYYYMMDD -value (Get-Date).ToString("yyyyMMdd") -option constant

<#-------------------------------------
[Alias定義]
<#-----------------------------------#>
$DataList.'AppList.csv'|%{if($_.AliasCode){Set-Alias $_.AliasCode $_.ExeCode}}

<#-------------------------------------
[ExcelのDisplayアラート消す]
-------------------------------------#>
(New-Object -ComObject Excel.Application).DisplayAlerts=$false

