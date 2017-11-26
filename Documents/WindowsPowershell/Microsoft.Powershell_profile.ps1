#�A�Z���u���ǂݍ���
Add-Type -AssemblyName System.Windows.Forms

#�萔��`
Set-variable -name HOME_DIR -value $HOME"\Documents\" -option constant;if (-not($HOME_DIR)) {"$HOME_DIR not exist"}
Set-variable -name NS_DIR -value $HOME_DIR"NaughtySlave\" -option constant	;if (-not($NS_DIR)) {"$NS_DIR not exist"}
Set-variable -name TABLE_DIR -value $HOME_DIR"My Data Sources\" -option constant;if(-not($TABLE_DIR)) {"$TABLE_DIR not exist"}

# ���t�n�萔��`
Set-variable -name YYYYMM -value (Get-Date).ToString("yyyyMM") -option constant
Set-variable -name YYYYMMDD -value (Get-Date).ToString("yyyyMMdd") -option constant

#�֐��ǂݍ���
ls $NS_DIR*.ps1 -name|%{. $NS_DIR$_}

#DataSet
ls -name $NS_DIR*.csv|%{$Data+=@{$_=(OpenCSVFile (Join-Path $NS_DIR $_))}}
$data.'WBS.csv'|?{$_.SetData}|%{pushd $_.WorkDir;ls -name *.csv|%{$Data+=@{$_=(OpenCSVFile $_)}};popd}

#Alias��`
$Data["AppList.csv"]|%{if($_.AliasCode){Set-Alias $_.AliasCode $_.ExeCode}}

#Persona��`
$JPCode=$data["Persona.csv"].JPCode
$NPCode=$data["Persona.csv"].NPCode

#�r�[�v������
# Stop-Service beep

#Display�A���[�g����
(New-Object -ComObject Excel.Application).DisplayAlerts=$false

#HOME�ړ�
cd $HOME_DIR
