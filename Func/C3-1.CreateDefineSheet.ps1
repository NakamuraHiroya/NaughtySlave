function global:CreateDefineSheet{

# ��`�V�[�g���쐬����B

param(
	$InFile=$(ls -name *.csv -Exclude Define*,_*|ogv -PassThru -Title "�t�@�C�����w�肵�ĉ������B"),
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

#Ticket�쐬���Ȃ�

}