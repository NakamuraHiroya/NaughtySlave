function global:SumIfData{

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "sumifしたいファイルを選択して下さい。"),
	$Key=$((cat $InFile -First 1) -split ","|ogv -PassThru -Title "集計のキーを選択して下さい。"),
	$Sum=$((cat $InFile -First 1) -split ","|ogv -PassThru -Title "集計対象を選択して下さい。"),
	$OutFile=$(($InFile -split "\.")[0]+"_Sumif.csv")
)

$result=ipcsv $infile -encoding default|group $Key|select name,@{Name=[string]$Sum;Expression={($_.group|measure -sum $Sum).sum}}

$result|export-csv $outfile -encoding default -notypeinformation

}

