<#-------------------------------------
[�A�Z���u���ǂݍ���]
-------------------------------------#>
Add-Type -AssemblyName System.Windows.Forms

<#-------------------------------------
[�S�Ă̊֐��ǂݍ���]
-------------------------------------#>
cd ($NS_DIR="C:\Users\hiroya\Documents\NaughtySlave\")
ls $NS_DIR*.ps1 -name|%{. $NS_DIR$_}

<#-----------------------------------------------------------------------------
�yWorkDir�Ŏ����������s�z
-----------------------------------------------------------------------------#>
cd ($WBS_DIR="C:\Users\hiroya\Documents\WBS")
Exe-Ticket

<#-------------------------------------
[���t�n�ϐ���`]
-------------------------------------#>
Set-variable -name YYYYMM -value (Get-Date).ToString("yyyyMM") -option constant
Set-variable -name YYYYMMDD -value (Get-Date).ToString("yyyyMMdd") -option constant

<#-------------------------------------
[Alias��`]
<#-----------------------------------#>
$DataList.'AppList.csv'|%{if($_.AliasCode){Set-Alias $_.AliasCode $_.ExeCode}}

<#-------------------------------------
[Excel��Display�A���[�g����]
-------------------------------------#>
(New-Object -ComObject Excel.Application).DisplayAlerts=$false

