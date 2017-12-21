function global:XLSFileToCSVFile{

param(
	$InFile=$(ls -name *.xls*|ogv -PassThru -Title "入力するファイルを指定して下さい。")
)

$excel=New-Object -ComObject Excel.Application
$excel.Visible=$false 
$excel.DisplayAlerts=$false

#エクセルを開く
$book=$excel.Workbooks.Open((Convert-path $InFile))

foreach($sheet in $book.sheets){
	$sheet.Activate()
	$OutFile=(($InFile -split "\.")[0])+"_"+$sheet.Name+".csv"

	#Sheet数が1の場合そのままの名称でCSV保存
	if((($book.sheets|measure).count) -eq 1){$OutFile=(($InFile -split "\.")[0])+".csv"}

	#Excelを同じフォルダに新規CSV保存
	$book.SaveAs((Split-Path(Convert-Path $InFile) -parent) + "\" + $OutFile,6)

}
$excel.Quit();$excel = $null

# チケットログ作成
CreateTicketFile -data "XLSFileToCSVFile,$InFile"

}
