function global:SplitLineData{

# Line�𕪊�����B

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "�t�@�C����I�����ĉ������B"),
	$Row=$((cat $InFile)[0] -split "\,"|ogv -PassThru -Title "�s��������Ώۂ̗��I�����ĉ������B"),
	$Line=$(ipcsv $inFile -encoding default|ogv -passThru -title "��������s��I�����ĉ������B"),
	$OutFile=$(($InFile -split "\.")[0]+"_SplitLine.csv")

)

$InFile
$Row
$Line
$OutFile


#log�쐬
CreateTicketData -Data "SplitLineData,$InFile,$OutFile"


}
