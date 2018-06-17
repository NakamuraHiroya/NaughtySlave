function global:SumIfData{

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "sumif�������t�@�C����I�����ĉ������B"),
	$Key=$((cat $InFile -First 1) -split ","|ogv -PassThru -Title "�W�v�̃L�[��I�����ĉ������B"),
	$Sum=$((cat $InFile -First 1) -split ","|ogv -PassThru -Title "�W�v�Ώۂ�I�����ĉ������B"),
	$OutFile=$(($InFile -split "\.")[0]+"_Sumif.csv")
)

$result=ipcsv $infile -encoding default|group $Key|select name,@{Name=[string]$Sum;Expression={($_.group|measure -sum $Sum).sum}}

$result|export-csv $outfile -encoding default -notypeinformation

}

