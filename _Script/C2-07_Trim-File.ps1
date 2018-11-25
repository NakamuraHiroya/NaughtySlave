function global:Trim-File{

# 要ら無さそうな文字列をファイル単位でTrimする
# ・ダブルクオーテーション
# ・Blank

param(
	$InFile=$(ls -name *.csv -Exclude _*|ogv -PassThru -Title "入力するファイルを指定して下さい。"),
	$OutFile=$InFile,
	$Ticket
)

$File=cat $InFile|%{$_ -replace "`"",""}|%{$_ -replace " ",""}
$File|Out-File $OutFile -Encoding Default

# チケットログ作成
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,,,,,,$DistDir,$DistPath"}

}