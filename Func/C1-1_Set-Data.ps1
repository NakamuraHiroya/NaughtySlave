function global:Set-Data{

#ls -name *.csv -Exclude _*|%{$DataList+=@{$_=(ipcsv $_ -Encoding Default)}}

param(
	$WorkDir=$((pwd).path),
	$InFile=$(ls -name *.csv -Exclude _*),
	$Ticket
)

# ファイルが無ければ終了
if(-not $InFile){return}

$InFile|%{
	$global:DataList+=@{$_=(ipcsv $_ -Encoding Default)}
}

#Set-variable -name DataList -value $DataList

# チケットログ作成
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,,,,,,$DistDir,$DistPath"}

}