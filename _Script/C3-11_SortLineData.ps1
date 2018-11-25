function global:SortLineData{

# 定義シートを元に、行を並び替える。Descにも対応したい。

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "ファイルを選択して下さい。"),
	$PropertyFile=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$OutFile=$(($InFile -split "\.")[0]+"_Sort.csv"),
	$Ticket
)
$data=ipcsv $InFile -encoding Default

$PropertyInfo_SortList=ipcsv $PropertyFile -encoding default|?{$_.Sort}|%{$_.Property}
$PropertyInfo_SortList

#$data|%{$_.$sss -as [DateTime]}|sort
#$data

# チケットログ作成
if($Ticket){CreateTicketData -Data "SortLineData,$InFile,$OutFile"}


}
