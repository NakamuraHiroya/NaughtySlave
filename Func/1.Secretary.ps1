function global:Secretary{

cd $HOME_DIR

start .

#ProjectList�쐬
#if(-not(test-path (Join-path $NS_DIR ProjectList.csv))){Set-Content $NS_DIR/ProjectList.csv "DivisionCode,ProjectCode,PathCode" -Encoding Default;ls $NS_DIR|?{$_.Attributes -like "Directory"}|%{$_.Parent.Name+","+$_.Name+","+$_.FullName}|Out-File $NS_DIR/ProjectList.csv -Append -Encoding default}

#�����̂�邱�Ƃ�\�����Ă����
$Data["TODO.csv"]

#WBS
ls */*/*/ticketlist.csv|%{$TicketList+=OpenCSVFile $_.FullName};$TicketList|Export-CSV WBS.csv -encoding default -notypeinformation


}

