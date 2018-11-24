function global:Get-Value{
# DefineSheet�Œ�`���ꂽ�O���}�X�^���w��Key�̎w��l���擾����֐��B

param(
	$InFile=$(ls -name *.csv -Exclude _*|ogv -passThru -Title "�t�@�C�����w�肵�ĉ������B"),
	$OutFile=$(($InFile -split "\.")[0]+"_Foreign.csv"),
	$DefineSheet=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$Ticket
)
$Data =ipcsv $InFile -encoding default

(ipcsv $DefineSheet -Encoding Default|?{$_.ForeignMaster})|%{
	if(-not($_.Property)){$Property="Property���ݒ肳��Ă��܂���"}else{$Property=$_.Property}
	if(-not($_.ForeignMaster)){$ForeignMaster="�O���}�X�^���ݒ肳��Ă��܂���"}else{$ForeignMaster=$datalist.($_.ForeignMaster)}
	if(-not($_.ForeignKey)){$ForeignKey="�O���L�[���ݒ肳��Ă��܂���"}else{$ForeignKey=$_.ForeignKey}
	if(-not($_.ForeignValue)){$ForeignValue="�擾�������񖼂��ݒ肳��Ă��܂���"}else{$ForeignValue=$_.ForeignValue}
		
	$data|%{
		$Src=$_.$Property
		$ForeignMaster|?{$_.($ForeignKey) -eq $Src}|%{$Src=$_.($ForeignValue)}
		$_.$Property=$Src
	}
}

$data|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default

#"Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath,DefineSheet"
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,,$InFile,$OutFile,,,,,,,,$DefineSheet"}

}