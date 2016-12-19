<#-----------------------------------------------------------------------------
[OverView]
-----------------------------------------------------------------------------#>
# CSVデータから指定した条件のオブジェクトを返すフィルタ関数。
## 引数1(Input):取得するCSVデータ
## 引数2(Operate):フィルタしたい条件文字列(Key=Value,Key=Value)

<#-----------------------------------------------------------------------------
[1. Define]
-----------------------------------------------------------------------------#>
<#-------------------------------------
[1-1. 引数取得]
-------------------------------------#>
if ($args[0]) {$CSVData = $args[0]} else {"CSVデータを渡して下さい。";exit}
if ($args[1]) {$FilterStrings = $args[1]} else {$FilterStrings = Read-Host "フィルタしたい条件を入力して下さい。(Key=Value,Key=Value)"}

<#-----------------------------------------------------------------------------
[2. GetSrc]
-----------------------------------------------------------------------------#>
<#-------------------------------------
[2-1. フィルタ条件配列格納]
-------------------------------------#>
$FilterStringList = $FilterStrings -split ","

$OrderList = @{}

$count = 0
while ($count -lt $FilterStringList.count) {
	$FilterResult = $FilterStringList[$count] -split "="
	
	$OrderList.($FilterResult[0]) = ($FilterResult[1])

	
	$count++
}
#$OrderList

<#-----------------------------------------------------------------------------
[3. CustomData]
-----------------------------------------------------------------------------#>
<#-------------------------------------
[3-1. フィルタ]
-------------------------------------#>
foreach ($key in $OrderList.Keys) {
	$CSVData = $CSVData|? {$_.$key -eq $OrderList[$key]}
}

<#-----------------------------------------------------------------------------
[4. PostDist]
-----------------------------------------------------------------------------#>
return $CSVData

exit

