function global:Del-Line{

# �w��̃t�@�C������A���I�������āA���v����f�[�^���폜�������B
param(
	$Infile=$(ls -name *.csv|ogv -passthru -title "�폜�ΏۂƂ���CSV�t�@�C����I�����ĉ������B"),
	$OutFile=$(($InFile -split "\.")[0]+"_Deleted.csv"),
	$Row=$((cat $InFile -First 1) -split ","|ogv -PassThru -Title "�폜�ΏۂƂ���L�[���I�����ĉ������B"),
	$Line=$(ipcsv $Infile -encoding default|select $row|ogv -PassThru -Title "�폜�Ώۏ�����I�����ĉ������B"),
	$Ticket
)

$i=1
$delline=@()
ipcsv $infile -encoding default|select $row|%{if($line.$row -eq $_.$row){$delline+=$i};$i++}

$delfile=cat $infile
$delline|%{$delLog=$delfile[$_];$delfile[$_]=$null}
$delfile|out-file "del.csv" -encoding default

$delLog|out-file (($InFile -split "\.")[0]+"_delLog.csv") -encoding default

if($Ticket){CreateTicketFile -data "$Ticket,Del-Line,$Infile,$OutFile,$Data,$Row,$Line"}

}



