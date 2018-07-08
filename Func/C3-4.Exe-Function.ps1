function global:Exe-Function{

# ��`�V�[�g��Function��ɑ΂��Ċ֐������s

param(
	$InFile=$(ls -name *.csv -Exclude Define*,_*|ogv -passThru -Title "�t�@�C�����w�肵�ĉ������B"),
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