function global:GuessValueType{

# Value‚ğˆø”‚É“ü‚ê‚é‚ÆInt32,DateTime,String‚É„‘ª‚µ‚Ä•ÏŠ·‚µ‚Ä‚­‚ê‚é
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

