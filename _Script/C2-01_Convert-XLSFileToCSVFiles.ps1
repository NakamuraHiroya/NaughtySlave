function global:Convert-XLSFileToCSVFiles{

param(
	$InFile=$(ls -name *.xls*|ogv -PassThru -Title "���͂���t�@�C�����w�肵�ĉ������B"),
	$WorkDir=$((pwd).path),
	$OutFile,
	$Ticket
)
begin{
	if(Test-Path $WorkDir){pushd $WorkDir}else{$WorkDir+" PATH FAULT!!!";$WorkDir=$((pwd).path);pushd $WorkDir}
	$excel=New-Object -comobject Excel.Application
	$excel.Visible=$false 
	$excel.DisplayAlerts=$false
	}
process {
	# ���C���h�J�[�h������
	if($InFile -eq "*"){$InFile=ls -name *.xls* -Exclude _*}else{$InFile=$InFile -split " "}

	$InFile|%{
		#�G�N�Z�����J��
		$book=$excel.Workbooks.Open((Convert-path $_))

		foreach($sheet in $book.sheets){
			$sheet.Activate()
			$OutFile=(($_ -split "\.")[0])+"_"+$sheet.Name+".csv"

			#Sheet����1�̏ꍇ���̂܂܂̖��̂�CSV�ۑ�
			if((($book.sheets|measure).count) -eq 1){$OutFile=(($_ -split "\.")[0])+".csv"}
	
			#Excel�𓯂��t�H���_�ɐV�KCSV�ۑ�
			$book.SaveAs((Split-Path(Convert-Path $_) -parent) + "\" + $OutFile,6)
		}
	}
	
	# �`�P�b�g���O�쐬 "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath"
	$FunctionName=$MyInvocation.MyCommand.Name
	if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,`"`"`"$InFile`"`"`",,,,,,,,,"}
	}
end {
	$excel.Quit()
	$excel=$null
	[System.GC]::Collect()
	popd
	}
}
