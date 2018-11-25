function global:Open-WEBSite{

param(
	$WorkDir=$((pwd).path),
	$SrcPath=$($DataList["WEBServiceList.csv"]|ogv -PassThru -Title "取得するURLを指定して下さい。"|%{$_.URL}),
	$Ticket
)

$ie=New-Object -ComObject InternetExplorer.Application
$ie.Visible = $true
$ie.Navigate($SrcPath)

$FunctionName=$MyInvocation.MyCommand.Name
#"Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath"
if($Ticket){Create-Ticket -data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,$SrcDir,$SrcPath,$DistDir,$DistPath"}
}