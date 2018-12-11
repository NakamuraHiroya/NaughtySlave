function global:Merge-File{
# 2つ以上の、「列名」が同じCSVファイルのデータをマージする。

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "mergeするファイルを選択して下さい。"),
	$WorkDir=$((pwd).path),
	$OutFile=$(($InFile -split "\.")[0]+"_Merge.csv"),
	$Ticket
)
begin{
	pushd $WorkDir
	}
process {
	# ワイルドカードを許可
	if($InFile.Contains("*")){
		ls -name $InFile -exclude _*|%{
			$data+=ipcsv $_ -Encoding default
		}
	}else{
		$InFile -split " "|%{
			$data+=ipcsv $_ -Encoding default
		}
	}
	$data|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default

	# チケットログ作成
	# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
	$FunctionName=$MyInvocation.MyCommand.Name
	if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,`"`"`"$InFile`"`"`",$OutFile,$Row,,$Value,,,$DistDir,$DistPath"}
	}
end {
	popd
	}
}
