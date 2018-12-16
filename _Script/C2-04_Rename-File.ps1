function global:Rename-File{

param(
	$WorkDir=$((pwd).path),
	$InFile=$(ls -name|ogv -passThru -Title "Fileを選択して下さい。"),
	$OutFile=$(Read-Host "ファイル名を入力して下さい。"),
	$Ticket
)
begin{
	pushd $WorkDir
	}
process{
	mv $InFile $Outfile

	# チケットログ作成
	$FunctionName=$MyInvocation.MyCommand.Name
	if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,$SrcDir,$SrcPath,$DistDir,$DistPath,$DefineSheet"}
	
	}
end{
	popd
	}
}

