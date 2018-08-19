function global:Create-DirInfo{

# Set-Content test.csv `"`"`"pipi`,hihi`,llll`"`"`" -Encoding Default

param(
	$WorkDir=$pwd,
	$Row="SecondDirCode,ParentCode,WorkCode,WorkDir",
	$OutFile="DirList.csv",
	$Ticket
)

pushd $WorkDir

#2�K�w��̃f�B���N�g��
$SecondDir=Split-Path (Split-Path $WorkDir -Parent) -leaf

Set-Content $OutFile $Row -Encoding Default

if(ls -dir){ls|?{$_.Attributes -like "Directory"}|%{$SecondDir+","+$_.Parent.Name+","+$_.Name+","+$_.FullName}|Out-File $OutFile -append -Encoding default}

# �`�P�b�g���O�쐬
$FunctionName=$MyInvocation.MyCommand.Name
#"Ticket,Timing,CommandName,SrcPath,InFile,OutFile,Row,Line"
$Row=("`"`"`""+$Row+"`"`"`"")
if($Ticket){Create-Ticket "$Ticket,Always,$FunctionName,,,$OutFile,$Row"}

popd
}