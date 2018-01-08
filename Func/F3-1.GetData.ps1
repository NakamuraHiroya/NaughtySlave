function global:GetData{

param(
	$Data=$($DataList.($DataList.Keys|sort|ogv -PassThru -Title "取得するデータを選択して下さい。")),
	$Line=$($Data|ogv -PassThru -Title "取得する行を指定して下さい。"),
	$Row=$($Data|get-member|?{$_.MemberType -eq "NoteProperty"}|%{$_.Name}|ogv -PassThru -Title "取得する列を指定して下さい。"),
	$OutFile,
	$Ticket
)

$Line|select $Row

if($OutFile){$Line|select $Row|Export-csv $OutFile -Encoding Default -NoTypeInformation}

if($Ticket){CreateTicketData -data "$Ticket,GetData,-,$OutFile,$Data,$Row,$Line"}

}