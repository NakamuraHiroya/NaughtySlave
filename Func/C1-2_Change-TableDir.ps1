function global:Change-TableDir{

#—\‚ß—pˆÓ‚µ‚½TableDir‚ÉˆÚ“®‚·‚é

param(
	$Data=$($DataList.'TableList.csv'|ogv -passThru -Title "Table‚ð‘I‘ð‚µ‚Ä‰º‚³‚¢"),
	$Ticket

)

cd $data.WorkDir

if($Ticket){CreateTicketPath -Data "$Ticket,ChangeTableDir"}


}

