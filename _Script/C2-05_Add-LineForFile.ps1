function global:Add-LineForFile{

param(
	$InFile=$(ls -name *.csv,*.txt -Exclude _*|ogv -PassThru -Title "結合するファイルを指定して下さい。※複数行選択"),
	$OutFile=$("Merge.csv"),
	$Ticket
)

$InFile|%{
	if((ls $_).extension -eq ".csv"){
		(cat $_ -encoding default)|%{
			$data+=$_
			}
	}else{
		$data+=(cat $_)
	}

}

$data|Out-File $OutFile -Encoding Default

# チケットログ作成
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,,,,,,$DistDir,$DistPath"}

}