function global:CreatePropertyData{

#プロパティリストを作成する。

param(
	$InFile=$(ls -name *.csv|ogv -PassThru -Title "ファイルを指定して下さい。"),
	$OutFile=$($InFile+"_Property.csv")
)
if(-not(Test-Path $OutFile)){
	Set-Content $OutFile "InFile,Property,PropertyType,Type,Min,Max" -Encoding Default
	cat $InFile -First 1|%{$list=$_ -split ","};$list|%{$Infile+","+$_}|out-file $OutFile -Encoding Default -Append
}else{$Outfile +":exist"}


}
