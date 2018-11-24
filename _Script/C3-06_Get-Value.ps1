function global:Get-Value{
# DefineSheetで定義された外部マスタより指定Keyの指定値を取得する関数。

param(
	$InFile=$(ls -name *.csv -Exclude _*|ogv -passThru -Title "ファイルを指定して下さい。"),
	$OutFile=$(($InFile -split "\.")[0]+"_Foreign.csv"),
	$DefineSheet=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$Ticket
)
$Data =ipcsv $InFile -encoding default

(ipcsv $DefineSheet -Encoding Default|?{$_.ForeignMaster})|%{
	if(-not($_.Property)){$Property="Propertyが設定されていません"}else{$Property=$_.Property}
	if(-not($_.ForeignMaster)){$ForeignMaster="外部マスタが設定されていません"}else{$ForeignMaster=$datalist.($_.ForeignMaster)}
	if(-not($_.ForeignKey)){$ForeignKey="外部キーが設定されていません"}else{$ForeignKey=$_.ForeignKey}
	if(-not($_.ForeignValue)){$ForeignValue="取得したい列名が設定されていません"}else{$ForeignValue=$_.ForeignValue}
		
	$data|%{
		$Src=$_.$Property
		$ForeignMaster|?{$_.($ForeignKey) -eq $Src}|%{$Src=$_.($ForeignValue)}
		$_.$Property=$Src
	}
}

$data|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default

#"Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath,DefineSheet"
$FunctionName=$MyInvocation.MyCommand.Name
if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,,$InFile,$OutFile,,,,,,,,$DefineSheet"}

}