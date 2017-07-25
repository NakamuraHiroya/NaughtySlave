function global:TableManager{

param($WorkDir=$TABLE_DIR)

# 一番最初の場合、ディレクトリ作るところから。作ってからCodeManager呼び出し

$NewSourceList=$(if(-not(Test-Path $TABLE_DIR/_Code)){mkdir $TABLE_DIR/_Code})



}