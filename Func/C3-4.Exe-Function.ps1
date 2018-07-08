function global:Exe-Function{

# 定義シートのFunction列に対して関数を実行

param(
	$InFile=$(ls -name *.csv -Exclude Define*,_*|ogv -passThru -Title "ファイルを指定して下さい。"),
	$PropertyFile=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$Data=$(ipcsv $InFile -Encoding Default),
	$OutFile=$(($InFile -split "\.")[0]+"_Custom.csv")
)

$Property_CustomList=ipcsv $PropertyFile -encoding default|?{$_.Function}

$Property_CustomList|%{
	$Property=$_.Property
	$Function=$_.Function
	
	$Data|%{$_.$Property=(Invoke-Expression $Function)}
	$Data|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default
	#$Data|Export-Csv $OutFile -Encoding Default -NoTypeInformation
}
}