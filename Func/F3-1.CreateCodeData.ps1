function global:CreateCodeData{

# Property�f�[�^����Code���쐬�B�񂩂�unique�̒l�𒊏o����B

param(
	$InFile=$(ls -name *.csv|ogv -passThru -Title "�t�@�C�����w�肵�ĉ������B"),
	$PropertyFile=$("_"+($InFile -split "\.")[0]+"_Property.csv"),
	$Data=$(ipcsv $InFile -Encoding Default)
)
$Property_CodeList=ipcsv $PropertyFile -encoding default|?{$_.Key -eq "Code"}|%{$_.Property}

$Property_CodeList|%{
	$Property=$_
	$OutFile=$Property+"_Code.csv"
	if(-not (Test-Path $OutFile)){Set-Content $OutFile $Property -Encoding Default}
	
	$Data|%{$_.$Property}|sort|Get-Unique|Out-File $OutFile -Encoding Default -Append

}
}