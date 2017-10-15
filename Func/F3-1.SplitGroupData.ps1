function global:SplitGroupData{

param(
	$Data=$data[($data.keys|ogv -passThru -Title "�J��Data���w�肵�ĉ������B")],
	$raw=$($Data|Get-Member|?{$_.MemberType -eq "NoteProperty"}|%{$_.name}|ogv -PassThru -Title "�����Ώۂ̗񖼂�I�����ĉ������B"),
	$OutFile=$(Read-Host "�o�̓t�@�C��������͂��ĉ������B")
)

# �y�z��[]��/��ϊ����Ȃ��ƃ_���I
$data|group $raw|%{$name=$_.Name;$_.Group|Export-CSV ($OutFile+"_"+$name+".csv") -Encoding Default -NoTypeInformation}
}