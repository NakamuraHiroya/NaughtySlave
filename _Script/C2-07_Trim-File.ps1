function global:Trim-File{

# �v�疳�������ȕ�������t�@�C���P�ʂ�Trim����
# �E�_�u���N�I�[�e�[�V����
# �EBlank

param(
	$InFile=$(ls -name *.csv -Exclude _*|ogv -PassThru -Title "���͂���t�@�C�����w�肵�ĉ������B"),
	$OutFile=$InFile,
	$Ticket
)

$File=cat $InFile|%{$_ -replace "`"",""}|%{$_ -replace " ",""}
$File|Out-File $OutFile -Encoding Default

# �`�P�b�g���O�쐬
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,,,,,,$DistDir,$DistPath"}

}