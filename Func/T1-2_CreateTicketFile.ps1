function global:CreateTicketFile{

# ticketlog���쐬�B

param(
	$data
)
$OutFile="_TicketList_2.File.csv"


if(-not(Test-Path($OutFile))){
	Set-Content $OutFile "FunctionName,InFile,OutFile,Data,Raw" -Encoding Default
}

Add-Content $OutFile $Data -Encoding Default

}