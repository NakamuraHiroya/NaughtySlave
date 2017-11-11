function global:CreateMeasureData{

param(
	$InFile=$(ls -name *.csv|ogv -passThru -Title "ファイルを選択して下さい。"),
	$PropertyFile=$(ls -name *_Property.csv|ogv -passThru -title "プロパティファイルを選択して下さい。"),
	$Data=$(ipcsv $InFile -encoding default),
	$OutFile=$($Infile+"_Measure.csv")

)

$PropertyInfo_IntList=ipcsv *Property.csv -encoding default|?{$_.Type -eq "Int32"}|%{$_.Property}


#if(-not(Test-Path $OutFile)){
	Set-Content $OutFile "InFile,PropertyName,Count,Sum,Max,Min,Average" -Encoding Default
#	}

$PropertyInfo_IntList|%{
	$Property=$_
	$data|measure -property $Property -sum -max -min -average|%{$InFile+","+$Property+","+$_.count+","+$_.sum,","+$_.Maximum+","+$_.Minimum+","+$_.Average|
	Out-file $OutFile -encoding default -append}

}

}
