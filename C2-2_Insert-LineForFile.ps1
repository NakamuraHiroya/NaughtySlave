function global:Insert-LineForFile{
# ファイルに対して、行を挿入する。

param(
	$InFile=$(ls -name *.csv|ogv -PassThru -Title "入力するファイルを指定して下さい。"),
	$Line=$(Read-Host "挿入したい行番号を入力して下さい。"),
	$Value=(Read-Host "挿入したい値を入力して下さい。"),
	$OutFile=$($InFile+"_Insert.csv"),
	$Ticket
)

# catで行番号付きを見る
#(cat $InFile|%{[void][int]$i;([string]$j=$i)+":"+$_;[void][int]$i++})

#挿入前+データ+挿入後
(cat $InFile|select -first $Line)+$Value+(cat $InFile|select -skip $Line)|Out-File $OutFile -Encoding Default

# チケットログ作成
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,,,$DistDir,$DistPath"}

}