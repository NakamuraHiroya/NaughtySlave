function global:Insert-LineForFile{
# �t�@�C���ɑ΂��āA�s��}������B

param(
	$InFile=$(ls -name *.csv|ogv -PassThru -Title "���͂���t�@�C�����w�肵�ĉ������B"),
	$Line=$(Read-Host "�}���������s�ԍ�����͂��ĉ������B"),
	$Value=(Read-Host "�}���������l����͂��ĉ������B"),
	$OutFile=$($InFile+"_Insert.csv"),
	$Ticket
)

# cat�ōs�ԍ��t��������
#(cat $InFile|%{[void][int]$i;([string]$j=$i)+":"+$_;[void][int]$i++})

#�}���O+�f�[�^+�}����
(cat $InFile|select -first $Line)+$Value+(cat $InFile|select -skip $Line)|Out-File $OutFile -Encoding Default

# �`�P�b�g���O�쐬
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,,,$DistDir,$DistPath"}

}