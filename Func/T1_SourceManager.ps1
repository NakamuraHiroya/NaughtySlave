function global:SourceManager{

param($WorkDir=$TABLE_DIR)

# ��ԍŏ��̏ꍇ�A�f�B���N�g�����Ƃ��납��B����Ă���CodeManager�Ăяo��
cd $WorkDir

$NewSourceList=$(
# �ŏ��̏���
if(-not(Test-Path $WorkDir/_Code)){mkdir $WorkDir/_Code}

# ���Ȃ������ɃA�N�Z�X�o����l���ꗗ�������ĉ������B # waitprocess�ő҂�
./NaturalPersonCode.csv

# ���Ȃ������ɃA�N�Z�X�o�����Ж��������ĉ������B
./JuridicalPersonCode.csv

# ���Ȃ������ɃA�N�Z�X�o����WEBService�������ĉ������B
./WebServiceCode.csv

# ���Ȃ������ɃA�N�Z�X�o����A�v���P�[�V�����������ĉ������B

)
# listmanager�Ăяo���āATableList����肽���B



}