function global:Define-RowData{
# DefineSheet��Order��ɏ]���ė�̏��Ԃ��`����B���Blank�ɂ��邱�Ƃŗ񂻂̂��̂��폜����

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "�t�@�C����I�����ĉ������B"),
	$WorkDir=$((pwd).path),
	$DefineSheet=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$OutFile=$($InFile),
	$Ticket
)
begin{
	pushd $WorkDir
	}
process{
	$PropertyInfo_OrderList=ipcsv $DefineSheet -encoding default|?{$_.Order}|sort{$_.Order -as [int]}|%{$_.Property}
	
	(ipcsv $InFile -encoding default)|select $PropertyInfo_OrderList|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default

	# �`�P�b�g���O�쐬
	$FunctionName=$MyInvocation.MyCommand.Name
	if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,$SrcDir,$SrcPath,$DistDir,$DistPath,$DefineSheet"}
	
	}
end{
	popd
	}
}
