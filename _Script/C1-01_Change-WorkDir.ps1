function global:Change-WorkDir{

#予め用意したWorkDirに移動する

param(
	$SrcPath=$(($DataList.'WBS.csv'|ogv -passThru -Title "Workを選択して下さい").WorkDir),
	$ticket
)

if(-not $SrcPath){return}

$FunctionName=$MyInvocation.MyCommand.Name
#Ticket,Timing,CommandName,SrcPath,InFile,OutFile,Row,Line
if($Ticket){Create-Ticket -Data "$Ticket,$FunctionName,`"`"`"$SrcPath`"`"`",$InFile,$OutFile"}

cd $SrcPath

}

