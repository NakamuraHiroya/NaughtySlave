function global:ExeTicket{

# �֐������s���ꂽ��ɓf���o���ꂽTicketList�����Ɏ��s

$Ticket_3 ="_TicketList_3.Data.csv"

$data = ipcsv $Ticket_3 -encoding default

# FunctionName,InFile,OutFile,Data,Raw

$data|%{$ExeList+=$_.FunctionName+" -infile "+$_.InFile+" -outfile "+$_.OutFile}

Invoke-expression $ExeList
}