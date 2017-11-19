function global:OrderRowData{

# Property��Order��`�ɏ]���ė�̏��Ԃ��`����

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "�t�@�C����I�����ĉ������B"),
	$PropertyFile=$("_"+($InFile -split "\.")[0]+"_Property.csv"),
	$OutFile=$(($InFile -split "\.")[0]+"_Order.csv")

)

$PropertyInfo_OrderList=ipcsv $PropertyFile -encoding default|?{$_.Order}|%{$_.Property}

(ipcsv $InFile -encoding default)|select $PropertyInfo_OrderList|
Export-csv $OutFile -encoding default -notypeinformation

#log�쐬
CreateTicketData -Data "OrderRowData,$InFile,$OutFile"


}
