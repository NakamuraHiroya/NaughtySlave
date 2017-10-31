function global:DirectInputValue{

param(
	$Data=$(ipcsv ($File=(ls -name *.csv|ogv -PassThru -Title "���͂���t�@�C�����w�肵�ĉ������B")) -Encoding Default),
	$Row=$($Data|Get-Member|?{$_.MemberType -eq "NoteProperty"}|%{$_.name}|ogv -PassThru -Title "���͂���񖼂��w�肵�ĉ������B"),
	$Column=$($Data.$Row|ogv -PassThru -Title "���͂���s���w�肵�ĉ������B"),
	$InputValue=(Read-Host "�l����͂��ĉ������B"),
	$OutFile="InputedValue.csv"
)
$Data|?{$_.$Row -eq $Column}|%{$_.$Row = $InputValue}|Export-CSV $OutFile -Encoding default -NoTypeInformation

}