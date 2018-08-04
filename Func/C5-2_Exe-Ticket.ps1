function global:Exe-Ticket{

# 関数が実行された後に吐き出されたTicketListを元に実行

param(
	$TicketFile=$(ls -name "_TicketList.csv")
)

$TicketFile|%{
	ipcsv $_ -encoding default|%{
	
		# タイミングによる実施有無を判定
		if($_.Timing -eq "confirm"){
			#[ValidateSet('Yes','No')]$Answer=Read-Host ($_.Ticket+" を実行しますか？Yes/No")
			#if($Answer -eq 'No'){return}
			if((Read-Host ($_.Ticket+" を実行しますか？Yes/No")) -eq 'No'){return}
		} 
	
		if($_.WorkDir){$WorkDirCommand=" -WorkDir "+$_.WorkDir}else{$WorkDirCommand=""}
		if($_.InFile){$InCommand=" -infile "+$_.InFile}else{$InCommand=""}
		if($_.OutFile){$OutCommand=" -outfile "+$_.OutFile}else{$OutCommand=""}
		if($_.Row){$RowCommand=" -row "+$_.Row}else{$RowCommand=""}
		if($_.Line){$LineCommand=" -line "+$_.Line}else{$LineCommand=""}
	
		Invoke-Expression ($_.CommandName + $WorkDirCommand + $InCommand + $OutCommand + $RowCommand + $LineCommand)
	
	}
}
}