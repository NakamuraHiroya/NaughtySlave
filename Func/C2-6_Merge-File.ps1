function global:Merge-File{

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "mergeするファイルを選択して下さい。"),
	$OutFile=$(($InFile -split "\.")[0]+"_Merge.csv"),
	$Ticket
)

$InFile -split " "|%{
	$data+=ipcsv $_ -encoding default
}
$data|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default

$FunctionName=$MyInvocation.MyCommand.Name
#Ticket,Timing,CommandName,SrcPath,InFile,OutFile,Row,Line
$InFile=("`"`"`""+$InFile+"`"`"`"")
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,,$InFile,$OutFile"}

}
