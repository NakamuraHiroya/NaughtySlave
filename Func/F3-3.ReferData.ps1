function global:ReferData{

# PropertyデータのReferData列からデータを参照

param(
	$InFile=$(ls -name *.csv|ogv -passThru -Title "ファイルを指定して下さい。"),
	$PropertyFile=$("_"+($InFile -split "\.")[0]+"_Property.csv"),
	$Data=$(ipcsv $InFile -Encoding Default),
	$OutFile=$(($InFile -split "\.")[0]+"_Refer.csv")
)

$Property_ReferList=ipcsv $PropertyFile -encoding default|?{$_.ReferData}

$Property_ReferList|%{
	$Property=$_.Property
	$ReferData=$_.ReferData
	
	$Data|%{$_.$Property=(Invoke-Expression $ReferData)}
	$Data|Export-Csv $OutFile -Encoding Default -NoTypeInformation
}
}