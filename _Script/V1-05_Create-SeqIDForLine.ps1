function global:Create-SeqID{

# Property��Key��ID�̏ꍇ�ASEQID��t�^����B

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "�t�@�C����I�����ĉ������B"),
	$DefineSheet=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$OutFile=$(($InFile -split "\.")[0]+".csv"),
	$Ticket
)

$DefineSheet_KeyList=ipcsv $DefineSheet -encoding default|?{$_.Key -eq "ID"}

$i=1
$Data=ipcsv $Infile -encoding Default
$data|%{$_.($DefineSheet_KeyList.Property)=$i;$i++}
$data|Export-csv $OutFile -encoding default -notypeinformation

# �`�P�b�g���O�쐬
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,,$InFile,$OutFile"}


}
