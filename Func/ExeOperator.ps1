function global:ExeOperator{
OpenCSVFile $Func_Dir/ExeList.csv|ogv -PassThru -Title "�ǂ���N�����܂����H"|%{Invoke-Expression $_.ExeCode}
}