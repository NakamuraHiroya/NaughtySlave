function global:CreatePatternData{

param(
	$Data_1=$data[($data.keys|ogv -passThru -Title "1つ目に開くDataを指定して下さい。")],
	$Row_1=$($Data_1|Get-Member|?{$_.MemberType -eq "NoteProperty"}|%{$_.name}|ogv -PassThru -Title "1つ目のDataの列名を選択して下さい。"),
	$Data_2=$data[($data.keys|ogv -passThru -Title "2つ目に開くDataを指定して下さい。")],
	$Row_2=$($Data_2|Get-Member|?{$_.MemberType -eq "NoteProperty"}|%{$_.name}|ogv -PassThru -Title "2つ目のDataの列名を選択して下さい。"),
	$OutFile=$(Read-Host "出力ファイル名を入力して下さい。")
)

$Data_1.($Row_1)|%{$Root=$_;$Data_2.($Row_2)|%{Add-Content List.csv ($Root+","+$_);Write-Progress "Now Writing" ($Root+$_)}}



}