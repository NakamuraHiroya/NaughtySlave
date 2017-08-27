function global:SourceManager{

param(
	$ThisDir=$(cd $TABLE_DIR),
	[Switch]$Init,
	$Ticket=$(
		$CSV["_TicketList.csv"].TicketCode|ogv -PassThru -Title (($ThisDir) + "SourceManager 次に何をしますか？")
	)
)

<#---------------------------------------------------------------------------#>
if($init){#初期処理開始
<#---------------------------------------------------------------------------#>
if(-not(Test-Path $ThisDir/_Code)){mkdir $ThisDir/_Code}

Read-Host "あなたが情報にアクセス出来る自然人を教えて下さい。(1/4)"
Wait-Process -id (start ./_Code/NaturalPersonCode.csv -PassThru).id

Read-Host "あなたが情報にアクセス出来る法人を教えて下さい。(2/4)"
Wait-Process -id (start ./_Code/JuridicalPersonCode.csv -PassThru).id

Read-Host "あなたが情報にアクセス出来るWEBServiceを教えて下さい。(3/4)"
Wait-Process -id (start ./_Code/WebServiceCode.csv -PassThru).id

Read-Host "あなたが情報にアクセス出来るアプリケーションを教えて下さい。(4/4)"
Wait-Process -id (start ./_Code/AppCode.csv -PassThru).id

<#---------------------------------------------------------------------------#>
}#初期処理終了
<#---------------------------------------------------------------------------#>
switch($Ticket){

#for文で！

$CSV["_TicketList.csv"].TicketCode[0]{Invoke-Expression $CSV["_TicketList.csv"].ExeCode[0]}
$CSV["_TicketList.csv"].TicketCode[1]{Invoke-Expression $CSV["_TicketList.csv"].ExeCode[1]}
$CSV["_TicketList.csv"].TicketCode[2]{Invoke-Expression $CSV["_TicketList.csv"].ExeCode[2]}

default{"キャンセルが押されたか、選択メニューに無い！"}

}

<#---------------------------------------------------------------------------#>
#Set-Content _ProjectList.csv "ProjectCode,Memo" -Encoding Default
#ls -dir -name -Exclude _*|out-file _ProjectList.csv -Encoding Default -Append
#start .

}
