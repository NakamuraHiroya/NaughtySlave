function global:BackupFile{

param(
	$InFile=$(ls -name|ogv -passThru -Title "Backup�Ώۂ�File��I�����ĉ������B"),
	$DistDir=$yyyymmdd
)

if(-not((ls -dir -name) -contains $DistDir)){mkdir $DistDir}

cp $InFile (Join-Path $DistDir ($DistDir+"_"+$InFile))

# �`�P�b�g���O�쐬
CreateTicketPath -data "BackupFile,$InFile,$OutFile,$DistDir"

}

