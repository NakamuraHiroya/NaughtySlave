function global:Create-PivotTable{

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "PivotTableを作成したいファイルを選択して下さい。"),
	$WorkDir=$((pwd).path),
	$Row=$((cat $InFile -First 1) -split ","|ogv -PassThru -Title "集計のキー列を選択して下さい。"),
	$Line=$((cat $InFile -First 1) -split ","|ogv -PassThru -Title "集計対象項目を選択して下さい。※Ctrl選択で複数行可"),
	$OutFile=$(($InFile -split "\.")[0]+"_PivotTable.csv"),
	$Ticket
)
begin{
	pushd $WorkDir
	}
process{
	(ipcsv $infile -encoding default|group $Row|select name,@{Name=[string]$Line;Expression={($_.group|measure -sum $Line).sum}})|ConvertTo-Csv -NoTypeInformation|%{$_.replace('"','')}|%{$_.replace(' ',',')}|Out-File $OutFile -Encoding Default

	# チケットログ作成
	$FunctionName=$MyInvocation.MyCommand.Name
	if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,$SrcDir,$SrcPath,$DistDir,$DistPath,$DefineSheet"}
	}
end{
	popd
	}
}
