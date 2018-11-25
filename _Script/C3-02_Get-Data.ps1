function global:Get-Data{

# 難しいなこれ。

param(
	$WorkDir=$((pwd).path),
	$InFile=$($DataList.($DataList.Keys|sort|ogv -PassThru -Title "取得するデータを選択して下さい。")),
	$Line=$($InFile|ogv -PassThru -Title "取得する行を指定して下さい。"),
	$Row=$($InFile|get-member|?{$_.MemberType -eq "NoteProperty"}|%{$_.Name}|ogv -PassThru -Title "取得する列を指定して下さい。"),
	$OutFile,
	$Ticket
)

if($OutFile){$Line|select $Row|Export-csv $OutFile -Encoding Default -NoTypeInformation}else{$Line|select $Row}

# チケットログ作成
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,,,,,"}

}