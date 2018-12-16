function global:Open-WEBSite{

param(
	$WorkDir=$((pwd).path),
	$SrcPath=$($DataList["WEBServiceList.csv"]|ogv -PassThru -Title "取得するURLを指定して下さい。"|%{$_.URL}),
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

	# チケットログ作成 "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath"	
	$FunctionName=$MyInvocation.MyCommand.Name
	if($Ticket){Create-Ticket -data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,$SrcDir,$SrcPath,$DistDir,$DistPath"}
	
	}
end{
	popd
	}
}