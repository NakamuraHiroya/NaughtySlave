function global:SplitRowGroupData{

param(
	$InFile=$(ls -name *.csv -Exclude _*|ogv -PassThru -Title "入力するファイルを指定して下さい。"),
	$Data=$(ipcsv $Infile -Encoding Default),
	$raw=$((cat $InFile)[0] -split ","|ogv -PassThru -Title "分割対象の列名を選択して下さい。"),
	$OutFile=$(($InFile -split "\.")[0]),
	$Ticket
)

# 【】や[]や/を変換しないとダメ！
$data|group $raw|%{$name=$_.Name;$_.Group|Export-CSV ($OutFile+"_"+$name+".csv") -Encoding Default -NoTypeInformation}

# ダブルクオーテーションTrim
$data|group $raw|%{TrimFile ($OutFile+"_"+$_.Name+".csv")}


# チケットログ作成
if($Ticket){CreateTicketData -data "$Ticket,SplitRowGroupData,$InFile,$OutFile,$Data,$raw"}


}