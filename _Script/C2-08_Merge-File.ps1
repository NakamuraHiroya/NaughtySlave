function global:Merge-File{
# 2�ȏ�́A�u�񖼁v������CSV�t�@�C���̃f�[�^���}�[�W����B

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "merge����t�@�C����I�����ĉ������B"),
	$WorkDir=$((pwd).path),
	$OutFile=$(($InFile -split "\.")[0]+"_Merge.csv"),
	$Ticket
)
begin{
	pushd $WorkDir
	}
process {
	# ���C���h�J�[�h������
	if($InFile.Contains("*")){
		ls -name $InFile -exclude _*|%{
			$data+=ipcsv $_ -Encoding default
		}
	}else{
		$InFile -split " "|%{
			$data+=ipcsv $_ -Encoding default
		}
	}
	$data|ConvertTo-Csv -NoTypeInformation |%{$_.replace('"','')}|out-file $OutFile -encoding default

	# �`�P�b�g���O�쐬
	# "Ticket,Timing,CommandName,WorkDir,InFile,OutFile,Row,Line,Value,SrcDir,SrcPath,DistDir,DistPath
	$FunctionName=$MyInvocation.MyCommand.Name
	if($Ticket){Create-Ticket -Data "$Ticket,Always,$FunctionName,$WorkDir,`"`"`"$InFile`"`"`",$OutFile,$Row,,$Value,,,$DistDir,$DistPath"}
	}
end {
	popd
	}
}
