function global:Measure-Data{

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "ファイルを選択して下さい。"),
	$PropertyFile=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$Data=$(ipcsv $InFile -encoding default),
	$OutFile=$(($InFile -split "\.")[0]+"_Measure.csv")

)

$PropertyInfo_IntList=ipcsv $PropertyFile -encoding default|?{$_.Type -eq "Int32"}|%{$_.Property}

Set-Content $OutFile "InFile,PropertyName,Count,Sum,Max,Min,Average" -Encoding Default

$PropertyInfo_IntList|%{
	$Property=$_
	$data|measure -property $Property -sum -max -min -average|
	%{$InFile+","+$Property+","+$_.count+","+$_.sum,","+$_.Maximum+","+$_.Minimum+","+$_.Average|
	Out-file $OutFile -encoding default -append}

}

# チケットログ作成 "Ticket,Timing,FunctionName,SrcPath,InFile,OutFile,Row,Line"
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -data "$Ticket,Always,$FunctionName,,$InFile,,"}



}

