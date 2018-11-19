function global:Convert-CSVFilesToXLSFile{

# ������CSV�t�@�C����1�̃G�N�Z���t�@�C���ɂ܂Ƃ߂�Bindirect�֐��ƕ��p����

param(
	$InFile=$(ls -name *.csv,*.xls*|ogv -PassThru -Title "�}�[�W����CSV�t�@�C���E�G�N�Z���t�@�C�����w�肵�ĉ������B"),
	$outfile=$("_Merge.xlsx"),
	$Ticket
)

# base�ƂȂ�xlsx�t�@�C�������߂�
$baseXlsFile=$Infile -split " "|?{$_ -like "*.xls*"}

# �t������CSV�t�@�C�������߂�
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
