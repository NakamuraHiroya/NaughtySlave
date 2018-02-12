function global:CreateSeqIDForLine{

# PropertyのKeyがIDの場合、SEQIDを付与する。

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "ファイルを選択して下さい。"),
	$DefineSheet=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$OutFile=$(($InFile -split "\.")[0]+".csv"),
	$Ticket
)

$DefineSheet_KeyList=ipcsv $DefineSheet -encoding default|?{$_.Key -eq "ID"}

$i=1
$Data=ipcsv $Infile -encoding Default
$data|%{$_.($DefineSheet_KeyList.Property)=$i;$i++}
$data|Export-csv $OutFile -encoding default -notypeinformation

# チケットログ作成
if($Ticket){CreateTicketData -Data "$Ticket,CreateSeqIDForLine,$InFile,$OutFile"}


}
