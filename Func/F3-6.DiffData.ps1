function global:DiffData{

param(
	$Data_1=$(ipcsv ($File_1=(ls -name *.csv|ogv -PassThru -Title "�Â��t�@�C�����w�肵�ĉ������B")) -Encoding Default),
	$Data_2=$(ipcsv ($File_2=(ls -name *.csv|ogv -PassThru -Title "�V�����t�@�C�����w�肵�ĉ������B")) -Encoding Default),
	$Key=$($Data_1|Get-Member|?{$_.MemberType -eq "NoteProperty"}|%{$_.name}|ogv -PassThru -Title "Key�ƂȂ�񖼂��w�肵�ĉ������B"),
	$OutFile="DiffList.csv"
)
Set-Content $OutFile "Key,SrcFile,Compare,DistFile" -Encoding Default
diff $Data_1 $Data_2 -Property $Key -SyncWindow 10000|%{$_.No+","+$File_1+","+$_.SideIndicator+","+$File_2}|Out-File $OutFile -Encoding default -Append

}