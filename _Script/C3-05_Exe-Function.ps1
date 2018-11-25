function global:Exe-Function{

# ��`�V�[�g��Function��ɑ΂��Ċ֐������s
# $OutFile=$(($InFile -split "\.")[0]+"_Custom.csv"),

param(
	$InFile=$(ls -name *.csv -Exclude Define*,_*|ogv -passThru -Title "�t�@�C�����w�肵�ĉ������B"),
	$DefineSheet=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$Data=$(ipcsv $InFile -Encoding Default),
	$OutFile=$($InFile),
	$Ticket
)

$Property_CustomList=ipcsv $DefineSheet -encoding default|?{$_.Function}

$Property_CustomList|%{
	$Property=$_.Property
	$Function=$_.Function
	
	$Data|%{$_.$Property=(Invoke-Expression $Function)}
	$Data|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default
	#$Data|Export-Csv $OutFile -Encoding Default -NoTypeInformation
}

# �`�P�b�g���O�쐬
#"Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath,DefineSheet"
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,,$InFile,$OutFile,,,,,,,,$DefineSheet"}

}