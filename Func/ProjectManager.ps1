function global:ProjectManager{
<#-----------------------------------------------------------------------------
【OverView】
-----------------------------------------------------------------------------#>
# ProjectManager
<#-----------------------------------------------------------------------------
【Prepare】
-----------------------------------------------------------------------------#>
param($WorkDir=$BUSINESS_DIR,[Switch]$Auto,[Parameter(ValueFromPipeline)]$Operate=$(
<#-----------------------------------------------------------------------------
[1-1. 選択リスト定義]
-----------------------------------------------------------------------------#>
 "3-1-1. ナビゲートしてもらう",
 "3-3-1. ProjectCodeを登録する",
 "3-3-2. ProjectListをメンテナンスする",
 "3-3-3. Projectに取り掛かる"|

ogv -PassThru -Title (($WorkDir) + "ProjectManager 次に何をしますか？")),
<#-----------------------------------------------------------------------------
[1-2. 変数定義]
-----------------------------------------------------------------------------#>
 $NewProjectList=$(if(-not(Test-Path $BUSINESS_DIR/ProjectList.csv)){Set-Content $BUSINESS_DIR/ProjectList.csv "ProjectCode,ProjectNo,ProjectStart,ProjectEnd,isOpen"}),
 
<#-----------------------------------------------------------------------------
【GetSrc】
-----------------------------------------------------------------------------#>
<#-----------------------------------------------------------------------------
[2-1. 読み込みたいList読み込み]
-----------------------------------------------------------------------------#>
 $ProjectList=$(ipcsv ./ProjectList.csv -Encoding Default)
 
)begin{pushd .;cd $WorkDir;(date).ToString()+" :"+$ProjectCode+">"+$WorkCode+">"+(Split-Path -Leaf $PSCommandPath)+" Ready." >> $Log}process{switch($Operate){
<#-----------------------------------------------------------------------------
【3. Custom】
-----------------------------------------------------------------------------#>
<#---------------------------------------------------------------------------#>
"3-1-1. ナビゲートしてもらう"{
<#---------------------------------------------------------------------------#>
"Projectは、工程毎に分けるのが良いです！"

<#---------------------------------------------------------------------------#>
}"3-3-1. ProjectCodeを登録する"{
<#---------------------------------------------------------------------------#>
$ProjectCode = (Read-Host "新しいプロジェクトを作成します。ProjectCodeを入力して下さい。")

mkdir $ProjectCode

Add-Content ./ProjectList.csv $ProjectCode

<#---------------------------------------------------------------------------#>
}"3-3-2. ProjectListをメンテナンスする"{
<#---------------------------------------------------------------------------#>
#$excel=New-Object -ComObject Excel.Application;$excel.Visible=$true;$excel.DisplayAlerts=$false;$excel.Workbooks.Open((Convert-path ./ProjectList.csv))|Out-Null
(New-Object -ComObject Excel.Application)|%{$_.Visible=$true;$_.DisplayAlerts=$false;$_.Workbooks.Open((Convert-Path ./ProjectList.csv))}|Out-Null


<#---------------------------------------------------------------------------#>
}"3-3-3. Projectに取り掛かる"{
<#---------------------------------------------------------------------------#>
WorkManager -WorkDir (Join-Path (Convert-Path (ls -dir -name|ogv -PassThru -Title (($WorkDir) + " 取り掛かるProjectを選択して下さい。"))) \)

<#---------------------------------------------------------------------------#>
}default{
<#---------------------------------------------------------------------------#>
"キャンセルが押されたか、選択メニューに無い！"
}}
if((Read-Host "ProjectManager まだ続ける？yes/no") -eq "yes"){ProjectManager -WorkDir (Join-Path (Convert-Path .) \)}else{cd ../}
}end{(date).ToString() + " :"+$ProjectCode+">"+$WorkCode+">"+(Split-Path -Leaf $PSCommandPath) + " Finished." >> $Log;popd}}


