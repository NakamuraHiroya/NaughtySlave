function global:Change-TableDir{

#予め用意したTableDirに移動する

param(
	$Data=$($DataList.'TableList.csv'|ogv -passThru -Title "Tableを選択して下さい"),
	$Ticket

)

cd $data.WorkDir

if($Ticket){CreateTicketPath -Data "$Ticket,ChangeTableDir"}


}

