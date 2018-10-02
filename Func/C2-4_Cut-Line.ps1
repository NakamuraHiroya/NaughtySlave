function global:Cut-Line{

# �w��̃t�@�C������A�s�ԍ���I�������āACut�������B

param(
	$Infile=$(ls -name *.csv|ogv -passthru -title "�s�폜����CSV�t�@�C����I�����ĉ������B"),
	$OutFile=$($InFile),
	[Int]$Line=$(Read-Host "�폜�Ώۍs�ԍ�����͂��ĉ������B"),
	$Ticket
)

$Data=cat $InFile|select -Skip $Line
$Data|Out-File $OutFile -Encoding Default 

# �`�P�b�g���O�쐬
#Ticket,Timing,CommandName,SrcPath,InFile,OutFile,Row,Line
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,,$InFile,$OutFile,,$Line"}

}



