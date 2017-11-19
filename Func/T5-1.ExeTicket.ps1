function global:ExeTicket{

# 関数が実行された後に吐き出されたTicketListを元に実行

$Ticket_3 ="_TicketList_3.Data.csv"

$data = ipcsv $Ticket_3 -encoding default

# FunctionName,InFile,OutFile,Data,Raw

$data|%{$ExeList+=$_.FunctionName+" -infile "+$_.InFile+" -outfile "+$_.OutFile}

Invoke-expression $ExeList
}