function global:Merge-File{
# 2つ以上の、「列名」が同じCSVファイルのデータをマージする。

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

# チケットログ作成
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,,$Value,,,$DistDir,$DistPath"}


}
