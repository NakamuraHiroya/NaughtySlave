function global:GuessValueType{

# Value�������ɓ�����Int32,DateTime,String�ɐ������ĕϊ����Ă����
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

