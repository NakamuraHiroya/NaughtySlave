function global:Report-XLSFile{

param(
	$InFile=$(ls -name *.xls*|ogv -PassThru -Title "入力するエクセルファイルを指定して下さい。"),
	$SheetName=$(Read-Host "シート名を入力して下さい。"),
	$InputFile=$(ls -name *.csv|ogv -PassThru -Title "InputFileを指定して下さい。"),
	$OutFile=$($Infile+"_Report.xlsx")

)

$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false 
$excel.DisplayAlerts = $false

#エクセルを開く
$book = $excel.Workbooks.Open((Convert-path $InFile))

$Sheet=$book.sheets($SheetName)

ipcsv .\InputFile.csv -Encoding Default|%{$sheet.cells.item((GuessValueType($_.row)),(guessvaluetype($_.line)))=$_.value}

$book.SaveAs($OutFile)


$excel.Quit();$excel = $null

# チケットログ作成
Add-Content _TicketList_File.csv ",XLSFileToCSVFile,$InFile" -Encoding Default

}

