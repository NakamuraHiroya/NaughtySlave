function global:XLSFileToCSVFile{

param(
	[Parameter(ValueFromPipeline)]$XLSFileName

)

$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false 
$excel.DisplayAlerts = $false

#エクセルを開く
$book = $excel.Workbooks.Open((Convert-path $XLSFileName))

foreach($sheet in $book.sheets){
	$sheet.Activate()
	$CSVFileName=$XLSFileName+"_"+$sheet.Name+".csv"
	#Excelを同じフォルダに新規CSV保存する
	$book.SaveAs((Split-Path(Convert-Path $XLSFileName) -parent) + "\" + $CSVFileName,6)

}
$excel.Quit();$excel = $null
}

