function global:XLSFileToCSVFile{

param(
	$InFile=$(ls -name *.xls*|ogv -PassThru -Title "���͂���t�@�C�����w�肵�ĉ������B")
)

$excel = New-Object -ComObject Excel.Application
$excel.Visible=$false 
$excel.DisplayAlerts=$false

#�G�N�Z�����J��
$book=$excel.Workbooks.Open((Convert-path $InFile))

foreach($sheet in $book.sheets){
	$sheet.Activate()
	$CSVFileName=(($InFile -split "\.")[0])+"_"+$sheet.Name+".csv"
	#Excel�𓯂��t�H���_�ɐV�KCSV�ۑ�����
	$book.SaveAs((Split-Path(Convert-Path $InFile) -parent) + "\" + $CSVFileName,6)

}
$excel.Quit();$excel = $null

# �`�P�b�g���O�쐬
CreateTicketFile -data "XLSFileToCSVFile,$InFile"


}

