# NaughtySlave
Powershellで作られた、業務自動化支援アプリです！  
最小限の手間で業務の完全自動化を出来るようにします！！  
Implementorって役割の人とUserって役割の人を想定してて、ImplementorはUserに、NaughtySlaveの色々使い方を教えてあげる想定です。  
Implementorは、多少コマンドをいじれる人を想定してて、NaughtySlaveの仕様を理解出来る人を想定してます。  
Userはimplementorに色々ご教示頂きながら、頑張って自身の業務を自動化していきます。

## NaughtySlaveの動作
Powershellを起動すると、Profileでグローバル関数群を読み込んで、ディレクトリ構成を元にWBSやDataBaseListをCSV出力します。  
予め定義されたTicketファイルを、順に実行します。  
一般的には、必要な場所から必要なファイルを取ってきて、ディレクトリ配下にあるエクセルをシート別にCSV化して$datalistとしてハッシュでKeyをcsv名、ValueをDataの形で保存。  
DefineSheetを元に、

## Implementorがすること
1. NaughtySlaveの動作理解  
と言ってもNaughtySlaveを理解することはそんなに難しくなくて、Linuxの基礎的なコマンドを一通り使える人なら大丈夫です。

1. 環境設定  
最低限ExecutionPolicyを設定して実行出来るようにするのと、変数csvファイルとかを編集してUserがNaughtySlaveを使えるようにします。  

1. DataBaseList作成  
　決められたフォルダの第一階層に「Database名」、第二階層に「Table名」となるようにフォルダを作成します。  
　サンプルを用意してますので、それを貴社内の実際のDatabaseやTableに置き換えて下さい。  
　Tableは、それ程厳密じゃなくて大丈夫です。

1. Userとのコミニケーション  
　Userに色々教えてあげて下さい。

## Userがすること
1. WBS作成  
　決められたフォルダの第一階層に「Project名」、第二階層に「Work名」となるようにフォルダを作成します。  
　いっつも仕事でやってるような感じで、多少間違ってても、フォルダを消したり作ったりしたら大丈夫です。 
  
1. DefineDataSheet更新
　決められたフォルダにファイルを置くと、DefineDataSheetが勝手に作られてるかと思います。  
　最初はImplementorに聞きながら、


