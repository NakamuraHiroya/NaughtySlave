function global:Change-WorkDir{

#�\�ߗp�ӂ���WorkDir�Ɉړ�����

param(
	$SrcPath=$(($DataList.'WBS.csv'|ogv -passThru -Title "Work��I�����ĉ�����").WorkDir),
	$ticket
)

if(-not $SrcPath){return}

$FunctionName=$MyInvocation.MyCommand.Name
#Ticket,Timing,CommandName,SrcPath,InFile,OutFile,Row,Line
if($Ticket){Create-Ticket -Data "$Ticket,$FunctionName,`"`"`"$SrcPath`"`"`",$InFile,$OutFile"}

cd $SrcPath

}

