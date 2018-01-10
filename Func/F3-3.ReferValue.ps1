function global:ReferValue($Master,$Key,$Value){

# $Keyは、そこに入っているやつを関数の中で自動的に入れてくれ、$Masterと$Valueもそやな、取ってくるか。
# $datalist.'FileType_Code.csv'|?{$_.FileTypeCode -eq "_WBS"}|%{$_.SearchWords}

$Datalist.$Master|?{$_.Key -eq $Key}|%{$_.$Value}

}