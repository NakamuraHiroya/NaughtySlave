function global:Define-RowData{

# PropertyのOrder定義に従って列の順番を定義する

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "ファイルを選択して下さい。"),
	$PropertyFile=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$OutFile=$(($InFile -split "\.")[0]+"_Order.csv"),
	$Ticket
)

$PropertyInfo_OrderList=ipcsv $PropertyFile -encoding default|?{$_.Order}|sort{$_.Order -as [int]}|%{$_.Property}

(ipcsv $InFile -encoding default)|select $PropertyInfo_OrderList|
ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default

# チケットログ作成
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,,$InFile,$OutFile"}


}
