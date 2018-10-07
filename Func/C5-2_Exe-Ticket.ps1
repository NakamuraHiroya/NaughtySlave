function global:Exe-Ticket{

# 関数が実行された後に吐き出されたTicketListを元に実行

param(
	$WorkDir=$((pwd).Path),
	$TicketFile=$(ls -name "_TicketList.csv")
)

pushd $WorkDir

$TicketFile|%{
	ipcsv $_ -encoding default|%{
	
		# タイミングによる実施有無を判定
		if($_.Timing -eq "Confirm"){
			#[ValidateSet('Yes','No')]$Answer=Read-Host ($_.Ticket+" を実行しますか？Yes/No")
			#if($Answer -eq 'No'){return}
			if((Read-Host ($_.Ticket+" を実行しますか？Yes/No")) -eq 'No'){return}
		}
		
		if($_.Timing -eq "Manual"){return}
		
		# メッセージ
		(pwd).path+":"+$_.Ticket+"を実行開始します"
		
		if($_.WorkDir){$WorkDirCommand=" -WorkDir "+$_.WorkDir}else{$WorkDirCommand=""}
		if($_.InFile){$InCommand=" -infile "+$_.InFile}else{$InCommand=""}
		if($_.OutFile){$OutCommand=" -outfile "+$_.OutFile}else{$OutCommand=""}
		if($_.Row){$RowCommand=" -row "+$_.Row}else{$RowCommand=""}
		if($_.Line){$LineCommand=" -line "+$_.Line}else{$LineCommand=""}
		if($_.Value){$ValueCommand=" -Value "+$_.Value}else{$ValueCommand=""}
		if($_.SrcPath){$SrcPathCommand=" -SrcPath "+$_.SrcPath}else{$SrcPathCommand=""}
		if($_.SrcDir)   {$SrcDirCommand=" -SrcDir "+$_.SrcDir}else{$SrcDirCommand=""}
		if($_.DistPath) {$DistPathCommand=" -DistPath "+$_.DistPath}else{$DistPathCommand=""}
		if($_.DistDir)  {$DistDirCommand=" -DistDir "+$_.DistDir}else{$DistDirCommand=""}
	
		# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcPath,SrcDir,DistPath,DistDir
	
		Invoke-Expression ($_.CommandName + $WorkDirCommand + $InCommand + $OutCommand + $RowCommand + $LineCommand + $ValueCommand + $SrcPathCommand + $SrcDirCommand + $DistPathCommand + $DistDirCommand)
	
	}
}

popd

}