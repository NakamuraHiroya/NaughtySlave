function global:TrimFile{

# 要ら無さそうな文字列をファイル単位でTrimする
# ・ダブルクオーテーション
# ・Blank


param(
	$InFile=$(ls -name *.csv|ogv -PassThru -Title "入力するファイルを指定して下さい。"),
	$OutFile=$((($InFile -split "\.")[0])+"_Trim.csv")
)

cat $InFile|%{$_ -replace "`"",""}|%{$_ -replace " ",""}|Out-File $OutFile -Encoding Default



# チケットログ作成
CreateTicketFile -Data "TrimFile,$InFile,$OutFile"


}