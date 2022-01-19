brew services start mysql
mysqlログイン mysql -u root -p
homebrew:について：https://qiita.com/omega999/items/6f65217b81ad3fffe7e6

SQLのもつ機能
1,中に入ったデータをあつかうもの ex)データを更新
    DML（Data Manipulation Language)

2,データを格納する器そのものをあつかうもの ex)テーブルをCREATE
    DDL（Data Definition Language)

代表的なSQL セキュリティや同時アクセスに強い弱いなど違いがあるみたいなので開発環境によって使い分ける？
・Oracle （Oracle社）
・SQLServer（Microsoft社）
・MySQL（Oracle社）
・PostgreSQL（OSS）

データベースは通常一人でしか使えない？
が、データベース管理システム(DBMS:database management system)というソフトを使うことで
複数の利用者で大量のデータを共同利用できるようになる


-- テーブル結合
JOIN == INNER JOIN
JOINは条件にマッチしないレコードが消えるという集計ミスがありがちなので気をつける!!!
LEFT JOIN == LEFT OUTER JOIN
値がないデータにもnullをつけて表示してくれる
LEFT・・・from(ひだり)に従う
RIGHT・・・on(みぎ)に従う

レンズをイメージするとわかりやすい

サブクエリは重いし、複雑になりがちなので極力使わないのがベター