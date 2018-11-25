function global:Rename-File{

param(
	$InFile=$(ls -name|ogv -passThru -Title "Fileを選択して下さい。"),
	$OutFile=$(Read-Host "ファイル名を入力して下さい。")

)

mv $InFile $Outfile


# チケットログ作成
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,,,,,,$DistDir,$DistPath"}



}

