function global:FileManager{
# File���W�߂āA�G�N�Z����CSV�Ɏ����ł��āA_localFileList�����B


param(
	$ProjectDir=$TABLE_DIR,
	$ProjectCode=$(
		if($CSV["_ProjectList.csv"].ProjectCode -contains (split-path ../ -leaf)){split-path ../ -leaf}
		else{$CSV["_ProjectList.csv"].ProjectCode|ogv -PassThru -Title "ProjectCode��I��ŉ������B"}
	),
	$WorkDir=(Join-Path $ProjectDir $ProjectCode),
	$WorkCode=$(
		if($CSV["_FileTypeCode.csv"].FileTypeCode -contains (split-path . -leaf)){split-path . -leaf}
		else{$CSV["_FileTypeCode.csv"].FileTypeCode|ogv -PassThru -Title "FileTypeCode��I��ŉ������B"}
	),
	$ThisDir=$(cd (Join-Path $WorkDir $WorkCode)),
	[Switch]$Init
)


<#---------------------------------------------------------------------------#>
if($init){#���������J�n
<#---------------------------------------------------------------------------#>
#file��get���Ă��鏈��������B

#����ɌÂ��t�@�C�����ړ�
#mkdir _Old

<#---------------------------------------------------------------------------#>
}#���������I��
<#---------------------------------------------------------------------------#>
$WorkCode
# InputList�쐬
Set-Content ($WorkCode + "List.csv") "InputCode,Memo" -Encoding Default

# Excel�t�@�C�����ꊇ��CSV�W�J�B
#ls -name *.xlsx,*.xls|%{&XLSFileToCSVFile $_}

Set-Content _LocalFileList.csv "LocalFileCode,Memo" -Encoding Default
ls -name -Exclude _*|out-file _LocalFileList.csv -Encoding Default -Append


start .
}