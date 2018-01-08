function global:GetData{

param(
	$Data=$($DataList.($DataList.Keys|sort|ogv -PassThru -Title "�擾����f�[�^��I�����ĉ������B")),
	$Line=$($Data|ogv -PassThru -Title "�擾����s���w�肵�ĉ������B"),
	$Row=$($Data|get-member|?{$_.MemberType -eq "NoteProperty"}|%{$_.Name}|ogv -PassThru -Title "�擾�������w�肵�ĉ������B"),
	$OutFile,
	$Ticket
)

$Line|select $Row

if($OutFile){$Line|select $Row|Export-csv $OutFile -Encoding Default -NoTypeInformation}

if($Ticket){CreateTicketData -data "$Ticket,GetData,-,$OutFile,$Data,$Row,$Line"}

}