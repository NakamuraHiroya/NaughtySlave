function global:GetData{

param(
	$Data=$($DataList.($DataList.Keys|sort|ogv -PassThru -Title "�擾����f�[�^��I�����ĉ������B")),
	$Line=$($Data|ogv -PassThru -Title "�擾����s���w�肵�ĉ������B"),
	$Row=$($Data|get-member|?{$_.MemberType -eq "NoteProperty"}|%{$_.Name}|ogv -PassThru -Title "�擾�������w�肵�ĉ������B")

)

$Line|select $Row


CreateTicketData "GetValue,-,-,$Data,$Row,$Line"

}