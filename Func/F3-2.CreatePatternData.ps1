function global:CreatePatternData{

param(
	$Data_1=$data[($data.keys|ogv -passThru -Title "1�ڂɊJ��Data���w�肵�ĉ������B")],
	$Row_1=$($Data_1|Get-Member|?{$_.MemberType -eq "NoteProperty"}|%{$_.name}|ogv -PassThru -Title "1�ڂ�Data�̗񖼂�I�����ĉ������B"),
	$Data_2=$data[($data.keys|ogv -passThru -Title "2�ڂɊJ��Data���w�肵�ĉ������B")],
	$Row_2=$($Data_2|Get-Member|?{$_.MemberType -eq "NoteProperty"}|%{$_.name}|ogv -PassThru -Title "2�ڂ�Data�̗񖼂�I�����ĉ������B"),
	$OutFile=$(Read-Host "�o�̓t�@�C��������͂��ĉ������B")
)

$Data_1.($Row_1)|%{$Root=$_;$Data_2.($Row_2)|%{Add-Content List.csv ($Root+","+$_);Write-Progress "Now Writing" ($Root+$_)}}



}