function global:Change-TableDir{

#�\�ߗp�ӂ���TableDir�Ɉړ�����

param(
	$Data=$($DataList.'TableList.csv'|ogv -passThru -Title "Table��I�����ĉ�����"),
	$Ticket

)

cd $data.WorkDir

if($Ticket){CreateTicketPath -Data "$Ticket,ChangeTableDir"}


}

