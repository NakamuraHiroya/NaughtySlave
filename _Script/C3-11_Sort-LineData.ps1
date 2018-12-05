function global:Sort-LineData{

# 定義シートを元に、行を並び替える。Descにも対応したい。
# sort "name" -descending

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "ファイルを選択して下さい。"),
	$PropertyFile=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$OutFile=$(($InFile -split "\.")[0]+"_Sort.csv"),
	$Ticket
)

$PropertyInfo_SortList=ipcsv $PropertyFile -encoding default|?{$_.Sort}|%{$_.Property}

$data=ipcsv $InFile -encoding default|sort $PropertyInfo_SortList
$data|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default

# チケットログ作成 "Ticket,Timing,FunctionName,SrcPath,InFile,OutFile,Row,Line"
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,,$InFile,$OutFile,,,,,,,,$DefineSheet"}

}
