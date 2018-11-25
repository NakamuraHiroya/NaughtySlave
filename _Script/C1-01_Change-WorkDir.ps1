function global:Change-WorkDir{

#予め用意したWorkDirに移動する

param(
	$SrcPath=$(($DataList.'WBS.csv'|ogv -passThru -Title "Workを選択して下さい").WorkDir),
	$ticket
)

if(-not $SrcPath){return}

$FunctionName=$MyInvocation.MyCommand.Name
#"Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath"
if($Ticket){Create-Ticket -Data "$Ticket,$FunctionName,`"`"`"$SrcPath`"`"`",$InFile,$OutFile"}

cd $SrcPath

}

