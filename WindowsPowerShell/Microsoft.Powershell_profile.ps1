<#-------------------------------------
[アセンブリ読み込み]
-------------------------------------#>
Add-Type -AssemblyName System.Windows.Forms
#Add-Type -AssemblyName Microsoft.Office.Interop.Excel
#[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Office.Interop.Excel")

<#-------------------------------------
[オブジェクトNewテスト]
-------------------------------------#>
try{
	#$excel=New-Object -ComObject Excel.Application
}catch{
	"オブジェクトNew出来ません。ExcelのVersion・64/32bit等の確認をして下さい。"
	return
}

<#-------------------------------------
[変数定義]
-------------------------------------#>
$NS_DIR=(Join-Path $home "Documents\NaughtySlave\")
$NS_SCRIPT_DIR=(Join-Path $NS_DIR "_Script\")
Set-variable -name YYYYMM -value (Get-Date).ToString("yyyyMM") -option constant
Set-variable -name YYYYMMDD -value (Get-Date).ToString("yyyyMMdd") -option constant

<#-------------------------------------
[全ての関数読み込み]
-------------------------------------#>
cd $NS_SCRIPT_DIR
ls *.ps1 -name |%{. $NS_SCRIPT_DIR$_}
<#-------------------------------------
[WorkDirで自動処理実行]
-------------------------------------#>
Exe-Ticket -WorkDir (cd $NS_DIR)

<#-------------------------------------
[Alias定義]
<#-----------------------------------#>
$DataList.'AppList.csv'|%{if($_.AliasCode){Set-Alias $_.AliasCode $_.ExeCode}}
