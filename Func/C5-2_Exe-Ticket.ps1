function global:Exe-Ticket{

# �֐������s���ꂽ��ɓf���o���ꂽTicketList�����Ɏ��s

param(
	$TicketFile=$(ls -name "_TicketList.csv")
)

$TicketFile|%{
	ipcsv $_ -encoding default|%{
	
		# �^�C�~���O�ɂ����{�L���𔻒�
		if($_.Timing -eq "Confirm"){
			#[ValidateSet('Yes','No')]$Answer=Read-Host ($_.Ticket+" �����s���܂����HYes/No")
			#if($Answer -eq 'No'){return}
			if((Read-Host ($_.Ticket+" �����s���܂����HYes/No")) -eq 'No'){return}
		} 
	
		if($_.SrcPath){$SrcPathCommand=" -SrcPath "+$_.SrcPath}else{$SrcPathCommand=""}
		if($_.InFile){$InCommand=" -infile "+$_.InFile}else{$InCommand=""}
		if($_.OutFile){$OutCommand=" -outfile "+$_.OutFile}else{$OutCommand=""}
		if($_.Row){$RowCommand=" -row "+$_.Row}else{$RowCommand=""}
		if($_.Line){$LineCommand=" -line "+$_.Line}else{$LineCommand=""}
	
		Invoke-Expression ($_.CommandName + $SrcPathCommand + $InCommand + $OutCommand + $RowCommand + $LineCommand)
	
	}
}
}