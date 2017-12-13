function global:BackupFile{

param(
	$InFile=$(ls -name|ogv -passThru -Title "Backup対象のFileを選択して下さい。"),
	$DistDir=$yyyymmdd
)

if(-not((ls -dir -name) -contains $DistDir)){mkdir $DistDir}

cp $InFile (Join-Path $DistDir ($DistDir+"_"+$InFile))

# チケットログ作成
CreateTicketPath -data "BackupFile,$InFile,$OutFile,$DistDir"

}

