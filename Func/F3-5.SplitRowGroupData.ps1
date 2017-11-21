function global:SplitRowGroupData{

param(
	$InFile=$(ls -name *.csv|ogv -PassThru -Title "���͂���t�@�C�����w�肵�ĉ������B"),
	$Data=$(ipcsv $Infile -Encoding Default),
	$raw=$((cat $InFile)[0] -split ","|ogv -PassThru -Title "�����Ώۂ̗񖼂�I�����ĉ������B"),
	$OutFile=$(($InFile -split "\.")[0])
)

# �y�z��[]��/��ϊ����Ȃ��ƃ_���I
$data|group $raw|%{$name=$_.Name;$_.Group|Export-CSV ($OutFile+"_"+$name+".csv") -Encoding Default -NoTypeInformation}

# �`�P�b�g���O�쐬
CreateTicketData -data "SplitRowGroupData,$InFile,$OutFile,$Data,$raw"


}