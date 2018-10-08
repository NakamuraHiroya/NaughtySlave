function global:Get-File{

param(
	$SrcDir=$(($DataList."WBS.csv"|ogv -passthru -title "�t�@�C���̃p�X��I�����ĉ������B").WorkDir),
	$WorkDir=$((pwd).path),
	$InFile=$(ls -name $SrcDir|ogv -passThru -Title "�t�@�C����I�����ĉ������B"),
	$SrcPath=$(Join-Path $SrcDir $InFile),
	$OutFile=$($InFile),
	$DistDir=$(WorkDir),
	$DistPath=(Join-Path $WorkDir $OutFile),
	[Switch]$move,
	$Ticket
)

# �t�@�C�����X�V���ꂽ�^�C�~���O�������Ȃ牽�����Ȃ�
#if(((ls $SrcPath).LastWriteTime) -eq ((ls $DistFile).LastWriteTime)){return}

#if($move){	mv $SrcPath $DistFile}else{	cp $SrcPath $DistFile}

cp $SrcPath $DistPath

# �`�P�b�g���O�쐬 "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath"
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,,,,`"`"`"$SrcDir`"`"`",`"`"`"$SrcPath`"`"`",`"`"`"$DistDir`"`"`",`"`"`"$DistPath`"`"`","}

}

