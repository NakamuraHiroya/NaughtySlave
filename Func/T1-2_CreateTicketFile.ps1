function global:CreateTicketFile{

# ticketlog���쐬�B

param(
	$Data
)
$OutFile="_TicketList_2.File.csv"


if(-not(Test-Path($OutFile))){
	Set-Content $OutFile "Ticket,FunctionName,InFile,OutFile,Data,Row,Line" -Encoding Default
}

Add-Content $OutFile $Data -Encoding Default

}