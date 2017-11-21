function global:XLSFileToCSVFile{

param(
	$InFile=$(ls -name *.xls*|ogv -PassThru -Title "入力するファイルを指定して下さい。")
)

$excel = New-Object -ComObject Excel.Application
$excel.Visible=$false 
$excel.DisplayAlerts=$false

#エクセルを開く
$book=$excel.Workbooks.Open((Convert-path $InFile))

foreach($sheet in $book.sheets){
	$sheet.Activate()
	$CSVFileName=(($InFile -split "\.")[0])+"_"+$sheet.Name+".csv"
	#Excelを同じフォルダに新規CSV保存する
	$book.SaveAs((Split-Path(Convert-Path $InFile) -parent) + "\" + $CSVFileName,6)

}
$excel.Quit();$excel = $null

# チケットログ作成
CreateTicketFile -data "XLSFileToCSVFile,$InFile"


}

