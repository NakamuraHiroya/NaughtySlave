function global:TableManager{

param($WorkDir=$TABLE_DIR)

# ��ԍŏ��̏ꍇ�A�f�B���N�g�����Ƃ��납��B����Ă���CodeManager�Ăяo��

$NewSourceList=$(if(-not(Test-Path $TABLE_DIR/_Code)){mkdir $TABLE_DIR/_Code})



}