function global:Define-RowData{

# Property��Order��`�ɏ]���ė�̏��Ԃ��`����

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "�t�@�C����I�����ĉ������B"),
	$PropertyFile=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$OutFile=$(($InFile -split "\.")[0]+"_Order.csv"),
	$Ticket
)

$PropertyInfo_OrderList=ipcsv $PropertyFile -encoding default|?{$_.Order}|sort{$_.Order -as [int]}|%{$_.Property}

(ipcsv $InFile -encoding default)|select $PropertyInfo_OrderList|
ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default

# �`�P�b�g���O�쐬
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,,$InFile,$OutFile"}


}
