function global:Change-WorkDir{

#�\�ߗp�ӂ���WorkDir�Ɉړ�����

param(
	$Data=$($DataList.'WBS.csv'|ogv -passThru -Title "Work��I�����ĉ�����"),
	$ticket
)

$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,$FunctionName,$WorkDir,$InFile,$OutFile"}

cd $data.WorkDir
}

