function global:Convert-XLSFileToCSVFiles{

param(
	$InFile=$(ls -name *.xls*|ogv -PassThru -Title "入力するファイルを指定して下さい。"),
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
	# ワイルドカードを許可
	if($InFile -eq "*"){$InFile=ls -name *.xls* -Exclude _*}else{$InFile=$InFile -split " "}

	$InFile|%{
		#エクセルを開く
		$book=$excel.Workbooks.Open((Convert-path $_))

		foreach($sheet in $book.sheets){
			$sheet.Activate()
			$OutFile=(($_ -split "\.")[0])+"_"+$sheet.Name+".csv"

			#Sheet数が1の場合そのままの名称でCSV保存
			if((($book.sheets|measure).count) -eq 1){$OutFile=(($_ -split "\.")[0])+".csv"}
	
			#Excelを同じフォルダに新規CSV保存
			$book.SaveAs((Split-Path(Convert-Path $_) -parent) + "\" + $OutFile,6)
		}
	}
	
	# チケットログ作成 "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath"
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
