function global:IOManager{

param(
	$SourceDir=$TABLE_DIR,
	$TableDir=$(
		if((split-path ../../ -leaf) -eq (split-path $SourceDir -leaf)){(convert-path .)}
		else{(Join-Path $Sourcedir (ls -dir -name $Sourcedir -Exclude _*|ogv -PassThru -Title "TableCodeを選んで！"))}
	),
	$WorkDir=$(
		if((split-path . -leaf) -eq "Input"){(Convert-Path .)}
		elseif((split-path . -leaf) -eq "Output"){(Convert-Path .)}
		else{(Join-path $TableDir ("Input","Output"|ogv -PassThru -Title "InputかOutputを選んで"))}
	)
)
$workDir

cd $workDir

start .

ls -name *.csv|%{$CSV+=@{$_=(OpenCSVFile $_)}}

# Autoのタイミングのやつ自動実行
$CSV."OutputList.csv"|?{$_.TimingCode -eq "Auto"}|%{&("./"+($_.TicketCode))}

# WatchTaskのタイミングのやつ別窓自動実行
$CSV."OutputList.csv"|?{$_.TimingCode -eq "WatchTask"}|%{&$_.TimingCode $_.TicketCode $_.Time}

"dekiteru?"

}