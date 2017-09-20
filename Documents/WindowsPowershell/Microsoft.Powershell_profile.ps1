#アセンブリ読み込み
Add-Type -AssemblyName System.Windows.Forms

#定数定義
Set-variable -name HOME_DIR -value $HOME"\Documents\" -option constant;if (-not($HOME_DIR)) {"$HOME_DIR not exist"}
Set-variable -name NS_DIR -value $HOME_DIR"NaughtySlave\" -option constant	;if (-not($NS_DIR)) {"$NS_DIR not exist"}
Set-variable -name TABLE_DIR -value $HOME_DIR"My Data Sources\" -option constant;if(-not($TABLE_DIR)) {"$TABLE_DIR not exist"}

# 日付系定数定義
Set-variable -name YYYYMM -value (Get-Date).ToString("yyyyMM") -option constant
Set-variable -name YYYYMMDD -value (Get-Date).ToString("yyyyMMdd") -option constant

#関数読み込み
ls $NS_DIR*.ps1 -name|%{. $NS_DIR$_}

#CSVファイル読み込み
ls -name $NS_DIR*.csv|%{$Data+=@{$_=(OpenCSVFile (Join-Path $NS_DIR $_))}}
ls -name $HOME_DIR*.csv|%{$Data+=@{$_=(OpenCSVFile (Join-Path $HOME_DIR $_))}}
ls -name $TABLE_DIR*.csv|%{$Data+=@{$_=(OpenCSVFile (Join-Path $TABLE_DIR $_))}}

#Alias定義
$Data["ExeList.csv"]|%{if($_.AliasCode){Set-Alias $_.AliasCode $_.ExeCode}}

#Persona定義
$JPCode=$data["Persona.csv"].JPCode
$NPCode=$data["Persona.csv"].NPCode

#ビープ音消す
# Stop-Service beep

#Displayアラート消す
(New-Object -ComObject Excel.Application).DisplayAlerts=$false

#HOME移動
cd $HOME_DIR
