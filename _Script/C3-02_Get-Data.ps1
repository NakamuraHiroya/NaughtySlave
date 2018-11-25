function global:Get-Data{

# ����Ȃ���B

param(
	$WorkDir=$((pwd).path),
	$InFile=$($DataList.($DataList.Keys|sort|ogv -PassThru -Title "�擾����f�[�^��I�����ĉ������B")),
	$Line=$($InFile|ogv -PassThru -Title "�擾����s���w�肵�ĉ������B"),
	$Row=$($InFile|get-member|?{$_.MemberType -eq "NoteProperty"}|%{$_.Name}|ogv -PassThru -Title "�擾�������w�肵�ĉ������B"),
	$OutFile,
	$Ticket
)

if($OutFile){$Line|select $Row|Export-csv $OutFile -Encoding Default -NoTypeInformation}else{$Line|select $Row}

# �`�P�b�g���O�쐬
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,,,,,"}

}