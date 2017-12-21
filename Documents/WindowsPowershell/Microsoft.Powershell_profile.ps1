#アセンブリ読み込み
Add-Type -AssemblyName System.Windows.Forms

# 日付系定数定義
Set-variable -name YYYYMM -value (Get-Date).ToString("yyyyMM") -option constant
Set-variable -name YYYYMMDD -value (Get-Date).ToString("yyyyMMdd") -option constant

#関数読み込み
$NS_DIR="C:\Users\hiroya\Documents\NaughtySlave\"
ls $NS_DIR*.ps1 -name|%{. $NS_DIR$_}

#Databaselist作成
$TABLE_DIR="C:\Users\hiroya\Documents\My Data Sources\"
CreateDirInfo -WorkDir $TABLE_DIR -OutFile "DataBaseList.csv"
cd $TABLE_DIR
$DataBaseList=ipcsv DataBaseList.csv -Encoding Default
$DataBaseList|%{createdirinfo -workdir $_.workdir -OutFile "_TableList.csv"}
ls -dir -name|%{$DataBaseList+=(ipcsv (join-path $_ _TableList.csv) -Encoding Default)}
$DataBaseList|Export-Csv DataBaseList.csv -Encoding Default -NoTypeInformation
ls -name *.csv -Exclude _*|%{$DataList+=@{$_=(ipcsv $_ -Encoding Default)}}

#DataSet
ls -name $NS_DIR*.csv -Exclude _*|%{$DataList+=@{$_=(ipcsv (Join-Path $NS_DIR $_) -Encoding Default)}}
#$DataList.'WBS.csv'|?{$_.SetData}|%{pushd $_.WorkDir;ls -name *.csv -Exclude _*|%{$DataList+=@{$_=(ipcsv $_ -Encoding Default)}};popd}
$DataList.'DatabaseList.csv'|%{pushd $_.WorkDir;ls -name *.csv -Exclude _*|%{$DataList+=@{$_=(ipcsv $_ -Encoding Default)}};popd}

#Alias定義
$DataList.'AppList.csv'|%{if($_.AliasCode){Set-Alias $_.AliasCode $_.ExeCode}}

#ビープ音消す
# Stop-Service beep

#Displayアラート消す
(New-Object -ComObject Excel.Application).DisplayAlerts=$false

