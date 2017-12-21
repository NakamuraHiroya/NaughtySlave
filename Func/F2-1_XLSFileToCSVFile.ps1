function global:XLSFileToCSVFile{

param(
	$InFile=$(ls -name *.xls*|ogv -PassThru -Title "���͂���t�@�C�����w�肵�ĉ������B")
)

$excel=New-Object -ComObject Excel.Application
$excel.Visible=$false 
$excel.DisplayAlerts=$false

#�G�N�Z�����J��
$book=$excel.Workbooks.Open((Convert-path $InFile))

foreach($sheet in $book.sheets){
	$sheet.Activate()
	$OutFile=(($InFile -split "\.")[0])+"_"+$sheet.Name+".csv"

	#Sheet����1�̏ꍇ���̂܂܂̖��̂�CSV�ۑ�
	if((($book.sheets|measure).count) -eq 1){$OutFile=(($InFile -split "\.")[0])+".csv"}

	#Excel�𓯂��t�H���_�ɐV�KCSV�ۑ�
	$book.SaveAs((Split-Path(Convert-Path $InFile) -parent) + "\" + $OutFile,6)

}
$excel.Quit();$excel = $null

# �`�P�b�g���O�쐬
CreateTicketFile -data "XLSFileToCSVFile,$InFile"

}
