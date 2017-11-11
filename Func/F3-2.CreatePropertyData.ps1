function global:CreatePropertyData{

#プロパティリストを作成する。

param(
	$InFile=$(ls -name *.csv|ogv -PassThru -Title "ファイルを指定して下さい。"),
	$OutFile=$($InFile+"_Property.csv")
)
if(-not(Test-Path $OutFile)){
	Set-Content $OutFile "InFile,Property,Type,Min,Max" -Encoding Default
	
	(cat $InFile)[0]|%{$Header=$_ -split ","}
	(cat $Infile)[1]|%{$SampleData=$_ -split ","}
	
	$i=0
	$Header|%{$Infile+","+$Header[$i]+","+((GuessValueType $Sampledata[$i]).gettype().name);$i++}|out-file $OutFile -Encoding Default -Append

}else{$Outfile +":exist"}

}
