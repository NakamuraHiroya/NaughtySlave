function global:Open-App{

$datalist["AppList.csv"]|ogv -PassThru -Title "どれを起動しますか？"|%{Invoke-Expression $_.ExeCode}

}