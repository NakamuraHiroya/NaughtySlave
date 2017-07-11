function global:TicketManager{
<#-----------------------------------------------------------------------------
【OverView】
-----------------------------------------------------------------------------#>

<#-----------------------------------------------------------------------------
【Prepare】
-----------------------------------------------------------------------------#>
param($WorkDir=(Join-Path (Convert-Path .) \),[Switch]$Auto,[Parameter(ValueFromPipeline)]$Operate=$(
<#-----------------------------------------------------------------------------
[1-1. 選択リスト定義]
-----------------------------------------------------------------------------#>
 "3-1-1. ナビゲートしてもらう",
 "3-2-1. 必要なSrcをGetする",
 "3-3-1. TicketCodeを登録する",
 "3-3-2. TicketListをメンテナンスする",
 "3-3-3. Ticketに取り掛かる"|

ogv -PassThru -Title (($WorkDir) + "TicketManager 次に何をしますか？")),
<#-----------------------------------------------------------------------------
[1-2. 変数定義]
-----------------------------------------------------------------------------#>
 $ProjectCode=$(cd $WorkDir;if((Split-Path ../../ -Leaf) -eq "Business"){Split-Path ../ -Leaf}else{"TicketDirで実行して下さい"}),
 $WorkCode=$(if((Split-Path ../../ -Leaf) -eq "Business"){Split-Path . -Leaf}else{"TicketDirで実行して下さい"}),
 $NewTicketList=$(if(-not(Test-Path ./TicketList.csv)){Set-Content ./TicketList.csv "TicketCode,WorkCode,ProjectCode,StartDate,FinDate,isToday"}),
 
<#-----------------------------------------------------------------------------
【GetSrc】
-----------------------------------------------------------------------------#>
<#-----------------------------------------------------------------------------
[2-1. 読み込みたいList読み込み]
-----------------------------------------------------------------------------#>
 $TicketList=$(ipcsv ./TicketList.csv -Encoding Default),
 $TicketTypeCode=$(ipcsv $FUNC_DIR\FunctionList.csv -Encoding Default)
 
)begin{pushd .;cd $WorkDir;(date).ToString()+" :"+$ProjectCode+">"+$WorkCode+">"+(Split-Path -Leaf $PSCommandPath)+" Ready." >> $Log}process{switch($Operate){
<#-----------------------------------------------------------------------------
【3. Custom】
-----------------------------------------------------------------------------#>
<#---------------------------------------------------------------------------#>
"3-1-1. ナビゲートしてもらう"{
<#---------------------------------------------------------------------------#>
$TicketList|ft -autosize
"Project :"+$ProjectCode
"Work :"+$WorkCode
$WorkDir

<#---------------------------------------------------------------------------#>
}"3-2-1. 必要なSrcをGetする"{
<#---------------------------------------------------------------------------#>

<#---------------------------------------------------------------------------#>
}"3-3-1. TicketCodeを登録する"{
<#---------------------------------------------------------------------------#>
$TicketCode = (Read-Host $WorkCode "を達成する為に必要なTicketCodeを記入して下さい。")

#TicketCodeのファイル作成
ni ($TicketCode+".ps1") -Type File -Value ($TicketTypeCode|ogv -PassThru -Title (($WorkDir)+"TicketManager どんなことをするか選択して下さい。 ")).FunctionCode

Add-Content ./TicketList.csv($TicketCode+","+$WorkCode +","+ $ProjectCode)

<#---------------------------------------------------------------------------#>
}"3-3-2. TicketListメンテナンス"{
<#---------------------------------------------------------------------------#>
$excel=New-Object -ComObject Excel.Application;$excel.Visible=$true;$excel.DisplayAlerts=$false;$excel.Workbooks.Open((Convert-path ./TicketList.csv))

<#---------------------------------------------------------------------------#>
}"3-3-3. Ticketに取り掛かる"{
<#---------------------------------------------------------------------------#>
Invoke-Expression ("./"+(ls *.ps1 -name -Exclude TicketManager.ps1|ogv -PassThru -Title "Project>Work>TicketManager 取り掛かるTicketを選択して下さい。"))

<#---------------------------------------------------------------------------#>
}default{
<#---------------------------------------------------------------------------#>
"キャンセルが押されたか、選択メニューに無い！"
}}
if((Read-Host "まだ続ける？yes/no") -eq "yes"){TicketManager -WorkDir (Join-Path (Convert-Path .) \)}else{cd ../}
}end{(date).ToString()+" :"+$ProjectCode+">"+$WorkCode+">"+(Split-Path -Leaf $PSCommandPath)+" Finished." >> $Log;popd}}
