function global:Change-WorkDir{

#—\‚ß—pˆÓ‚µ‚½WorkDir‚ÉˆÚ“®‚·‚é

param(
	$Data=$($DataList.'WBS.csv'|ogv -passThru -Title "Work‚ð‘I‘ð‚µ‚Ä‰º‚³‚¢"),
	$ticket
)

$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,$FunctionName,$WorkDir,$InFile,$OutFile"}

cd $data.WorkDir
}

