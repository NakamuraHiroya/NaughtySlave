function global:CustomData{

# Property�f�[�^��CustomData�񂩂�f�[�^���Q��

param(
	$InFile=$(ls -name *.csv|ogv -passThru -Title "�t�@�C�����w�肵�ĉ������B"),
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