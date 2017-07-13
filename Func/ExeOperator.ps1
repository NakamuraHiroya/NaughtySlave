function global:ExeOperator{
OpenCSVFile $Func_Dir/ExeList.csv|ogv -PassThru -Title "‚Ç‚ê‚ğ‹N“®‚µ‚Ü‚·‚©H"|%{Invoke-Expression $_.ExeCode}
}