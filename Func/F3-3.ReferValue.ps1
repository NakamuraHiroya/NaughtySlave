function global:ReferValue($Master,$Key,$Value){

# $Key�́A�����ɓ����Ă������֐��̒��Ŏ����I�ɓ���Ă���A$Master��$Value������ȁA����Ă��邩�B
# $datalist.'FileType_Code.csv'|?{$_.FileTypeCode -eq "_WBS"}|%{$_.SearchWords}

$Datalist.$Master|?{$_.Key -eq $Key}|%{$_.$Value}

}