function global:Change-WorkDir{

#—\‚ß—pˆÓ‚µ‚½WorkDir‚ÉˆÚ“®‚·‚é

param(
	$SrcPath=$(($DataList.'WBS.csv'|ogv -passThru -Title "Work‚ð‘I‘ð‚µ‚Ä‰º‚³‚¢").WorkDir),
	$ticket
)

if(-not $SrcPath){return}

$FunctionName=$MyInvocation.MyCommand.Name
#"Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath"
if($Ticket){Create-Ticket -Data "$Ticket,$FunctionName,`"`"`"$SrcPath`"`"`",$InFile,$OutFile"}

cd $SrcPath

}

