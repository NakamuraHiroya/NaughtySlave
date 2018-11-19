function global:Set-Data{

param(
	$WorkDir=$((pwd).path),
	$InFile=$(ls -name $WorkDir *.csv -Exclude _*),
	$Ticket
)
begin{ pushd $WorkDir } process {

# ファイルが無ければ終了
if(-not $InFile){return}

$InFile|%{
	$global:DataList+=@{$_=(ipcsv $_ -Encoding Default)}
}

# チケットログ作成
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,,,,,,$DistDir,$DistPath"}

} end { popd } }
