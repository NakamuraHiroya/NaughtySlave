function global:Rename-File{

param(
	$InFile=$(ls -name|ogv -passThru -Title "File��I�����ĉ������B"),
	$OutFile=$(Read-Host "�t�@�C��������͂��ĉ������B")

)

mv $InFile $Outfile


# �`�P�b�g���O�쐬
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,,,,,,$DistDir,$DistPath"}



}

