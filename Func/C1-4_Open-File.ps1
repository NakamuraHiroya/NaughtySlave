function global:Open-File{

param(
	$WorkDir=$((pwd).path),
	$InFile=$(ls -name -file|ogv -passThru -Title "ファイルを選択して下さい。"),
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
	# TODO エディタで開くかエクセルで開くか選べるよーにする。

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

# チケットログ作成 "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath"
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,,,,`"`"`"$SrcDir`"`"`",`"`"`"$SrcPath`"`"`",`"`"`"$DistDir`"`"`",`"`"`"$DistPath`"`"`","}

}