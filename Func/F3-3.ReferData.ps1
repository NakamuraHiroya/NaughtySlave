function global:ReferData{

# Property�f�[�^��ReferData�񂩂�f�[�^���Q��

param(
	$InFile=$(ls -name *.csv|ogv -passThru -Title "�t�@�C�����w�肵�ĉ������B"),
	$PropertyFile=$("_"+($InFile -split "\.")[0]+"_Property.csv"),
	$Data=$(ipcsv $InFile -Encoding Default),
	$OutFile=$(($InFile -split "\.")[0]+"_Refer.csv")
)

$Property_ReferList=ipcsv $PropertyFile -encoding default|?{$_.ReferMaster}

$Property_ReferList|%{
	$ReferMaster=$_.ReferMaster
	$Key=$_.Property
	$ReferValue=$_.ReferValue
	
	$Data|%{$_.$Key=(ReferValue $ReferMaster $_.$Key $ReferValue)}
	$Data|Export-Csv $OutFile -Encoding Default -NoTypeInformation
}
}