function global:ExeTicketFile{

# ŠÖ”‚ªÀs‚³‚ê‚½Œã‚É“f‚«o‚³‚ê‚½TicketList‚ğŒ³‚ÉÀs

param(
	$TicketFile=$(ls -name "_TicketList_2.File.csv")
)

$TicketFile|%{
	ipcsv $_ -encoding default|%{
		if($_.InFile){$InCommand=" -infile "+$_.InFile}else{$InCommand=""}
		if($_.OutFile){$OutCommand=" -outfile "+$_.OutFile}else{$OutCommand=""}
		if($_.Row){$RowCommand=" -row "+$_.Row}else{$RowCommand=""}
		if($_.Line){$LineCommand=" -line "+$_.Line}else{$LineCommand=""}
	
		Invoke-Expression ($_.FunctionName + $InCommand + $OutCommand + $RowCommand + $LineCommand)
	
	}
}
}