function global:Open-File{

param(
	$WorkDir=$((pwd).path),
	$InFile=$(ls -name -file|ogv -passThru -Title "�t�@�C����I�����ĉ������B"),
	$Ticket
)

$extension=(($InFile -split "\.")[1])

$extension

switch($extension){

xlsx{
	$excel = New-Object -ComObject Excel.Application
	$excel.Visible = $true
	$excel.DisplayAlerts = $false
	$book = $excel.Workbooks.Open((Convert-path $XLSFile))

}
xls{
	$excel = New-Object -ComObject Excel.Application
	$excel.Visible = $true
	$excel.DisplayAlerts = $false
	$book = $excel.Workbooks.Open((Convert-path $XLSFile))

}
csv{
	# TODO �G�f�B�^�ŊJ�����G�N�Z���ŊJ�����I�ׂ��[�ɂ���B

	$excel = New-Object -ComObject Excel.Application
	$excel.Visible = $true
	$excel.DisplayAlerts = $false
	$book = $excel.Workbooks.Open((Convert-path $XLSFile))

}
ps1{
	Invoke-Item $Infile
}
txt{
	Invoke-Item $InFile
}

}

# �`�P�b�g���O�쐬 "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath"
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,,,,`"`"`"$SrcDir`"`"`",`"`"`"$SrcPath`"`"`",`"`"`"$DistDir`"`"`",`"`"`"$DistPath`"`"`","}

}