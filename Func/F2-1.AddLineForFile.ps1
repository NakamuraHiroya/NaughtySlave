function global:AddLineForFile{

param(
	$InFile=$(ls -name *.csv|ogv -PassThru -Title "���͂���t�@�C�����w�肵�ĉ������B"),
	$InputValue=(Read-Host "�}���������f�[�^����͂��ĉ������B"),
	$OutFile=$InFile
)

Add-content $InFile $InputValue -encoding default

# �`�P�b�g���O�쐬
Add-Content _TicketList_File.csv ",AddLineForFile,$InFile,$OutFile,$InputValue" -Encoding Default

}