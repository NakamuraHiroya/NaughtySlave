function global:Open-App{

$datalist["AppList.csv"]|ogv -PassThru -Title "�ǂ���N�����܂����H"|%{Invoke-Expression $_.ExeCode}

}