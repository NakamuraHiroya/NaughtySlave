function global:Exe-Function{

# 定義シートのFunction列に対して関数を実行
# $OutFile=$(($InFile -split "\.")[0]+"_Custom.csv"),

param(
	$InFile=$(ls -name *.csv -Exclude Define*,_*|ogv -passThru -Title "ファイルを指定して下さい。"),
	$DefineSheet=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$Data=$(ipcsv $InFile -Encoding Default),
	$OutFile=$($InFile),
	$Ticket
)

$Property_CustomList=ipcsv $DefineSheet -encoding default|?{$_.Function}

$Property_CustomList|%{
	$Property=$_.Property
	$Function=$_.Function
	
	$Data|%{$_.$Property=(Invoke-Expression $Function)}
	$Data|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default
	#$Data|Export-Csv $OutFile -Encoding Default -NoTypeInformation
}

# チケットログ作成
#"Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath,DefineSheet"
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,,$InFile,$OutFile,,,,,,,,$DefineSheet"}

}