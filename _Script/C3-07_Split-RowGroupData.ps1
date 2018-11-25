function global:Split-RowGroupData{

param(
	$InFile=$(ls -name *.csv -Exclude _*|ogv -PassThru -Title "入力するファイルを指定して下さい。"),
	$Data=$(ipcsv $Infile -Encoding Default),
	$Row=$((cat $InFile)[0] -split ","|ogv -PassThru -Title "分割対象の列名を選択して下さい。"),
	$OutFile=$(($InFile -split "\.")[0]),
	$Ticket
)

# 【】や[]や/を変換しないとダメ！
$data|group $Row|%{$name=$_.Name;$_.Group|Export-CSV ($OutFile+"_"+$name+".csv") -Encoding Default -NoTypeInformation}

# ダブルクオーテーションTrim
$data|group $Row|%{Trim-File ($OutFile+"_"+$_.Name+".csv")}


# チケットログ作成 "Ticket,Timing,FunctionName,SrcPath,InFile,OutFile,Row,Line"
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -data "$Ticket,Always,$FunctionName,,$InFile,,$Row"}


}