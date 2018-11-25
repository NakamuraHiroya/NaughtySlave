function global:Exe-Command{

param(
	$Data=$($dataList."CommandList.csv"|ogv -passThru -Title "‚Ç‚ê‚ğÀs‚µ‚Ü‚·‚©H")
)

$data|%{Invoke-Expression ($_.CommandName -split "\.")[0]}



}