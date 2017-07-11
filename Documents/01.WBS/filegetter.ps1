cat $Table_Dir/FileList_E.txt|%{if($_ -like "*WBS*"){$_}}
