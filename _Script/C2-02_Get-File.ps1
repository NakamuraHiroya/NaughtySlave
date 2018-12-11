function global:Get-File{

param(
	$SrcDir=$(($DataList."WBS.csv"|ogv -passthru -title "�t�@�C���̃p�X��I�����ĉ������B").WorkDir),
	$WorkDir=$((pwd).path),
	$InFile=$(ls -name $SrcDir|ogv -passThru -Title "�t�@�C����I�����ĉ������B"),
	$OutFile=$($InFile),
	$Ticket
)
begin{
	pushd $WorkDir
	}
process{
	cp (Join-Path $SrcDir $InFile) (Join-Path $WorkDir $OutFile)
	
	# �`�P�b�g���O�쐬
	$FunctionName=$MyInvocation.MyCommand.Name
	if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,`"`"`"$SrcDir`"`"`",$SrcPath,$DistDir,$DistPath,$DefineSheet"}

	}
end{
	popd
	} 
}

