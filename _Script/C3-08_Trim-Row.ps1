function global:Trim-Row{

# 指定した列の指定文字をTrimする。
# けどとりあえず今は、カンマ区切りの数値Trimだけ

param(
	$InFile=$(ls -name *.csv -Exclude Define*,_*|ogv -passThru -Title "ファイルを指定して下さい。"),
	$WorkDir=$((pwd).path),
	$PropertyFile=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$Row=$((cat $InFile -First 1).Split(",")|ogv -passThru -Title "Trimする列を指定して下さい。"),
	$OutFile=$($InFile),
	$Ticket
)

$data=ipcsv $InFile -encoding default

$data|%{$_.($Row)=$_.($Row).replace(',','')}
$data|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default

# チケットログ作成 "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath"
$FunctionName=$MyInvocation.MyCommand.Name
#Ticket,Timing,CommandName,SrcPath,InFile,OutFile,Row,Line
$InFile=("`"`"`""+$InFile+"`"`"`"")
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row"}


}