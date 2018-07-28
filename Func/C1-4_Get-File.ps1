function global:Get-File{


param(
	$WorkDir=$($DataList."FileList.csv"|ogv -passthru -title "ファイルのパスを選択して下さい。"|%{$_.WorkDir}),
	$InFile=$($WorkDir|%{$_.InFile}),
	$OutFile=$($WorkDir|%{$_.OutFile}),
	[Switch]$move,
	$Ticket
)

$SrcFile=(Join-Path $WorkDir $InFile)
$DistFile=(Join-Path (Convert-Path .) $OutFile)

# ファイルが更新されたタイミングが同じなら何もしない
if(((ls $SrcFile).LastWriteTime) -eq ((ls $DistFile).LastWriteTime)){return}


if($move){
	mv $SrcFile $DistFile
}else{
	cp $SrcFile $DistFile
}

if($Ticket){CreateTicketPath -Data "$Ticket,$MyInvocation.MyCommand.Name,$WorkDir,$InFile,$OutFile"}

}

