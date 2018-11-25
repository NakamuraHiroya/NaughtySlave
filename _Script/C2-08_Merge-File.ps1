function global:Merge-File{
# 2�ȏ�́A�u�񖼁v������CSV�t�@�C���̃f�[�^���}�[�W����B

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "merge����t�@�C����I�����ĉ������B"),
	$OutFile=$(($InFile -split "\.")[0]+"_Merge.csv"),
	$Ticket
)

$InFile -split " "|%{
	$data+=ipcsv $_ -encoding default
}

$data|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default

$FunctionName=$MyInvocation.MyCommand.Name
#Ticket,Timing,CommandName,SrcPath,InFile,OutFile,Row,Line
$InFile=("`"`"`""+$InFile+"`"`"`"")
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,,$InFile,$OutFile"}

# �`�P�b�g���O�쐬
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,,$Value,,,$DistDir,$DistPath"}


}
