function global:Create-Ticket{

# ticketlog���쐬�B1-5�Ƃ��ɕ������A�S�����ʂɏo����悤�ɂ���B�܂��ATiming���w��o����悤�ɂ���B

param(
	$data
)
$OutFile="_TicketList.csv"

if(-not(Test-Path($OutFile))){
	Set-Content $OutFile "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath,DefineSheet" -Encoding Default
}

Add-Content $OutFile $Data -Encoding Default

}