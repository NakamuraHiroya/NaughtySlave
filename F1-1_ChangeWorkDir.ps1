function global:ChangeWorkDir{

#予め用意したWorkDirに移動する

param(
	$Data=$($data.'WorkList.csv'|ogv -passThru -Title "Workを選択して下さい")
)
cd $data.WorkDir

# チケット作成しない
}

