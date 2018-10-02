function global:Cut-Line{

# 指定のファイルから、行番号を選択させて、Cutしたい。

param(
	$Infile=$(ls -name *.csv|ogv -passthru -title "行削除するCSVファイルを選択して下さい。"),
	$OutFile=$($InFile),
	[Int]$Line=$(Read-Host "削除対象行番号を入力して下さい。"),
	$Ticket
)

$Data=cat $InFile|select -Skip $Line
$Data|Out-File $OutFile -Encoding Default 

# チケットログ作成
#Ticket,Timing,CommandName,SrcPath,InFile,OutFile,Row,Line
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,,$InFile,$OutFile,,$Line"}

}



