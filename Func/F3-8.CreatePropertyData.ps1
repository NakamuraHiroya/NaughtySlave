function global:CreatePropertyData{

#�v���p�e�B���X�g���쐬����B

param(
	$Data=$(ipcsv ($File=(ls -name *.csv|ogv -PassThru -Title "�t�@�C�����w�肵�ĉ������B")) -Encoding Default),
	$OutFile=$($File+"_Property.csv")
)
Set-Content $OutFile "File,Property" -Encoding Default
cat $File -First 1|%{$list=$_ -split ","};$list|%{$file+","+$_}|out-file $OutFile -Encoding Default -Append



}