function global:Exe-Command{

param(
	$Data=$($dataList."CommandList.csv"|ogv -passThru -Title "�ǂ�����s���܂����H")
)

$data|%{Invoke-Expression ($_.CommandName -split "\.")[0]}



}