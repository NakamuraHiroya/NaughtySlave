function global:Create-DefineSheet{
# ��`�V�[�g���쐬����B

param(
	$InFile=$(ls -name *.csv -Exclude Define*,_*|ogv -PassThru -Title "�t�@�C�����w�肵�ĉ������B"),
	$WorkDir=$((pwd).path),
	$OutFile=$("_DefineSheet_"+($InFile -split "\.")[0]+".csv"),
	$Ticket
)
begin{
	pushd $WorkDir
	}
process{
	if(-not(Test-Path $OutFile)){
		Set-Content $OutFile "InFile,Property,Order,Sort,Key,Type,Min,Max,Function,ForeignMaster,ForeignKey,ForeignValue" -Encoding Default
		
		(cat $InFile)[0]|%{$Header=$_ -split ","}
		(cat $Infile)[1]|%{$SampleData=$_ -split ","}
		
		$i=0
		
		$Header|%{$Infile+","+$Header[$i]+","+($i+1)+","+" "+","+((Guess-ValueType $Sampledata[$i]).gettype().name);$i++}|Out-file $OutFile -Encoding Default -Append
	}
	# �`�P�b�g���O�쐬
	$FunctionName=$MyInvocation.MyCommand.Name
	if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,$InFile,$OutFile,$Row,$Line,$Value,$SrcDir,$SrcPath,$DistDir,$DistPath,$DefineSheet"}
	}
end{
	popd
	}
}
