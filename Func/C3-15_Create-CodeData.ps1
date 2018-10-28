function global:Create-CodeData{

# PropertyデータからCodeを作成。列からuniqueの値を抽出する。

param(
	$InFile=$(ls -name *.csv|ogv -passThru -Title "ファイルを指定して下さい。"),
	$PropertyFile=$("DefineSheet_"+($InFile -split "\.")[0]+".csv"),
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