<#-------------------------------------
[アセンブリ読み込み]
-------------------------------------#>
Add-Type -AssemblyName System.Windows.Forms

<#-------------------------------------
[全ての関数読み込み]
-------------------------------------#>
cd ($NS_DIR="C:\Users\hiroya\Documents\NaughtySlave\")
ls $NS_DIR*.ps1 -name|%{. $NS_DIR$_}

<#-------------------------------------
[WorkDirで自動処理実行]
-------------------------------------#>
Exe-Ticket -WorkDir (cd ($WBS_DIR="C:\Users\hiroya\Documents\WBS"))

<#-------------------------------------
[日付系変数定義]
-------------------------------------#>
Set-variable -name YYYYMM -value (Get-Date).ToString("yyyyMM") -option constant
Set-variable -name YYYYMMDD -value (Get-Date).ToString("yyyyMMdd") -option constant

<#-------------------------------------
[Alias定義]
<#-----------------------------------#>
$DataList.'AppList.csv'|%{if($_.AliasCode){Set-Alias $_.AliasCode $_.ExeCode}}
