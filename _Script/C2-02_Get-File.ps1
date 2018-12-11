function global:Get-File{

param(
	$SrcDir=$(($DataList."WBS.csv"|ogv -passthru -title "ファイルのパスを選択して下さい。").WorkDir),
	$WorkDir=$((pwd).path),
	$InFile=$(ls -name $SrcDir|ogv -passThru -Title "ファイルを選択して下さい。"),
	$OutFile=$($InFile),
	$Ticket
)
begin{
	pushd $WorkDir
	}
process{
	cp (Join-Path $SrcDir $InFile) (Join-Path $WorkDir $OutFile)
	
	# チケットログ作成
	$FunctionName=$MyInvocation.MyCommand.Name
	if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,`"`"`"$SrcDir`"`"`",$SrcPath,$DistDir,$DistPath,$DefineSheet"}

	}
end{
	popd
	} 
}

