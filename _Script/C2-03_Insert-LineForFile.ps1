function global:Insert-LineForFile{
# �t�@�C���ɑ΂��āA�s��}������B

param(
	$InFile=$(ls -name *.csv|ogv -PassThru -Title "���͂���t�@�C�����w�肵�ĉ������B"),
	$Line=$(Read-Host "�}���������s�ԍ�����͂��ĉ������B"),
	$Value=(Read-Host "�}���������l����͂��ĉ������B"),
	$OutFile=$(($InFile -split "\.")[0]+"_Insert.csv"),
	$Ticket
)

if($Line -eq 1){
	[int]$i=1
	$Data=(cat $InFile|%{if($i -eq 1){$Value+"`r`n"+$_}else{$_};$i++})
	$Data|Out-File $OutFile -Encoding Default
}else{
	(cat $InFile|select -first $Line)+$Value+(cat $InFile|select -skip $Line)|Out-File $OutFile -Encoding Default
}

# �`�P�b�g���O�쐬
# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
$FunctionName=$MyInvocation.MyCommand.Name
$Value=("`"`"`""+$Value+"`"`"`"")
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,,,$DistDir,$DistPath"}

}