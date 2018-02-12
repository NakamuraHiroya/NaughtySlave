function global:OrderRowData{

# Property��Order��`�ɏ]���ė�̏��Ԃ��`����

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "�t�@�C����I�����ĉ������B"),
	$PropertyFile=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$OutFile=$(($InFile -split "\.")[0]+"_Order.csv"),
	$Ticket
)

$PropertyInfo_OrderList=ipcsv $PropertyFile -encoding default|?{$_.Order}|sort{$_.Order -as [int]}|%{$_.Property}

(ipcsv $InFile -encoding default)|select $PropertyInfo_OrderList|
Export-csv $OutFile -encoding default -notypeinformation

# �`�P�b�g���O�쐬
if($Ticket){CreateTicketData -Data "$Ticket,OrderRowData,$InFile,$OutFile"}


}
