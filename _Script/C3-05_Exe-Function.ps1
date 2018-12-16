function global:Exe-Function{
# DefineSheetのFunction列に対して関数を実行する。

param(
	$InFile=$(ls -name *.csv -Exclude Define*,_*|ogv -passThru -Title "ファイルを指定して下さい。"),
	$WorkDir=$((pwd).path),
	$DefineSheet=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$OutFile=$($InFile),
	$Ticket
)
begin{
	pushd $WorkDir
	}
process{
	$Property_CustomList=ipcsv $DefineSheet -encoding default|?{$_.Function}
	$Property_CustomList|%{
		$Property=$_.Property
		$Function=$_.Function
	
		$Data=ipcsv $InFile -Encoding Default
		$Data|%{$_.$Property=(Invoke-Expression $Function)}
		$Data|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default
		}
	# チケットログ作成
	$FunctionName=$MyInvocation.MyCommand.Name
	if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,$SrcDir,$SrcPath,$DistDir,$DistPath,$DefineSheet"}
	}
end{
	popd
	}
}