function global:XrossData{

param(
	$InFile=$(ls -name *.csv -exclude _*|ogv -passThru -Title "クロス集計したいファイルを選択して下さい。"),
	$line=$((cat $InFile -First 1) -split ","|ogv -PassThru -Title "行となるラベルを選択して下さい。"),
	$Row=$((cat $InFile -First 1) -split ","|ogv -PassThru -Title "列となるラベルを選択して下さい。"),
	$Sum=$((cat $InFile -First 1) -split ","|ogv -PassThru -Title "集計対象となるラベルを選択して下さい。"),
	$OutFile=$(($InFile -split "\.")[0]+"_Pivot.csv"),
	$Ticket
)

$data = ipcsv $InFile -encoding default

$ULine=$data|group $line|select Name
$URow =$data|group $Row |select Name

$result = @()

# 最終表示項目（PJコード、原価内訳、合計）を持つオブジェクトを作成する関数
function getObject {
    $obj = New-Object -TypeName PSObject
    $obj | Add-Member -MemberType NoteProperty -Name $line -Value $result[0].$line
    # オブジェクトのメンバーにタイプ（外注費や加工費）を加える
    foreach($t in $URow) {
        $obj | Add-Member -MemberType NoteProperty -Name $t.Name -Value 0
    }
    $obj | Add-Member -MemberType NoteProperty -Name total -Value 0
    return $obj
}

# プロジェクトコード別、タイプ別に金額を集計するための入れ物を作る
foreach($pj in $ULine) {
    foreach($ty in $URow) {
        $obj = New-Object psobject |Select $line, $Row, $sum
        $obj.$line = $pj.Name
        $obj.$Row = $ty.Name
        $obj.$sum = 0
        $result += $obj
    }
}

# プロジェクトコード別、タイプ別に金額を集計する
foreach($d in $data) {
    foreach($r in $result) {
        if( ($d.$line -eq $r.$line) -and ($d.$Row -eq $r.$Row) ) {
            $r.$sum += $d.$sum
            break
        }
    }
}

# プロジェクトコード順に$resultを並び変える
$result = $result | Sort-Object {$_.$line}

# プロジェクトコード別の原価内訳金額を集計
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

# プロジェクトコード別の原価合計を算出
foreach($cT in $costTable) {
    $sum = 0
    foreach($t in $URow) {
        $sum += $cT.($t.Name)
    }
    $cT.total = $sum
}

# 最終結果を表示
$costTable|export-csv $OutFile -Encoding Default -NoTypeInformation

# チケットログ作成
if($Ticket){
	CreateTicketData -Ticket $Ticket -Command "XrossData" -InFile $InFile -OutFile $OutFile
}

}