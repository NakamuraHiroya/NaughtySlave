function global:ReferData{

# Property�f�[�^��ReferData�񂩂�f�[�^���Q��

param(
	$InFile=$(ls -name *.csv|ogv -passThru -Title "�t�@�C�����w�肵�ĉ������B"),
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