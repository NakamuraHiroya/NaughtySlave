# �Ɩ��̎w��������A�В��̎��Ɉ̂��Đ��r�鏑�I�ȃC���[�W�B

param($WorkDir=$BUSINESS_DIR,[Switch]$Auto,[Parameter(ValueFromPipeline)]$Operate=$(
<#-----------------------------------------------------------------------------
[1-1. �I�����X�g��`]
-----------------------------------------------------------------------------#>
"3-1-1. �i�r�Q�[�g���Ă��炤",
"3-3-1. DocManager�Ăяo��",
"3-3-2. TableManager�Ăяo��",
"3-3-3. ProjectManager�Ăяo��",
"3-3-4. ���������s"|

ogv -PassThru -Title "���ɉ������܂����H"),
<#-----------------------------------------------------------------------------
[1-2. �ϐ���`]
-----------------------------------------------------------------------------#>
 $NewWBSList=$(if(-not(Test-Path ./WBSList.csv)){Set-Content ./WBSList.csv "ProjectCode,WorkCode,TicketCode,StartDate,FinDate,isToday"};
 (ls */*/TicketList.csv).Fullname|%{$WBSList += ipcsv $_ -Encoding Default}),

<#-----------------------------------------------------------------------------
�y2. GetSrc�z
-----------------------------------------------------------------------------#>
<#-----------------------------------------------------------------------------
[2-1. �ǂݍ��݂������X�g�ǂݍ���]
-----------------------------------------------------------------------------#>
$ProjectList = $(ipcsv "C:\Users\hiroya\Business\ProjectList.csv" -Encoding Default)

<#-----------------------------------------------------------------------------
�y3. Custom�z
-----------------------------------------------------------------------------#>
)begin{pushd .;cd $WorkDir;"Ready" >> $LOG}process{switch($Operate){

<#---------------------------------------------------------------------------#>
"3-1-1. �i�r�Q�[�g���Ă��炤"{
<#---------------------------------------------------------------------------#>
"
�@DocManager:�F��ȂƂ��납��Ɩ��ɕK�v�ȃf�[�^��Table�쐬�ɕK�v�ȃf�[�^������ė��Ă���܂��B
�@TableManager:
�@
�@�Ƃ肠����DocManager���珇�ԂɌĂяo���Ă݂܂��傤�B

"
<#---------------------------------------------------------------------------#>
}"3-3-1. DocManager�Ăяo��"{
<#---------------------------------------------------------------------------#>
"DocManager"

<#---------------------------------------------------------------------------#>
}"3-3-2. TableManager�Ăяo��"{
<#---------------------------------------------------------------------------#>
"TableManager"

<#---------------------------------------------------------------------------#>
}"3-3-3. ProjectManager�Ăяo��"{
<#---------------------------------------------------------------------------#>
ProjectManager -WorkDir $BUSINESS_DIR

<#---------------------------------------------------------------------------#>
}"3-3-4. ���������s"{
<#---------------------------------------------------------------------------#>
"runspace��pool���ꂽobject���Ԃ�[���ē����C���[�W"

<#---------------------------------------------------------------------------#>
}default{
<#---------------------------------------------------------------------------#>
"�L�����Z���������ꂽ���A�I�����j���[�ɖ����I"

}}}end{popd}



