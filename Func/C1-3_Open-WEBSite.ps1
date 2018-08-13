function global:Open-WEBSite{

param(
	$URL=$($DataList["WEBServiceList.csv"]|ogv -PassThru -Title "�擾����URL���w�肵�ĉ������B"|%{$_.URL}),
	$Ticket
)

$ie=New-Object -ComObject InternetExplorer.Application
$ie.Visible = $true
$ie.Navigate($URL)

$FunctionName=$MyInvocation.MyCommand.Name
#Ticket,Timing,CommandName,SrcPath,InFile,OutFile,Row,Line
if($Ticket){Create-Ticket -data "$Ticket,Always,$FunctionName,$URL,,$OutFile,$Row,$Line"}
}