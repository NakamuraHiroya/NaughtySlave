function global:ChangeWorkDir{

#�\�ߗp�ӂ���WorkDir�Ɉړ�����

param(
	$Data=$($data.'WorkList.csv'|ogv -passThru -Title "Work��I�����ĉ�����")
)
cd $data.WorkDir

# �`�P�b�g�쐬���Ȃ�
}

