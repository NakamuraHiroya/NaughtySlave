function global:InsertLineForFile{

param(
	$InFile=$(ls -name *.csv|ogv -PassThru -Title "���͂���t�@�C�����w�肵�ĉ������B"),
	$No=(Read-Host "�}���������s�ԍ�����͂��ĉ������B"),
	$InputValue=(Read-Host "�}���������f�[�^����͂��ĉ������B"),
	$OutFile=$InFile
)
#�}���O+�f�[�^+�}����
(cat $InFile|select -first $No)+$InputValue+(cat cashlist.csv|select -skip $no)|Out-File $OutFile -Encoding Default

# �`�P�b�g���O�쐬
Add-Content _TicketList_File.csv ",InsertLineForFile,$InFile,$No,$InputValue,$OutFile" -Encoding Default

}