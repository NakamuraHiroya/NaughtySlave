function global:Add-LineForFile{

param(
	$InFile=$(ls -name *.csv,*.txt -Exclude _*|ogv -PassThru -Title "��������t�@�C�����w�肵�ĉ������B�������s�I��"),
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

# �`�P�b�g���O�쐬
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,,,,,,$DistDir,$DistPath"}

}