function global:Merge-File{

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "merge����t�@�C����I�����ĉ������B"),
	$OutFile=$(($InFile -split "\.")[0]+"_Merge.csv"),
	$Ticket
)

$InFile|%{
	$data+=ipcsv $_ -encoding default
}
$data|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default

# �`�P�b�g���O�쐬
if($Ticket){CreateTicketFile -data "$Ticket,Merge-File,$InFile,$OutFile"}
}
