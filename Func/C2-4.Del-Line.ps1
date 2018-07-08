function global:Del-Line{

# 指定のファイルから、列を選択させて、合致するデータを削除したい。
param(
	$Infile=$(ls -name *.csv|ogv -passthru -title "削除対象とするCSVファイルを選択して下さい。"),
	$OutFile=$(($InFile -split "\.")[0]+"_Deleted.csv"),
	$Row=$((cat $InFile -First 1) -split ","|ogv -PassThru -Title "削除対象とするキー列を選択して下さい。"),
	$Line=$(ipcsv $Infile -encoding default|select $row|ogv -PassThru -Title "削除対象条件を選択して下さい。"),
	$Ticket
)

$i=1
$delline=@()
ipcsv $infile -encoding default|select $row|%{if($line.$row -eq $_.$row){$delline+=$i};$i++}

$delfile=cat $infile
$delline|%{$delLog=$delfile[$_];$delfile[$_]=$null}
$delfile|out-file "del.csv" -encoding default

$delLog|out-file (($InFile -split "\.")[0]+"_delLog.csv") -encoding default

if($Ticket){CreateTicketFile -data "$Ticket,Del-Line,$Infile,$OutFile,$Data,$Row,$Line"}

}



