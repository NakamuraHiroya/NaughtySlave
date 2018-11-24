function global:Gather-File{

# 

param(
	$WorkDir=$((pwd).path),
	$InFile="_TicketList.csv",
	$Value="*",
	$OutFile="_GatherList.csv",
	$Ticket
)
ls -dir -name $Value|%{if(ls $_ $InFile){(ipcsv (join-path $_ $InFile) -Encoding Default)}}|
ConvertTo-Csv -NoTypeInformation|%{$_.replace('"','')}|Out-File $OutFile -encoding default

# チケットログ作成 "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath"
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,`"`"`"$InFile`"`"`",$OutFile,,,$Value,,,,,"}

}