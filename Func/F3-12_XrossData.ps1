function global:XrossData{

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "�N���X�W�v�������t�@�C����I�����ĉ������B"),
	$line=$((cat $InFile -First 1) -split ","|ogv -PassThru -Title "�s�ƂȂ郉�x����I�����ĉ������B"),
	$Row=$((cat $InFile -First 1) -split ","|ogv -PassThru -Title "��ƂȂ郉�x����I�����ĉ������B"),
	$Sum=$((cat $InFile -First 1) -split ","|ogv -PassThru -Title "�W�v�ΏۂƂȂ郉�x����I�����ĉ������B"),
	$OutFile=$(($InFile -split "\.")[0]+"_Pivot.csv"),
	$Ticket
)

$data = ipcsv $InFile -encoding default

$ULine=$data|group $line|select Name
$URow =$data|group $Row |select Name

$result = @()

# �ŏI�\�����ځiPJ�R�[�h�A��������A���v�j�����I�u�W�F�N�g���쐬����֐�
function getObject {
    $obj = New-Object -TypeName PSObject
    $obj | Add-Member -MemberType NoteProperty -Name $line -Value $result[0].$line
    # �I�u�W�F�N�g�̃����o�[�Ƀ^�C�v�i�O�������H��j��������
    foreach($t in $URow) {
        $obj | Add-Member -MemberType NoteProperty -Name $t.Name -Value 0
    }
    $obj | Add-Member -MemberType NoteProperty -Name total -Value 0
    return $obj
}

# �v���W�F�N�g�R�[�h�ʁA�^�C�v�ʂɋ��z���W�v���邽�߂̓��ꕨ�����
foreach($pj in $ULine) {
    foreach($ty in $URow) {
        $obj = New-Object psobject |Select $line, $Row, $sum
        $obj.$line = $pj.Name
        $obj.$Row = $ty.Name
        $obj.$sum = 0
        $result += $obj
    }
}

# �v���W�F�N�g�R�[�h�ʁA�^�C�v�ʂɋ��z���W�v����
foreach($d in $data) {
    foreach($r in $result) {
        if( ($d.$line -eq $r.$line) -and ($d.$Row -eq $r.$Row) ) {
            $r.$sum += $d.$sum
            break
        }
    }
}

# �v���W�F�N�g�R�[�h����$result����ѕς���
$result = $result | Sort-Object {$_.$line}

# �v���W�F�N�g�R�[�h�ʂ̌���������z���W�v
$obj = getObject

$costTable = @()
foreach($r in $result) {
    if($r.$line -ne $obj.$line) {
        $costTable += $obj
        $obj = getObject
        $obj.$line = $r.$line
    }
    foreach($t in $URow) {
        if($r.$Row -eq $t.Name) {
            $obj.($t.Name) = $r.$sum
        }
    }
}
$costTable += $obj

# �v���W�F�N�g�R�[�h�ʂ̌������v���Z�o
foreach($cT in $costTable) {
    $sum = 0
    foreach($t in $URow) {
        $sum += $cT.($t.Name)
    }
    $cT.total = $sum
}

# �ŏI���ʂ�\��
$costTable|export-csv $OutFile -Encoding Default -NoTypeInformation

# �`�P�b�g���O�쐬
if($Ticket){
	CreateTicketData -Ticket $Ticket -Command "XrossData" -InFile $InFile -OutFile $OutFile
}

}