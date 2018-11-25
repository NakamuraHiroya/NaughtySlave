function global:SplitLineData{

# Lineを分割する。

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "ファイルを選択して下さい。"),
	$Row=$((cat $InFile)[0] -split "\,"|ogv -PassThru -Title "行分割する対象の列を選択して下さい。"),
	$Line=$(ipcsv $inFile -encoding default|ogv -passThru -title "分割する行を選択して下さい。"),
	$OutFile=$(($InFile -split "\.")[0]+"_SplitLine.csv")

)

$InFile
$Row
$Line
$OutFile


#log作成
CreateTicketData -Data "SplitLineData,$InFile,$OutFile"


}
