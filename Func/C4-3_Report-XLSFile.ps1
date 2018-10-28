function global:Report-XLSFile{

param(
	$InFile=$(ls -name *.xls*|ogv -PassThru -Title "���͂���G�N�Z���t�@�C�����w�肵�ĉ������B"),
	$SheetName=$(Read-Host "�V�[�g������͂��ĉ������B"),
	$InputFile=$(ls -name *.csv|ogv -PassThru -Title "InputFile���w�肵�ĉ������B"),
	$OutFile=$($Infile+"_Report.xlsx")

)

$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false 
$excel.DisplayAlerts = $false

#�G�N�Z�����J��
$book = $excel.Workbooks.Open((Convert-path $InFile))

$Sheet=$book.sheets($SheetName)

ipcsv .\InputFile.csv -Encoding Default|%{$sheet.cells.item((GuessValueType($_.row)),(guessvaluetype($_.line)))=$_.value}

$book.SaveAs($OutFile)


$excel.Quit();$excel = $null

# �`�P�b�g���O�쐬
Add-Content _TicketList_File.csv ",XLSFileToCSVFile,$InFile" -Encoding Default

}

