function global:CreateDefineSheet{

# 定義シートを作成する。

param(
	$InFile=$(ls -name *.csv -Exclude Define*,_*|ogv -PassThru -Title "ファイルを指定して下さい。"),
	$OutFile=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv")
)
if(-not(Test-Path $OutFile)){
	Set-Content $OutFile "InFile,Property,Order,Key,Type,Min,Max,Function" -Encoding Default
	
	(cat $InFile)[0]|%{$Header=$_ -split ","}
	(cat $Infile)[1]|%{$SampleData=$_ -split ","}
	
	$i=0
	
	$Header|%{$Infile+","+$Header[$i]+","+($i+1)+","+" "+","+((GuessValueType $Sampledata[$i]).gettype().name);$i++}|
	Out-file $OutFile -Encoding Default -Append
}

#Ticket作成しない

}