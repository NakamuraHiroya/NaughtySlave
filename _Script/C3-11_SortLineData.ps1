function global:SortLineData{

# ��`�V�[�g�����ɁA�s����ёւ���BDesc�ɂ��Ή��������B

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "�t�@�C����I�����ĉ������B"),
	$PropertyFile=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$OutFile=$(($InFile -split "\.")[0]+"_Sort.csv"),
	$Ticket
)
$data=ipcsv $InFile -encoding Default

$PropertyInfo_SortList=ipcsv $PropertyFile -encoding default|?{$_.Sort}|%{$_.Property}
$PropertyInfo_SortList

#$data|%{$_.$sss -as [DateTime]}|sort
#$data

# �`�P�b�g���O�쐬
if($Ticket){CreateTicketData -Data "SortLineData,$InFile,$OutFile"}


}
