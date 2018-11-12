# NaughtySlave
NaughtySlaveは、Powershellで作られた、オフィス業務自動化支援コマンドレット群です。
統合問題解決パッケージFunnyFriendsシリーズ(PurpleSpider,Brutus,StrayGremlin,NaughtySlave)の一つです。
どこかのデータベースからローカルサーバにファイルを落とし、一旦ファイルをオブジェクトにし、加工し、どこかのデータベースにアップロードするまでの一連の作業について自動化を支援します。

## 著作権について
NaughtySlaveの著作権は中村浩也にあります。
NaughtySlave自由ソフトウェアです。ライセンスはGPLv2を適用しています。自由ソフトウェアについては、リンクをご覧ください。
[自由ソフトウェア](https://www.gnu.org/philosophy/free-sw.ja.html "GNU")

# コマンドレットの仕様
## 共通
### ナビゲート
NaughtySlaveに含まれるすべてのコマンドレットは、標準のコマンドレットと違い、オプションを選択しないで実行すると、何をするかをナビゲートします。
従って「とりあえずコマンドを実行する」ことで、動作が学習出来ます。

### CSVで記載された定義書に基づいた動作
NaughtySlaveは、_TicketList*.csvと、_DefineSheet*.csvを元に動作します。これらのcsvファイルを開くと、あなたが技術者でなくとも「なんとなく」どのように動作しているかがわかるはずです。

### 定義書は誰が書くのか？
ではその定義書は、一体誰が書くのでしょうか？大丈夫です。NaughtySlaveでは、全てのコマンドレットについて、-Ticketオプションをつけることにより、自動的にやることリストを作成します。また、Create-DefineSheetコマンドで定義書を作成します。

## 1 Path系
ファイル自体をコピーしたり移動したりすることを目的としたコマンド群です。
### Get-File

## 2 File系 
ファイルに対して処理されるコマンド群です。ファイルをテーブル化されたCSVデータにすることを目的とします。

### Convert-XLSFileToCSVFile
エクセルファイルを、シートの数だけCSVファイルに展開します。

## 3系
3系の関数は、全てDefineSheetというファイルを元に、CSVファイルを様々な形に加工します。

### C3-1_Create-DefineSheet
定義シートを作成します。NaughtySlaveでは、作成された定義シートを更新し、別コマンドを実行することにより簡単に自動化を実現します。

### C3-4_Exe-Funciton
DefineSheetのFunction列に記入された関数または変数を実行(Invoke)します。

1. グローバル変数
　グローバル変数リストに入っている変数は、そのまま使うことが可能です。
 例：'$yyyymmdd'

2. ローカル変数
　'$_."列名"'と記入することで他の列に入っている値を参照することが可能です。
 
3. 関数
　NaughtySlaveでは、関数は列に対して適用され、エクセルと同じようにいくつかの関数を用意しています。
 例：vlookup
 詳しくは、関数の仕様ページをご覧下さい。
 

## 5系
### T5-1_Create-Ticket
Ticketを作成します。通常、このコマンドレットは、通常NaughtySlave関数のオプションとして実行されます。

### T5-2_Exe-Ticket
TicketFileを元に、コマンドを実行します。

# Functionの仕様
NaughtySlaveでは、関数は、エクセルで使われる関数という同じ意味での関数を指します。
一つ違うのは、その列に対してすべて関数が適応されるという点です。例えば、


Copyright © 2018- NakamuraHiroya All Rights Reserved.
