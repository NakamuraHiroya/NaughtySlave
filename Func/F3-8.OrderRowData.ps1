function global:OrderRowData{

# PropertyのOrder定義に従って列の順番を定義する

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "ファイルを選択して下さい。"),
	$PropertyFile=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$OutFile=$(($InFile -split "\.")[0]+"_Order.csv"),
	$Ticket
)

$PropertyInfo_OrderList=ipcsv $PropertyFile -encoding default|?{$_.Order}|sort{$_.Order -as [int]}|%{$_.Property}

(ipcsv $InFile -encoding default)|select $PropertyInfo_OrderList|
Export-csv $OutFile -encoding default -notypeinformation

# チケットログ作成
if($Ticket){CreateTicketData -Data "$Ticket,OrderRowData,$InFile,$OutFile"}


}
