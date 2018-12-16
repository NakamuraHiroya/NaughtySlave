function global:Split-RowGroupData{

param(
	$InFile=$(ls -name *.csv -Exclude _*|ogv -PassThru -Title "入力するファイルを指定して下さい。"),
	$WorkDir=$((pwd).path),
	$Data=$(ipcsv $Infile -Encoding Default),
	$Row=$((cat $InFile)[0] -split ","|ogv -PassThru -Title "分割対象の列名を選択して下さい。"),
	$OutFile=$(($InFile -split "\.")[0]),
	$Ticket
)
begin{
	pushd $WorkDir
	}
process{
	# 【】や[]や/を変換しないとダメ！
	$data|group $Row|%{$name=$_.Name;$_.Group|Export-CSV ($OutFile+"_"+$name+".csv") -Encoding Default -NoTypeInformation}
	
	# ダブルクオーテーションTrim
	$data|group $Row|%{Trim-File ($OutFile+"_"+$_.Name+".csv")}

	# チケットログ作成 
	$FunctionName=$MyInvocation.MyCommand.Name
	if($Ticket){Create-Ticket -data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,$SrcDir,$SrcPath,$DistDir,$DistPath,$DefineSheet"}
	}
end{
	popd
	}
}