<#-----------------------------------------------------------------------------
[OverView]
-----------------------------------------------------------------------------#>
# PowershellではこっからKickされる。
<#-----------------------------------------------------------------------------
[1. Prepare]
-----------------------------------------------------------------------------#>
<#-------------------------------------
[1-1. アセンブリ読み込み]
-------------------------------------#>
Add-Type -AssemblyName System.Windows.Forms

<#-------------------------------------
[1-2. 定数定義]
-------------------------------------#>
# HOMEディレクトリ定義
Set-variable -name HOME_DIR -value C:\Users\hiroya\ -option constant;if (-not(Test-Path $HOME_DIR)) {"$HOME_DIR not exist"}
Set-variable -name LOG_DIR -value $HOME_DIR"Log\" -option constant	;if (-not(Test-Path $LOG_DIR)) {"$LOG_DIR not exist"}
Set-variable -name FUNC_DIR -value $HOME_DIR"Func\" -option constant	;if (-not(Test-Path $FUNC_DIR)) {"$FUNC_DIR not exist"}
Set-variable -name TABLE_DIR -value $HOME_DIR"Documents\My Data Sources\" -option constant;if(-not(Test-Path $TABLE_DIR)) {"$TABLE_DIR not exist"}
Set-variable -name BUSINESS_DIR -value $HOME_DIR"Business\" -option constant;if(-not(Test-Path $TABLE_DIR)) {"$BUSINESS_DIR not exist"}

# 日付系定数定義
Set-variable -name YYYYMM -value (Get-Date).ToString("yyyyMM") -option constant
Set-variable -name YYYYMMDD -value (Get-Date).ToString("yyyyMMdd") -option constant

# LOGファイル名定義
Set-variable -name LOG -value $LOG_DIR$yyyyMMdd"_log.txt" -option constant

<#-------------------------------------
[1-3. Alias定義]
-------------------------------------#>
ipcsv $FUNC_DIR/ExeList.csv -Encoding Default|%{Set-Alias $_.AliasCode $_.ExeCode}

<#-------------------------------------
[1-4. グローバル関数定義]
-------------------------------------#>
ls $FUNC_DIR*.ps1 -name|%{. $FUNC_DIR$_}

<#-----------------------------------------------------------------------------
[1. Prepare]
-----------------------------------------------------------------------------#>
<#-------------------------------------
[3-1. ビープ音消す]
-------------------------------------#>
# Stop-Service beep

<#-------------------------------------
[3-2. Displayアラート消す]
-------------------------------------#>
(New-Object -ComObject Excel.Application).DisplayAlerts=$false

<#-------------------------------------
[3-2. HOME移動]
-------------------------------------#>
cd $HOME_DIR
