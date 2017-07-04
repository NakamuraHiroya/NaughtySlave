function global:ProjectManager{
<#-----------------------------------------------------------------------------
�yOverView�z
-----------------------------------------------------------------------------#>
# ProjectManager
<#-----------------------------------------------------------------------------
�yPrepare�z
-----------------------------------------------------------------------------#>
param($WorkDir=$BUSINESS_DIR,[Switch]$Auto,[Parameter(ValueFromPipeline)]$Operate=$(
<#-----------------------------------------------------------------------------
[1-1. �I�����X�g��`]
-----------------------------------------------------------------------------#>
 "3-1-1. �i�r�Q�[�g���Ă��炤",
 "3-3-1. ProjectCode��o�^����",
 "3-3-2. ProjectList�������e�i���X����",
 "3-3-3. Project�Ɏ��|����"|

ogv -PassThru -Title (($WorkDir) + "ProjectManager ���ɉ������܂����H")),
<#-----------------------------------------------------------------------------
[1-2. �ϐ���`]
-----------------------------------------------------------------------------#>
 $NewProjectList=$(if(-not(Test-Path $BUSINESS_DIR/ProjectList.csv)){Set-Content $BUSINESS_DIR/ProjectList.csv "ProjectCode,ProjectNo,ProjectStart,ProjectEnd,isOpen"}),
 
<#-----------------------------------------------------------------------------
�yGetSrc�z
-----------------------------------------------------------------------------#>
<#-----------------------------------------------------------------------------
[2-1. �ǂݍ��݂���List�ǂݍ���]
-----------------------------------------------------------------------------#>
 $ProjectList=$(ipcsv ./ProjectList.csv -Encoding Default)
 
)begin{pushd .;cd $WorkDir;(date).ToString()+" :"+$ProjectCode+">"+$WorkCode+">"+(Split-Path -Leaf $PSCommandPath)+" Ready." >> $Log}process{switch($Operate){
<#-----------------------------------------------------------------------------
�y3. Custom�z
-----------------------------------------------------------------------------#>
<#---------------------------------------------------------------------------#>
"3-1-1. �i�r�Q�[�g���Ă��炤"{
<#---------------------------------------------------------------------------#>
"Project�́A�H�����ɕ�����̂��ǂ��ł��I"

<#---------------------------------------------------------------------------#>
}"3-3-1. ProjectCode��o�^����"{
<#---------------------------------------------------------------------------#>
$ProjectCode = (Read-Host "�V�����v���W�F�N�g���쐬���܂��BProjectCode����͂��ĉ������B")

mkdir $ProjectCode

Add-Content ./ProjectList.csv $ProjectCode

<#---------------------------------------------------------------------------#>
}"3-3-2. ProjectList�������e�i���X����"{
<#---------------------------------------------------------------------------#>
#$excel=New-Object -ComObject Excel.Application;$excel.Visible=$true;$excel.DisplayAlerts=$false;$excel.Workbooks.Open((Convert-path ./ProjectList.csv))|Out-Null
(New-Object -ComObject Excel.Application)|%{$_.Visible=$true;$_.DisplayAlerts=$false;$_.Workbooks.Open((Convert-Path ./ProjectList.csv))}|Out-Null


<#---------------------------------------------------------------------------#>
}"3-3-3. Project�Ɏ��|����"{
<#---------------------------------------------------------------------------#>
WorkManager -WorkDir (Join-Path (Convert-Path (ls -dir -name|ogv -PassThru -Title (($WorkDir) + " ���|����Project��I�����ĉ������B"))) \)

<#---------------------------------------------------------------------------#>
}default{
<#---------------------------------------------------------------------------#>
"�L�����Z���������ꂽ���A�I�����j���[�ɖ����I"
}}
if((Read-Host "ProjectManager �܂�������Hyes/no") -eq "yes"){ProjectManager -WorkDir (Join-Path (Convert-Path .) \)}else{cd ../}
}end{(date).ToString() + " :"+$ProjectCode+">"+$WorkCode+">"+(Split-Path -Leaf $PSCommandPath) + " Finished." >> $Log;popd}}


