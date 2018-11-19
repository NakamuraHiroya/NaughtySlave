function global:Convert-CSVFilesToXLSFile{

# 複数のCSVファイルを1つのエクセルファイルにまとめる。indirect関数と併用する

param(
	$InFile=$(ls -name *.csv,*.xls*|ogv -PassThru -Title "マージするCSVファイル・エクセルファイルを指定して下さい。"),
	$outfile=$("_Merge.xlsx"),
	$Ticket
)

# baseとなるxlsxファイルを決める
$baseXlsFile=$Infile -split " "|?{$_ -like "*.xls*"}

# 付け足すCSVファイルを決める
$AddCSVFile=$InFile -split " "|?{$_ -like "*.csv"}

$excel=New-Object -ComObject Excel.Application
$excel.Visible=$false
$excel.DisplayAlerts=$false

$BaseBook=$excel.WorkBooks.open((convert-path $baseXlsFile))

$BaseSheet=$BaseBook.worksheets.item(1)

$addCSVFile|%{
	#$CsvBooks=$excel.Workbooks.Open((convert-path $_))
	#$CsvBooks.WorkSheets.item(($_.Split(".")[0])).copy($BaseSheet)
	($excel.Workbooks.Open((convert-path $_))).WorkSheets.item(($_.Split(".")[0])).copy($BaseSheet)
}

#$BaseBook.SaveAs((pwd).path + "\" + $OutFile,51)
$BaseBook.Save()

$excel.Quit()
$excel=$null

[GC]::Collect()

$FunctionName=$MyInvocation.MyCommand.Name
#Ticket,Timing,CommandName,SrcPath,InFile,OutFile,Row,Line
$InFile=("`"`"`""+$InFile+"`"`"`"")
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,,$InFile,$OutFile"}
}
