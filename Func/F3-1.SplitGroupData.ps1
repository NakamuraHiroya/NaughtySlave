function global:SplitGroupData{

param(
	$Data=$data[($data.keys|ogv -passThru -Title "開くDataを指定して下さい。")],
	$raw=$($Data|Get-Member|?{$_.MemberType -eq "NoteProperty"}|%{$_.name}|ogv -PassThru -Title "分割対象の列名を選択して下さい。"),
	$OutFile=$(Read-Host "出力ファイル名を入力して下さい。")
)

# 【】や[]や/を変換しないとダメ！
$data|group $raw|%{$name=$_.Name;$_.Group|Export-CSV ($OutFile+"_"+$name+".csv") -Encoding Default -NoTypeInformation}
}