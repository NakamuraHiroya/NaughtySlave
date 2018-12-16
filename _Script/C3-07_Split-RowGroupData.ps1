function global:Split-RowGroupData{

param(
	$InFile=$(ls -name *.csv -Exclude _*|ogv -PassThru -Title "���͂���t�@�C�����w�肵�ĉ������B"),
	$WorkDir=$((pwd).path),
	$Data=$(ipcsv $Infile -Encoding Default),
	$Row=$((cat $InFile)[0] -split ","|ogv -PassThru -Title "�����Ώۂ̗񖼂�I�����ĉ������B"),
	$OutFile=$(($InFile -split "\.")[0]),
	$Ticket
)
begin{
	pushd $WorkDir
	}
process{
	# �y�z��[]��/��ϊ����Ȃ��ƃ_���I
	$data|group $Row|%{$name=$_.Name;$_.Group|Export-CSV ($OutFile+"_"+$name+".csv") -Encoding Default -NoTypeInformation}
	
	# �_�u���N�I�[�e�[�V����Trim
	$data|group $Row|%{Trim-File ($OutFile+"_"+$_.Name+".csv")}

	# �`�P�b�g���O�쐬 
	$FunctionName=$MyInvocation.MyCommand.Name
	if($Ticket){Create-Ticket -data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,$SrcDir,$SrcPath,$DistDir,$DistPath,$DefineSheet"}
	}
end{
	popd
	}
}