function global:CreateTicketPath{

# ticketlog���쐬�B

param(
	$data
)
$OutFile="_TicketList_1.Path.csv"


if(-not(Test-Path($OutFile))){
	Set-Content $OutFile "FunctionName,WorkDir,InFile,OutFile,Header" -Encoding Default
}

Add-Content $OutFile $Data -Encoding Default

}