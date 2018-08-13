function global:Get-File{

param(
	$Data=$($DataList."FileList.csv"|ogv -passthru -title "ファイルのパスを選択して下さい。"),
	$SrcPath=$($Data.WorkDir),
	$InFile=$($Data.InFile),
	$OutFile=$($InFile),
	[Switch]$move,
	$Ticket
)

$SrcFile=(Join-Path $SrcPath $InFile)
$DistFile=(Join-Path (Convert-Path .) $OutFile)

# ファイルが更新されたタイミングが同じなら何もしない
#if(((ls $SrcFile).LastWriteTime) -eq ((ls $DistFile).LastWriteTime)){return}

if($move){
	mv $SrcFile $DistFile
}else{
	cp $SrcFile $DistFile
}

# チケットログ作成 "Ticket,Timing,FunctionName,SrcPath,InFile,OutFile,Row,Line"
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,`"`"`"$SrcPath`"`"`",$InFile,$OutFile"}

}

