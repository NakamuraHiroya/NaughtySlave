function global:SplitRowGroupData{

param(
	$InFile=$(ls -name *.csv|ogv -PassThru -Title "入力するファイルを指定して下さい。"),
	$Data=$(ipcsv $Infile -Encoding Default),
	$raw=$((cat $InFile)[0] -split ","|ogv -PassThru -Title "分割対象の列名を選択して下さい。"),
	$OutFile=$(($InFile -split "\.")[0])
)

# 【】や[]や/を変換しないとダメ！
$data|group $raw|%{$name=$_.Name;$_.Group|Export-CSV ($OutFile+"_"+$name+".csv") -Encoding Default -NoTypeInformation}

# チケットログ作成
CreateTicketData -data "SplitRowGroupData,$InFile,$OutFile,$Data,$raw"


}