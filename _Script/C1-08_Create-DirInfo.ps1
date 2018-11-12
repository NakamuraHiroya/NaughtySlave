function global:Create-DirInfo{

# Set-Content test.csv `"`"`"pipi`,hihi`,llll`"`"`" -Encoding Default

param(
	$WorkDir=$pwd,
	$InFile="*",
	$Row="SecondDirCode,ParentCode,WorkCode,WorkDir",
	$OutFile="DirList.csv",
	$Ticket
)

pushd $WorkDir

#2階層上のディレクトリ
$SecondDir=Split-Path (Split-Path $WorkDir -Parent) -leaf

Set-Content $OutFile $Row -Encoding Default

if(ls -dir){ls -exclude _*|?{$_.Attributes -like "Directory"}|?{$_.Name -like $InFile}|%{$SecondDir+","+$_.Parent.Name+","+$_.Name+","+$_.FullName}|Out-File $OutFile -append -Encoding default}

# チケットログ作成
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
$Row=("`"`"`""+$Row+"`"`"`"")
if($Ticket){Create-Ticket "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row"}

popd
}