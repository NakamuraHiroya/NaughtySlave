function global:CSVFilesTo-XLSFile{

param(
	$InFile=$(ls -name *.csv|ogv -PassThru -Title "���͂���CSV�t�@�C�����w�肵�ĉ������B"),
	$outfile=$(((ls $Infile).basename)+".xlsx"),
	$Ticket
)

#CSVFilesToXLSFile
#�I�����ꂽCSVInFile�Q����ɓZ�߂��G�N�Z���ɂ���֐������

$infile=$(ls -name *.csv|ogv -PassThru -Title "���͂���CSV�t�@�C���̌��t�@�C�����w�肵�ĉ������B")
$InFile_Basename=(ls $Infile).basename

$InFiles=ls *$InFile_Basename*.csv -name

$excel=New-Object -ComObject Excel.Application
$excel.Visible=$true
$excel.DisplayAlerts=$false

$book=$excel.WorkBooks.Add()

foreach($File in $InFiles){

	$tmp=$excel.Workbooks.Open((convert-path $File))
	$tmp.workSheets.item(($File).Split(".")[0]).copy($book.Worksheets.item("Sheet1"))
	
	sleep 1

}
	$excel.WorkSheets.item("Sheet1").delete()
	$book.SaveAs((Split-Path(Convert-Path $InFile) -parent) + "\" + $OutFile,51)

$excel.Quit()
$excel=$null

[GC]::Collect()

# �`�P�b�g���O�쐬
if($Ticket){#CreateTicketFile -Data "$Ticket,CSVFilesTo-XLSFile,$InFile,$OutFile"}
}

}