function global:Sort-LineData{

# ��`�V�[�g�����ɁA�s����ёւ���BDesc�ɂ��Ή��������B
# sort "name" -descending

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "�t�@�C����I�����ĉ������B"),
	$PropertyFile=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$OutFile=$(($InFile -split "\.")[0]+"_Sort.csv"),
	$Ticket
)

$PropertyInfo_SortList=ipcsv $PropertyFile -encoding default|?{$_.Sort}|%{$_.Property}

$data=ipcsv $InFile -encoding default|sort $PropertyInfo_SortList
$data|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default

# �`�P�b�g���O�쐬 "Ticket,Timing,FunctionName,SrcPath,InFile,OutFile,Row,Line"
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,,$InFile,$OutFile,,,,,,,,$DefineSheet"}

}
