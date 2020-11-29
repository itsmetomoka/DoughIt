# DoughIt


## サイト概要
料理教室を開きたいけど、どこで集客すればいいかわからない方や、どこの料理教室に通おうか迷っている人向けのアプリ
受講者や開催されるエリアや料理のジャンルから料理教室を探すことができ、サイト内で申込みをすることができます。
主催者は開催内容、開催場所、費用などを設定するだけで参加者を集うことができます。
生地を意味するDoughとDo itを掛け合わせた造語です。

### サイトテーマ
料理教室を開きたい人と参加したい人をつなげる

### テーマを選んだ理由
個人で教室を開いていたりレストランもお昼に料理教室を開いていて街中でも見かけますが、大手以外の料理教室はSNSの個人ページで集客していて探しにくいと感じていました。
実際に個人で教室を開くには集客するのが一番大変だという話も聞いたことがあったので、料理教室の投稿もできて予約もできるようなサイトがあればあればいいなと思い作成に至りました。


### 主な利用シーン
料理教室を開きたいけど、集客がうまくいかない人が簡単に教室の参加者の募集を投稿でき、教室を探している方は複数の検索項目で簡単にいきたい教室を見つけれるサイトです。

## ER図

<img width="1225" alt="スクリーンショット 2020-11-13 17 35 12" src="https://user-images.githubusercontent.com/68732682/99046906-c8619700-25d6-11eb-998f-de63f5d44f57.png">

## 環境/使用技術

### 機能
- 予約機能
- 投稿機能
- いいね機能
- コメント機能
- 画像レビュー機能
- 通知機能(自分のレッスンにいいね・コメント・予約が入った時に通知)
- 定時処理（予約できないレッスンは自動削除)
- カレンダーで予定を一覧
- 検索機能(複数条件で絞り込み)
- 並び替え機能機能(新着順、開催日順等)

機能詳細
https://docs.google.com/spreadsheets/d/1SG6ZrfuwX4_mGyklwoQ7hvsJBisnklqdmlLrzKLPVjw/edit?usp=sharing

### インフラ構造
<img width="1225" alt="スクリーンショット 2020-11-26 23 43 33" src="https://user-images.githubusercontent.com/68732682/100364481-8a865900-3041-11eb-8e9e-9b3b86380efd.png">

### 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- 仮想環境：Vagrant,VirtualBox

### 本番環境
- AWS (EC2, RDS for MySQL, Route53, CloudWatch, S3, Lambda)
- MySQL2
- Nginx, Puma, Capistrano

### 使用技術
- 非同期通信(お気に入り、コメント、画像プレビュー画面、ページネーション、通知削除)
- kaminari(ページネーション)
- 外部API(Google MapAPI、Geocoding API)
- Rubocop-airbnb
- Rspect(１４０以上のテスト）
- whenever(定時処理)
- HTTPS接続(Certbot)

## 使用素材
- フリー素材サイト　photoAC (https://www.photo-ac.com/)


