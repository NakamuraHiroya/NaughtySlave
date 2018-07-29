function global:Change-WorkDir{

#予め用意したWorkDirに移動する

param(
	$Data=$($DataList.'WBS.csv'|ogv -passThru -Title "Workを選択して下さい"),
	$ticket
)

$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,$FunctionName,$WorkDir,$InFile,$OutFile"}

cd $data.WorkDir
}

