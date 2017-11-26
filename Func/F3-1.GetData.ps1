function global:GetData{

param(
	$Data=$($DataList.($DataList.Keys|sort|ogv -PassThru -Title "取得するデータを選択して下さい。")),
	$Line=$($Data|ogv -PassThru -Title "取得する行を指定して下さい。"),
	$Row=$($Data|get-member|?{$_.MemberType -eq "NoteProperty"}|%{$_.Name}|ogv -PassThru -Title "取得する列を指定して下さい。")

)

$Line|select $Row


CreateTicketData "GetValue,-,-,$Data,$Row,$Line"

}