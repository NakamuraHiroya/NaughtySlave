function global:CreatePropertyData{

#プロパティリストを作成する。

param(
	$Data=$(ipcsv ($File=(ls -name *.csv|ogv -PassThru -Title "ファイルを指定して下さい。")) -Encoding Default),
	$OutFile=$($File+"_Property.csv")
)
Set-Content $OutFile "File,Property" -Encoding Default
cat $File -First 1|%{$list=$_ -split ","};$list|%{$file+","+$_}|out-file $OutFile -Encoding Default -Append



}