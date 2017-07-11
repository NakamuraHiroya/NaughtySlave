function global:TicketManager{
<#-----------------------------------------------------------------------------
�yOverView�z
-----------------------------------------------------------------------------#>

<#-----------------------------------------------------------------------------
�yPrepare�z
-----------------------------------------------------------------------------#>
param($WorkDir=(Join-Path (Convert-Path .) \),[Switch]$Auto,[Parameter(ValueFromPipeline)]$Operate=$(
<#-----------------------------------------------------------------------------
[1-1. �I�����X�g��`]
-----------------------------------------------------------------------------#>
 "3-1-1. �i�r�Q�[�g���Ă��炤",
 "3-2-1. �K�v��Src��Get����",
 "3-3-1. TicketCode��o�^����",
 "3-3-2. TicketList�������e�i���X����",
 "3-3-3. Ticket�Ɏ��|����"|

ogv -PassThru -Title (($WorkDir) + "TicketManager ���ɉ������܂����H")),
<#-----------------------------------------------------------------------------
[1-2. �ϐ���`]
-----------------------------------------------------------------------------#>
 $ProjectCode=$(cd $WorkDir;if((Split-Path ../../ -Leaf) -eq "Business"){Split-Path ../ -Leaf}else{"TicketDir�Ŏ��s���ĉ�����"}),
 $WorkCode=$(if((Split-Path ../../ -Leaf) -eq "Business"){Split-Path . -Leaf}else{"TicketDir�Ŏ��s���ĉ�����"}),
 $NewTicketList=$(if(-not(Test-Path ./TicketList.csv)){Set-Content ./TicketList.csv "TicketCode,WorkCode,ProjectCode,StartDate,FinDate,isToday"}),
 
<#-----------------------------------------------------------------------------
�yGetSrc�z
-----------------------------------------------------------------------------#>
<#-----------------------------------------------------------------------------
[2-1. �ǂݍ��݂���List�ǂݍ���]
-----------------------------------------------------------------------------#>
 $TicketList=$(ipcsv ./TicketList.csv -Encoding Default),
 $TicketTypeCode=$(ipcsv $FUNC_DIR\FunctionList.csv -Encoding Default)
 
)begin{pushd .;cd $WorkDir;(date).ToString()+" :"+$ProjectCode+">"+$WorkCode+">"+(Split-Path -Leaf $PSCommandPath)+" Ready." >> $Log}process{switch($Operate){
<#-----------------------------------------------------------------------------
�y3. Custom�z
-----------------------------------------------------------------------------#>
<#---------------------------------------------------------------------------#>
"3-1-1. �i�r�Q�[�g���Ă��炤"{
<#---------------------------------------------------------------------------#>
$TicketList|ft -autosize
"Project :"+$ProjectCode
"Work :"+$WorkCode
$WorkDir

<#---------------------------------------------------------------------------#>
}"3-2-1. �K�v��Src��Get����"{
<#---------------------------------------------------------------------------#>

<#---------------------------------------------------------------------------#>
}"3-3-1. TicketCode��o�^����"{
<#---------------------------------------------------------------------------#>
$TicketCode = (Read-Host $WorkCode "��B������ׂɕK�v��TicketCode���L�����ĉ������B")

#TicketCode�̃t�@�C���쐬
ni ($TicketCode+".ps1") -Type File -Value ($TicketTypeCode|ogv -PassThru -Title (($WorkDir)+"TicketManager �ǂ�Ȃ��Ƃ����邩�I�����ĉ������B ")).FunctionCode

Add-Content ./TicketList.csv($TicketCode+","+$WorkCode +","+ $ProjectCode)

<#---------------------------------------------------------------------------#>
}"3-3-2. TicketList�����e�i���X"{
<#---------------------------------------------------------------------------#>
$excel=New-Object -ComObject Excel.Application;$excel.Visible=$true;$excel.DisplayAlerts=$false;$excel.Workbooks.Open((Convert-path ./TicketList.csv))

<#---------------------------------------------------------------------------#>
}"3-3-3. Ticket�Ɏ��|����"{
<#---------------------------------------------------------------------------#>
Invoke-Expression ("./"+(ls *.ps1 -name -Exclude TicketManager.ps1|ogv -PassThru -Title "Project>Work>TicketManager ���|����Ticket��I�����ĉ������B"))

<#---------------------------------------------------------------------------#>
}default{
<#---------------------------------------------------------------------------#>
"�L�����Z���������ꂽ���A�I�����j���[�ɖ����I"
}}
if((Read-Host "�܂�������Hyes/no") -eq "yes"){TicketManager -WorkDir (Join-Path (Convert-Path .) \)}else{cd ../}
}end{(date).ToString()+" :"+$ProjectCode+">"+$WorkCode+">"+(Split-Path -Leaf $PSCommandPath)+" Finished." >> $Log;popd}}
