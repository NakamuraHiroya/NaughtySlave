function global:Open-WEBSite{

param(
	$WorkDir=$((pwd).path),
	$SrcPath=$($DataList["WEBServiceList.csv"]|ogv -PassThru -Title "�擾����URL���w�肵�ĉ������B"|%{$_.URL}),
	$Ticket
)
begin{
	pushd $WorkDir
	$ie=New-Object -ComObject InternetExplorer.Application
	$ie.Visible = $true
	}
process{
	if(-not $SrcPath){return}
	$ie.Navigate($SrcPath)

	# �`�P�b�g���O�쐬 "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath"	
	$FunctionName=$MyInvocation.MyCommand.Name
	if($Ticket){Create-Ticket -data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,$SrcDir,$SrcPath,$DistDir,$DistPath"}
	
	}
end{
	popd
	}
}