function global:Get-File{

param(
	$SrcDir=$(($DataList."WBS.csv"|ogv -passthru -title "ファイルのパスを選択して下さい。").WorkDir),
	$WorkDir=$((pwd).path),
	$InFile=$(ls -name $SrcDir|ogv -passThru -Title "ファイルを選択して下さい。"),
	$SrcPath=$(Join-Path $SrcDir $InFile),
	$OutFile=$($InFile),
	$DistDir=$(WorkDir),
	$DistPath=(Join-Path $WorkDir $OutFile),
	[Switch]$move,
	$Ticket
)

# ファイルが更新されたタイミングが同じなら何もしない
#if(((ls $SrcPath).LastWriteTime) -eq ((ls $DistFile).LastWriteTime)){return}

#if($move){	mv $SrcPath $DistFile}else{	cp $SrcPath $DistFile}

cp $SrcPath $DistPath

# チケットログ作成 "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath"
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,,,,`"`"`"$SrcDir`"`"`",`"`"`"$SrcPath`"`"`",`"`"`"$DistDir`"`"`",`"`"`"$DistPath`"`"`","}

}

