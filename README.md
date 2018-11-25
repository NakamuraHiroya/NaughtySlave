# NaughtySlave
NaughtySlaveは、Powershellで書かれた、オフィス業務自動化支援コマンドレット群です。
統合型問題解決パッケージFunnyFriendsSeries(*1)の一つです。
どこかのデータベースからローカルサーバにファイルを落とし、一旦ファイルをオブジェクトにし、加工し、どこかのデータベースにアップロードするまでの一連の作業（巷で言うところの「インタフェース」）について自動化を支援します。

## CopyRight And CopyLeft
PowershellはMicrosoft社が開発した言語で、ライセンスはMIT Licenseが適用されています。  
NaughtySlaveはPowershellの派生ソフトウェアであり、NaughtySlaveの著作権は中村浩也にあります。  
NaughtySlaveは自由ソフトウェアで、ライセンスはGPLv2を適用しています。自由ソフトウェアについては、リンクをご覧ください。
[自由ソフトウェア](https://www.gnu.org/philosophy/free-sw.ja.html "GNU") 

# QuickStart
NaughtySlaveを使うにあたって、最低限何をすれば良いのでしょうか？<要記載>  

# Spec
## Common
### Out-GridViewによるNavigate
NaughtySlaveに含まれるすべてのコマンドレットは、オプションを選択しないで実行すると、何をするかを標準コマンドレットであるOut-GridViewによりナビゲートします。
従って、「とりあえずコマンドを実行する」ことで、動作が学習出来ます。

### 定義書の元ファイル作成
NaughtySlaveでは、Create-DefineSheetコマンドで定義書の元となるCSVファイル、_DefineSheet.csvを作成します。このCSVファイルをエクセルやエディタで開き、更新し、やりたいことを定義します。この定義書は難解な書かれ方をされておらず、誰でもなんとなくどのように動作するかがわかるようになっています。

### TicketListによる再現
NaughtySlaveでは、全てのコマンドレットについて、-Ticketオプションをつけて実行することにより、自動的にCSVファイル_TicketList.csvを作成します。  
このTicketListに記載された内容もまた、誰でもなんとなくどのような動作を意図とした内容かがわかるはずです。
そして、Exe-Ticketコマンドを実行することによって、簡単に実行を再現することが出来ます。

### Scriptless
NaughtySlaveは、上述の通り、_DefineSheet.csvと_TicketList.csvファイルを元に動作します。
つまり、Scriptlessです。また、NaughtySlaveのコマンドは、1ファイル50行未満で書かれています。

## Major Command
NaughtySlaveの主なコマンドについて解説します。

### C1_PathFamily
ファイル自体をコピーしたり移動したりすることを目的としたコマンドレット群です。
#### Get-File

### C2_FileFamily 
ファイルに対して処理されるコマンドレット群です。ファイルをテーブル化されたCSVデータにすることを目的とします。

#### Convert-XLSFileToCSVFiles
エクセルファイルを、シートの数だけCSVファイルに展開します。

### C3_DataFamily
3系のコマンドレットは、全てDefineSheetというファイルを元に、CSVファイルを様々な形に加工します。
NaughtySlaveでは、csvファイルをcustomobjectに変換した状態のものをDataと呼びます。

#### Set-Data
NaughtySlaveでは、メモリ上に一時的に格納された揮発性のDataを保持し、必要に応じて利用します。
永続的にデータを保存する一般的なデータベースに比べて、柔軟にデータを取り扱うことが出来ます。この簡易データストアはPersonaと呼ばれます。
Set-Dataコマンドを用いて、Personaにデータを格納します。

#### Get-Data
Personaより必要なデータを取り出す時、Get-Dataコマンドを使います。

#### Create-DefineSheet
定義シートを作成します。NaughtySlaveでは、作成された定義シートを更新し、別コマンドを実行することにより簡単に自動化を実現します。

#### Exe-Funciton
DefineSheetのFunction列に記入された関数または変数を実行(Invoke)します。

1. グローバル変数
　グローバル変数リストに入っている変数は、そのまま使うことが可能です。
 例：'$yyyymmdd'

2. ローカル変数
　'$_."列名"'と記入することで他の列に入っている値を参照することが可能です。
 
3. Function関数
　NaughtySlaveでは、関数は列に対して適用され、エクセルと同じようにいくつかの関数を用意しています。
　一つ違うのは、その列に対してすべて関数が適応されるという点です。

### C4_ReportFamily
4系のコマンドレット群は、レポーティングに特化しています。

#### Convert-CSVFilesToXLSFile
複数のCSVファイルをまとめて1つのエクセルファイルのシートにします。

### C5_ExeFamily
5系のコマンドレット群では、実行に特化しています。

#### Create-Ticket
Ticketを作成します。通常、このコマンドレットは、通常NaughtySlaveコマンドレットのオプションとして実行されます。

#### Exe-Ticket
TicketFileを元に、やりたいことを実行します。

---
*1:PurpleSpider,InternalBrutus,StrayGoblin,  
  RunawayChariot,NaughtySlaveからなるパッケージ。

---

Copyright © 2018- NakamuraHiroya All Rights Reserved.
