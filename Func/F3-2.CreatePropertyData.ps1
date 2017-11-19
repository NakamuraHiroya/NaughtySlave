function global:CreatePropertyData{

#プロパティリストを作成する。

param(
	$InFile=$(ls -name *.csv|ogv -PassThru -Title "ファイルを指定して下さい。"),
	$OutFile=$("_"+($InFile -split "\.")[0]+"_Property.csv")
)
if(-not(Test-Path $OutFile)){
	Set-Content $OutFile "InFile,Property,Order,Key,Type,Min,Max" -Encoding Default
	
	(cat $InFile)[0]|%{$Header=$_ -split ","}
	(cat $Infile)[1]|%{$SampleData=$_ -split ","}
	
	$i=0
	
	$Header|%{$Infile+","+$Header[$i]+","+($i+1)+","+" "+","+((GuessValueType $Sampledata[$i]).gettype().name);$i++}|
	Out-file $OutFile -Encoding Default -Append

}else{$Outfile +" :Already Exist";exit}

#log作成
CreateTicketData -Data "CreatePropertyData,$InFile,$OutFile"

}