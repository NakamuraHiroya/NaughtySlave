function global:SplitRowGroupData{

param(
	$InFile=$(ls -name *.csv|ogv -PassThru -Title "入力するファイルを指定して下さい。"),
	$Data=$(ipcsv $Infile -Encoding Default),
	$raw=$($Data|Get-Member|?{$_.MemberType -eq "NoteProperty"}|%{$_.name}|ogv -PassThru -Title "分割対象の列名を選択して下さい。"),
	$OutFile=$(if($InFile){$Infile}else{Read-Host "出力ファイル名を入力して下さい。"})
)

# 【】や[]や/を変換しないとダメ！
$data|group $raw|%{$name=$_.Name;$_.Group|Export-CSV ($OutFile+"_"+$name+".csv") -Encoding Default -NoTypeInformation}

# チケットログ作成
Add-Content _TicketList_Data.csv ",SplitRowGroupData,$InFile,$OutFile,$Data,$raw" -Encoding Default


}
