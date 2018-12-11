function global:Define-RowData{
# DefineSheetのOrder列に従って列の順番を定義する。列をBlankにすることで列そのものを削除する

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "ファイルを選択して下さい。"),
	$WorkDir=$((pwd).path),
	$DefineSheet=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$OutFile=$($InFile),
	$Ticket
)
begin{
	pushd $WorkDir
	}
process{
	$PropertyInfo_OrderList=ipcsv $DefineSheet -encoding default|?{$_.Order}|sort{$_.Order -as [int]}|%{$_.Property}
	
	(ipcsv $InFile -encoding default)|select $PropertyInfo_OrderList|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default

	# チケットログ作成
	$FunctionName=$MyInvocation.MyCommand.Name
	if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,$SrcDir,$SrcPath,$DistDir,$DistPath,$DefineSheet"}
	
	}
end{
	popd
	}
}
