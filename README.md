# Fjord Boot Camp CONTRIBUTORS
Fjord Boot Camp CONTRIBUTORSは、フィヨルドブートキャンプで行うチーム開発プラクティス(正式には、開発に参加してPRを送りマージする)にて、リポジトリに所属するContributorのcommit数を集計し、ランキングを表示するサイトです。

## 機能
- contributorsランキング

- commit一覧

- 検索

## 使用技術
### バックエンド
- Rails
### フロントエンド
- React
### インフラ
- Railway
### 外部連携サービス
- New Relic
### 外部API連携
- Github

0,6,12,18時の4回毎日Githubの[リポジトリ](https://github.com/fjordllc/bootcamp)からcontributorとcommitを取得しています。
New Relicからwebサービスに対して、pingを実行することでトリガーとし、contributorとcommitを取得します。

## 環境構築
- clone
```
git clone https://github.com/rosh-1228/fjord-boot-camp-contributors.git
```
- lint
```
bin/lint
```
- spec(システムテスト)
```
bundle exec rspec spec/
```
- secret key

`Rails.application.credentials`を使用しているので、Master.keyが必要な場合はご連絡ください。
