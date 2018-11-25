function global:Guess-ValueType{

# Valueを引数に入れるとInt32,DateTime,Stringに推測して変換してくれる
param(
	$value
)
try{
	$value=[convert]::ToInt32($value)
}catch{
	try{
		$value=[convert]::ToDateTime($value)
	}catch{
		$value=[convert]::ToString($value)
	}
}
$value
}

