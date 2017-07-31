function global:TableManager{

param(
	$SourceDir=$TABLE_DIR,
	$WorkDir=$(
		if((split-path ../ -leaf) -eq (split-path $table_dir -leaf)){
			(convert-path .)
		}else{
			(Join-Path $Table_dir (ls -dir -name $Table_Dir -Exclude _*|ogv -PassThru -Title "TableCode��I��ŁI"))
		}
	)
	
)

cd $workDir

$TableCode=(split-path . -leaf)
$tableCode


if(-not(test-Path Input)){mkdir Input;Set-Content InputList.csv "TableCode,WorkCode,TicketCode"}
if(-not(test-Path Output)){mkdir Output;Set-Content OutputList.csv "TableCode,WorkCode,TicketCode"}

#WBS�쐬
$input=OpenCSVFile ./Input/InputList.csv
$output=OpenCSVFile ./Output/OutputList.csv

#(OpenCSVFile ./Input/InputList.csv)+(OpenCSVFile ./Output/OutputList.csv)

}