function global:Exe-Function{
# DefineSheet��Function��ɑ΂��Ċ֐������s����B

param(
	$InFile=$(ls -name *.csv -Exclude Define*,_*|ogv -passThru -Title "�t�@�C�����w�肵�ĉ������B"),
	$WorkDir=$((pwd).path),
	$DefineSheet=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$OutFile=$($InFile),
	$Ticket
)
begin{
	pushd $WorkDir
	}
process{
	$Property_CustomList=ipcsv $DefineSheet -encoding default|?{$_.Function}
	$Property_CustomList|%{
		$Property=$_.Property
		$Function=$_.Function
	
		$Data=ipcsv $InFile -Encoding Default
		$Data|%{$_.$Property=(Invoke-Expression $Function)}
		$Data|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default
		}
	# �`�P�b�g���O�쐬
	$FunctionName=$MyInvocation.MyCommand.Name
	if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,$SrcDir,$SrcPath,$DistDir,$DistPath,$DefineSheet"}
	}
end{
	popd
	}
}