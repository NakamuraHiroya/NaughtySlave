function global:Change-WorkDir{

#�\�ߗp�ӂ���WorkDir�Ɉړ�����

param(
	$SrcPath=$(($DataList.'WBS.csv'|ogv -passThru -Title "Work��I�����ĉ�����").WorkDir),
	$ticket
)

if(-not $SrcPath){return}

$FunctionName=$MyInvocation.MyCommand.Name
#"Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath"
if($Ticket){Create-Ticket -Data "$Ticket,$FunctionName,`"`"`"$SrcPath`"`"`",$InFile,$OutFile"}

cd $SrcPath

}

