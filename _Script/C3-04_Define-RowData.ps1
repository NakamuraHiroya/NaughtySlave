function global:Define-RowData{

# Property��Order��`�ɏ]���ė�̏��Ԃ��`����
# $OutFile=$(($InFile -split "\.")[0]+"_Order.csv"),
param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "�t�@�C����I�����ĉ������B"),
	$DefineSheet=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$OutFile=$($InFile),
	$Ticket
)

$PropertyInfo_OrderList=ipcsv $DefineSheet -encoding default|?{$_.Order}|sort{$_.Order -as [int]}|%{$_.Property}

(ipcsv $InFile -encoding default)|select $PropertyInfo_OrderList|
ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default

# �`�P�b�g���O�쐬
#"Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath,DefineSheet"
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,,$InFile,$OutFile,,,,,,,,$DefineSheet"}


}
