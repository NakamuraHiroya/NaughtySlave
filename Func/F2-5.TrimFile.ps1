function global:TrimFile{

# �v�疳�������ȕ�������t�@�C���P�ʂ�Trim����
# �E�_�u���N�I�[�e�[�V����
# �EBlank


param(
	$InFile=$(ls -name *.csv|ogv -PassThru -Title "���͂���t�@�C�����w�肵�ĉ������B"),
	$OutFile=$((($InFile -split "\.")[0])+"_Trim.csv")
)

cat $InFile|%{$_ -replace "`"",""}|%{$_ -replace " ",""}|Out-File $OutFile -Encoding Default



# �`�P�b�g���O�쐬
CreateTicketFile -Data "TrimFile,$InFile,$OutFile"


}