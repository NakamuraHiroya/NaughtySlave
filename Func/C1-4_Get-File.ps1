function global:Get-File{

param(
	$Data=$($DataList."FileList.csv"|ogv -passthru -title "�t�@�C���̃p�X��I�����ĉ������B"),
	$SrcPath=$($Data.WorkDir),
	$InFile=$($Data.InFile),
	$OutFile=$($InFile),
	[Switch]$move,
	$Ticket
)

$SrcFile=(Join-Path $SrcPath $InFile)
$DistFile=(Join-Path (Convert-Path .) $OutFile)

# �t�@�C�����X�V���ꂽ�^�C�~���O�������Ȃ牽�����Ȃ�
#if(((ls $SrcFile).LastWriteTime) -eq ((ls $DistFile).LastWriteTime)){return}

if($move){
	mv $SrcFile $DistFile
}else{
	cp $SrcFile $DistFile
}

# �`�P�b�g���O�쐬 "Ticket,Timing,FunctionName,SrcPath,InFile,OutFile,Row,Line"
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,`"`"`"$SrcPath`"`"`",$InFile,$OutFile"}

}

