function global:Trim-Row{

# �w�肵����̎w�蕶����Trim����B
# ���ǂƂ肠�������́A�J���}��؂�̐��lTrim����

param(
	$InFile=$(ls -name *.csv -Exclude Define*,_*|ogv -passThru -Title "�t�@�C�����w�肵�ĉ������B"),
	$WorkDir=$((pwd).path),
	$PropertyFile=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$Row=$((cat $InFile -First 1).Split(",")|ogv -passThru -Title "Trim�������w�肵�ĉ������B"),
	$OutFile=$($InFile),
	$Ticket
)

$data=ipcsv $InFile -encoding default

$data|%{$_.($Row)=$_.($Row).replace(',','')}
$data|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default

# �`�P�b�g���O�쐬 "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath"
$FunctionName=$MyInvocation.MyCommand.Name
#Ticket,Timing,CommandName,SrcPath,InFile,OutFile,Row,Line
$InFile=("`"`"`""+$InFile+"`"`"`"")
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row"}


}