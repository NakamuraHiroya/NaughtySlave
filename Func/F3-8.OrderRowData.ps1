function global:OrderRowData{

# PropertyのOrder定義に従って列の順番を定義する

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "ファイルを選択して下さい。"),
	$PropertyFile=$("_"+($InFile -split "\.")[0]+"_Property.csv"),
	$OutFile=$(($InFile -split "\.")[0]+"_Order.csv")

)

$PropertyInfo_OrderList=ipcsv $PropertyFile -encoding default|?{$_.Order}|%{$_.Property}

(ipcsv $InFile -encoding default)|select $PropertyInfo_OrderList|
Export-csv $OutFile -encoding default -notypeinformation

#log作成
CreateTicketData -Data "OrderRowData,$InFile,$OutFile"


}
