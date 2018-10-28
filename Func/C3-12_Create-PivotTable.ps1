function global:Create-PivotTable{

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "PivotTable���쐬�������t�@�C����I�����ĉ������B"),
	$Row=$((cat $InFile -First 1) -split ","|ogv -PassThru -Title "�W�v�̃L�[���I�����ĉ������B"),
	$Line=$((cat $InFile -First 1) -split ","|ogv -PassThru -Title "�W�v�Ώۍ��ڂ�I�����ĉ������B��Ctrl�I���ŕ����s��"),
	$OutFile=$(($InFile -split "\.")[0]+"_PivotTable.csv"),
	$Ticket
)

$result=ipcsv $infile -encoding default|group $Row|select name,@{Name=[string]$Line;Expression={($_.group|measure -sum $Line).sum}}
$result|ConvertTo-Csv -NoTypeInformation|%{$_.replace('"','')}|%{$_.replace(' ',',')}|Out-File $OutFile -Encoding Default

# �`�P�b�g���O�쐬
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,,,,$DistDir,$DistPath"}

}
