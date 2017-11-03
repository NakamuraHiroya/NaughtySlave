function global:AddLineForFile{

param(
	$InFile=$(ls -name *.csv|ogv -PassThru -Title "入力するファイルを指定して下さい。"),
	$InputValue=(Read-Host "挿入したいデータを入力して下さい。"),
	$OutFile=$InFile
)

Add-content $InFile $InputValue -encoding default

# チケットログ作成
Add-Content _TicketList_File.csv ",AddLineForFile,$InFile,$OutFile,$InputValue" -Encoding Default

}