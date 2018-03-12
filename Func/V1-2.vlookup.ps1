function global:vlookup($Key,$Master,$MasterKey,$MasterValue){

# $datalist.'FileType_Code.csv'|?{$_.FileTypeCode -eq "_WBS"}|%{$_.SearchWords}

$Datalist.$Master|?{$_.$MasterKey -eq $Key}|%{$_.$MasterValue}

}