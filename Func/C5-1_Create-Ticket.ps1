function global:Create-Ticket{

# ticketlogを作成。1-5とかに分けず、全部共通に出来るようにする。また、Timingを指定出来るようにする。

param(
	$data
)
$OutFile="_TicketList.csv"

if(-not(Test-Path($OutFile))){
	Set-Content $OutFile "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath,DefineSheet" -Encoding Default
}

Add-Content $OutFile $Data -Encoding Default

}