function global:SourceManager{

param($WorkDir=$TABLE_DIR)

# 一番最初の場合、ディレクトリ作るところから。作ってからCodeManager呼び出し
cd $WorkDir

$NewSourceList=$(
# 最初の処理
if(-not(Test-Path $WorkDir/_Code)){mkdir $WorkDir/_Code}

# あなたが情報にアクセス出来る人名一覧を教えて下さい。 # waitprocessで待つ
./NaturalPersonCode.csv

# あなたが情報にアクセス出来る会社名を教えて下さい。
./JuridicalPersonCode.csv

# あなたが情報にアクセス出来るWEBServiceを教えて下さい。
./WebServiceCode.csv

# あなたが情報にアクセス出来るアプリケーションを教えて下さい。

)
# listmanager呼び出して、TableListを作りたい。



}