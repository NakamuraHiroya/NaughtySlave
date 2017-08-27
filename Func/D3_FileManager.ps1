function global:FileManager{
# Fileを集めて、エクセルをCSVに自動でして、_localFileListを作る。

param(
	$ProjectDir=$TABLE_DIR,
	$ProjectCode=$(
		if($CSV["_ProjectList.csv"].ProjectCode -contains (split-path ../ -leaf)){split-path ../ -leaf}
		else{$CSV["_ProjectList.csv"].ProjectCode|ogv -PassThru -Title "ProjectCodeを選んで下さい。"}
	),
	$WorkDir=(Join-Path $ProjectDir $ProjectCode),
	$WorkCode=$(
		if($CSV["_FileTypeCode.csv"].FileTypeCode -contains (split-path . -leaf)){split-path . -leaf}
		else{$CSV["_FileTypeCode.csv"].FileTypeCode|ogv -PassThru -Title "FileTypeCodeを選んで下さい。"}
	),
	$ThisDir=$(cd (Join-Path $WorkDir $WorkCode)),
	[Switch]$Init
)


<#---------------------------------------------------------------------------#>
if($init){#初期処理開始
<#---------------------------------------------------------------------------#>
#fileをgetしてくる処理をする。

#勝手に古いファイルを移動
#mkdir _Old

<#---------------------------------------------------------------------------#>
}#初期処理終了
<#---------------------------------------------------------------------------#>

# InputList作成
if(-not(Test-Path ($WorkCode+"List.csv"))){Set-Content ($WorkCode + "List.csv") "InputCode,Memo" -Encoding Default}

# Excelファイルを一括でCSV展開。
#ls -name *.xlsx,*.xls|%{&XLSFileToCSVFile $_}

Set-Content _LocalFileList.csv "LocalFileCode,Memo" -Encoding Default
ls -name -Exclude _*|out-file _LocalFileList.csv -Encoding Default -Append


start .
}
