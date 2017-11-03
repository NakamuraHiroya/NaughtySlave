function global:InsertLineForFile{

param(
	$InFile=$(ls -name *.csv|ogv -PassThru -Title "入力するファイルを指定して下さい。"),
	$No=(Read-Host "挿入したい行番号を入力して下さい。"),
	$InputValue=(Read-Host "挿入したいデータを入力して下さい。"),
	$OutFile=$InFile
)
#挿入前+データ+挿入後
(cat $InFile|select -first $No)+$InputValue+(cat cashlist.csv|select -skip $no)|Out-File $OutFile -Encoding Default

# チケットログ作成
Add-Content _TicketList_File.csv ",InsertLineForFile,$InFile,$No,$InputValue,$OutFile" -Encoding Default

}