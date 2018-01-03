function global:SplitRowGroupData{

param(
	$InFile=$(ls -name *.csv -Exclude _*|ogv -PassThru -Title "���͂���t�@�C�����w�肵�ĉ������B"),
	$Data=$(ipcsv $Infile -Encoding Default),
	$raw=$((cat $InFile)[0] -split ","|ogv -PassThru -Title "�����Ώۂ̗񖼂�I�����ĉ������B"),
	$OutFile=$(($InFile -split "\.")[0]),
	$Ticket
)

# �y�z��[]��/��ϊ����Ȃ��ƃ_���I
$data|group $raw|%{$name=$_.Name;$_.Group|Export-CSV ($OutFile+"_"+$name+".csv") -Encoding Default -NoTypeInformation}

# �_�u���N�I�[�e�[�V����Trim
$data|group $raw|%{TrimFile ($OutFile+"_"+$_.Name+".csv")}


# �`�P�b�g���O�쐬
if($Ticket){CreateTicketData -data "$Ticket,SplitRowGroupData,$InFile,$OutFile,$Data,$raw"}


}