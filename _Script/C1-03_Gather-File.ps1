function global:Gather-File{

# $Value�����Ŏw�肵��1�K�w���̃f�B���N�g���ɂ���$InFile�������W����$OutFile�������݂̃f�B���N�g���ɍ쐬���܂��B

param(
	$WorkDir=$((pwd).path),
	$InFile="_TicketList.csv",
	$Value="*",
	$OutFile="_GatherList.csv",
	$Ticket
)
ls -dir -name $Value|%{if(ls $_ $InFile){(ipcsv (join-path $_ $InFile) -Encoding Default)}}|
ConvertTo-Csv -NoTypeInformation|%{$_.replace('"','')}|Out-File $OutFile -encoding default

# �`�P�b�g���O�쐬 "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath"
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,`"`"`"$InFile`"`"`",$OutFile,,,$Value,,,,,"}

}