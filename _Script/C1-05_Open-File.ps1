function global:Open-File{

param(
	$WorkDir=$((pwd).path),
	$InFile=$(ls -name -file|ogv -passThru -Title "ファイルを選択して下さい。"),
	$Ticket
)

$extension=(($InFile -split "\.")[1])

switch($extension){

xlsx{
	$excel = New-Object -ComObject Excel.Application
	$excel.Visible = $true
	$excel.DisplayAlerts = $false
	$book = $excel.Workbooks.Open((Convert-path $InFile))
}
xls{
	$excel = New-Object -ComObject Excel.Application
	$excel.Visible = $true
	$excel.DisplayAlerts = $false
	$book = $excel.Workbooks.Open((Convert-path $InFile))
}
csv{
	# TODO エディタで開くかエクセルで開くか選べるようにする。
	$excel = New-Object -ComObject Excel.Application
	$excel.Visible = $true
	$excel.DisplayAlerts = $false
	$book = $excel.Workbooks.Open((Convert-path $InFile))
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
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,`"`"`"$InFile`"`"`",$OutFile,,,,,,,,"}

# 一番最後に、excelkillする処理入れる。
# Stop-Process excel -ErrorAction SilentlyContinue 
# Get-Process excel -ea 0|?{$_.MainWindowsTitle -like '*report.csv*'}|Stop-Process

}