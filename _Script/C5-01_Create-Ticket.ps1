function global:Create-Ticket{

param(
	$data
)
$OutFile="_TicketList.csv"

if(-not(Test-Path($OutFile))){
	Set-Content $OutFile "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath,DefineSheet" -Encoding Default
}

Add-Content $OutFile $Data -Encoding Default

}