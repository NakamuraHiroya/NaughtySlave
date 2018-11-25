function global:Open-App{

$datalist["AppList.csv"]|ogv -PassThru -Title "‚Ç‚ê‚ğ‹N“®‚µ‚Ü‚·‚©H"|%{Invoke-Expression $_.ExeCode}

}