function global:Backup-File{
# �t�@�C�����o�b�N�A�b�v����B

param(
	$InFile=$(ls -name -file -exclude _*|ogv -passThru -Title "Backup�Ώۂ�File��I�����ĉ������B"),
	$WorkDir=$((pwd).path),
	$OutFile=$((Get-Date).ToString("yyyyMMdd")+"_"+$InFile),
	$DistDir=$(Join-Path (pwd).path (Get-Date).ToString("yyyyMMdd")),
	$DistPath=$(Join-Path $DistDir $OutFile),
	$Ticket
)
if(-not(Test-Path $DistDir)){mkdir $DistDir}

cp $InFile (Join-Path $DistDir $OutFile)

# �`�P�b�g���O�쐬
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,,,,,,$DistDir,$DistPath"}

}

