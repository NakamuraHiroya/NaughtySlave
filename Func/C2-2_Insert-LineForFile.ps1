function global:Insert-LineForFile{
# ファイルに対して、行を挿入する。

param(
	$InFile=$(ls -name *.csv|ogv -PassThru -Title "入力するファイルを指定して下さい。"),
	$Line=$(Read-Host "挿入したい行番号を入力して下さい。"),
	$Value=(Read-Host "挿入したい値を入力して下さい。"),
	$OutFile=$(($InFile -split "\.")[0]+"_Insert.csv"),
	$Ticket
)

if($Line -eq 1){
	[int]$i=1
	$Data=(cat $InFile|%{if($i -eq 1){$Value+"`r`n"+$_}else{$_};$i++})
	$Data|Out-File $OutFile -Encoding Default
}else{
	(cat $InFile|select -first $Line)+$Value+(cat $InFile|select -skip $Line)|Out-File $OutFile -Encoding Default
}

# チケットログ作成
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
$Value=("`"`"`""+$Value+"`"`"`"")
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,,,$DistDir,$DistPath"}

}