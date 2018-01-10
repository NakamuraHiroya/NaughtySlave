function global:CustomData{

# PropertyデータのCustomData列からデータを参照

param(
	$InFile=$(ls -name *.csv|ogv -passThru -Title "ファイルを指定して下さい。"),
	$PropertyFile=$("_"+($InFile -split "\.")[0]+"_Property.csv"),
	$Data=$(ipcsv $InFile -Encoding Default),
	$OutFile=$(($InFile -split "\.")[0]+"_Custom.csv")
)

$Property_CustomList=ipcsv $PropertyFile -encoding default|?{$_.CustomData}

$Property_CustomList|%{
	$Property=$_.Property
	$CustomData=$_.CustomData
	
	$Data|%{$_.$Property=(Invoke-Expression $CustomData)}
	$Data|Export-Csv $OutFile -Encoding Default -NoTypeInformation
}
}