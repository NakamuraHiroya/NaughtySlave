function global:Exe-Command{

param(
	$Data=$($dataList."CommandList.csv"|ogv -passThru -Title "どれを実行しますか？")
)

$data|%{Invoke-Expression ($_.CommandName -split "\.")[0]}



}