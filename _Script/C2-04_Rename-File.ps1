function global:Rename-File{

param(
	$WorkDir=$((pwd).path),
	$InFile=$(ls -name|ogv -passThru -Title "File��I�����ĉ������B"),
	$OutFile=$(Read-Host "�t�@�C��������͂��ĉ������B"),
	$Ticket
)
begin{
	pushd $WorkDir
	}
process{
	mv $InFile $Outfile

	# �`�P�b�g���O�쐬
	$FunctionName=$MyInvocation.MyCommand.Name
	if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,$SrcDir,$SrcPath,$DistDir,$DistPath,$DefineSheet"}
	
	}
end{
	popd
	}
}

