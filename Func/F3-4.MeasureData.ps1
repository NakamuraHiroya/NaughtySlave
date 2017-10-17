function global:MeasureData{

param(
	$FileName=$(ls -name *.csv|ogv -passThru -Title "ファイルを選択して下さい。")


)

#if(-not(Test-Path ./MeasureList.csv)){
Set-Content MeasureList.csv "FileName,PropertyName,Count,Sum" -Encoding Default

$Data=opencsvfile $Filename
$data|Get-Member|?{$_.MemberType -eq "NoteProperty"}|%{[Object[]]$PropertyList+=$_.name}

$PropertyList|%{
	$Property=$_
	$data|measure $Property -sum -average -max -min|%{$Filename+","+$Property+","+$_.count+","+$_.sum|
	Out-file MeasureList.csv -encoding default -append}

}




}

