function global:Merge-File{

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "mergeするファイルを選択して下さい。"),
	$OutFile=$(($InFile -split "\.")[0]+"_Merge.csv"),
	$Ticket
)

$InFile|%{
	$data+=ipcsv $_ -encoding default
}
$data|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default

# チケットログ作成
if($Ticket){CreateTicketFile -data "$Ticket,Merge-File,$InFile,$OutFile"}
}
