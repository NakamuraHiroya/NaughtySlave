function global:ExeTicket{

# ŠÖ”‚ªÀs‚³‚ê‚½Œã‚É“f‚«o‚³‚ê‚½TicketList‚ğŒ³‚ÉÀs

$Ticket_3 ="_TicketList_3.Data.csv"

$data = ipcsv $Ticket_3 -encoding default

# FunctionName,InFile,OutFile,Data,Raw

$data|%{$ExeList+=$_.FunctionName+" -infile "+$_.InFile+" -outfile "+$_.OutFile}

Invoke-expression $ExeList
}