function global:CodeManager{

param(
	$NewWorkDir=$($WorkDir=$TABLE_DIR+"_Code";pushd $WorkDir),
	[Parameter(ValueFromPipeline)]$Operate=$(
		"Code����List���쐬����",
		"AppCode���쐬����",
		"WEBServiceCode���쐬����",
		"Debug"|ogv -PassThru -Title (($WorkDir) + "CodeManager ���ɉ������܂����H")),

#CSV�ǂݍ���
#ls -name *.csv|%{$CSVList+=@{$_=(OpenCSVFile $_)}
$NewCSVList=$(ls -name *.csv|%{$CSVList+=@{$_=(OpenCSVFile $_)}})

#$ProjectList=$(ipcsv ./ProjectList.csv -Encoding Default)

)switch($Operate){
<#---------------------------------------------------------------------------#>
"Code����PetternList���쐬����"{
<#---------------------------------------------------------------------------#>


$CSV_1=OpenCSVFile ($CSVList.Keys|ogv -PassThru -Title "1�ڂɊJ��CSV�t�@�C������͂��ĉ������B")
$Row_1=$CSV_1|get-member|?{$_.MemberType -eq "NoteProperty"}|%{$_.name}|ogv -PassThru -Title "CSV�̗񖼂�I�����ĉ������B"

$CSV_2=OpenCSVFile ($CSVList.Keys|ogv -PassThru -Title "2�ڂɊJ��CSV�t�@�C������͂��ĉ������B")
$Row_2=$CSV_2|get-member|?{$_.MemberType -eq "NoteProperty"}|%{$_.name}|ogv -PassThru -Title "CSV�̗񖼂�I�����ĉ������B"

$CSV_1.($Row_1)|%{$Root=$_;$CSV_2.($Row_2)|%{Add-Content List.csv ($Root+","+$_);Write-Progress "Now Writing" ($Root+$_)}}

<#---------------------------------------------------------------------------#>
}"Debug"{
<#---------------------------------------------------------------------------#>

$WorkDir
$CSVList

<#---------------------------------------------------------------------------#>
}default{"�L�����Z���������ꂽ���A�I�����j���[�ɖ����I"}
<#---------------------------------------------------------------------------#>


}}