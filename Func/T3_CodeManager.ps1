function global:CodeManager{

param(
	$NewWorkDir=$($WorkDir=$TABLE_DIR+"_Code";pushd $WorkDir),
	[Parameter(ValueFromPipeline)]$Operate=$(
		"CodeからListを作成する",
		"AppCodeを作成する",
		"WEBServiceCodeを作成する",
		"Debug"|ogv -PassThru -Title (($WorkDir) + "CodeManager 次に何をしますか？")),

#CSV読み込み
#ls -name *.csv|%{$CSVList+=@{$_=(OpenCSVFile $_)}
$NewCSVList=$(ls -name *.csv|%{$CSVList+=@{$_=(OpenCSVFile $_)}})

#$ProjectList=$(ipcsv ./ProjectList.csv -Encoding Default)

)switch($Operate){
<#---------------------------------------------------------------------------#>
"CodeからPetternListを作成する"{
<#---------------------------------------------------------------------------#>


$CSV_1=OpenCSVFile ($CSVList.Keys|ogv -PassThru -Title "1つ目に開くCSVファイルを入力して下さい。")
$Row_1=$CSV_1|get-member|?{$_.MemberType -eq "NoteProperty"}|%{$_.name}|ogv -PassThru -Title "CSVの列名を選択して下さい。"

$CSV_2=OpenCSVFile ($CSVList.Keys|ogv -PassThru -Title "2つ目に開くCSVファイルを入力して下さい。")
$Row_2=$CSV_2|get-member|?{$_.MemberType -eq "NoteProperty"}|%{$_.name}|ogv -PassThru -Title "CSVの列名を選択して下さい。"

$CSV_1.($Row_1)|%{$Root=$_;$CSV_2.($Row_2)|%{Add-Content List.csv ($Root+","+$_);Write-Progress "Now Writing" ($Root+$_)}}

<#---------------------------------------------------------------------------#>
}"Debug"{
<#---------------------------------------------------------------------------#>

$WorkDir
$CSVList

<#---------------------------------------------------------------------------#>
}default{"キャンセルが押されたか、選択メニューに無い！"}
<#---------------------------------------------------------------------------#>


}}