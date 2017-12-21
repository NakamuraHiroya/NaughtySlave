function global:CreateDirInfo{

param(
	$WorkDir=$pwd,
	$Header="ParentCode,WorkCode,WorkDir",
	$OutFile="DirList.csv"
)

pushd $WorkDir

Set-Content $OutFile $Header -Encoding Default

if(ls -dir){ls|?{$_.Attributes -like "Directory"}|%{$_.Parent.Name+","+$_.Name+","+$_.FullName}|Out-File $OutFile -append -Encoding default}

CreateTicketPath "CreatePathInfo,$WorkDir,-,$OutFile,$Header"

popd
}