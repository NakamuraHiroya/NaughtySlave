function global:DirectInputValue{

param(
	$Data=$(ipcsv ($File=(ls -name *.csv|ogv -PassThru -Title "入力するファイルを指定して下さい。")) -Encoding Default),
	$Row=$($Data|Get-Member|?{$_.MemberType -eq "NoteProperty"}|%{$_.name}|ogv -PassThru -Title "入力する列名を指定して下さい。"),
	$Column=$($Data.$Row|ogv -PassThru -Title "入力する行を指定して下さい。"),
	$InputValue=(Read-Host "値を入力して下さい。"),
	$OutFile="InputedValue.csv"
)
$Data|?{$_.$Row -eq $Column}|%{$_.$Row = $InputValue}|Export-CSV $OutFile -Encoding default -NoTypeInformation

}