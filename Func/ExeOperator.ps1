function global:ExeOperator{
OpenCSVFile $Func_Dir/ExeList.csv|ogv -PassThru -Title "どれを起動しますか？"|%{Invoke-Expression $_.ExeCode}
}