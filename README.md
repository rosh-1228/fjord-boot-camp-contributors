# Fjord Boot Camp CONTRIBUTORS
Fjord Boot Camp CONTRIBUTORSは、フィヨルドブートキャンプで行うチーム開発プラクティス(正式には、開発に参加してPRを送りマージする)にて、リポジトリに所属するContributorのcommit数を集計し、ランキングを表示するサイトです。

## 機能
- contributorsランキング
![FjordBotCamp_CONTRIBUTORS_All-time___FjordBotCamp_CONTRIBUTORS_🔊](https://user-images.githubusercontent.com/64620506/201597942-cb7fd5cf-1aac-4c76-8662-02e89c2faae3.png)

- commit一覧
![FjordBotCamp_CONTRIBUTORS_This-month___FjordBotCamp_CONTRIBUTORS_🔊](https://user-images.githubusercontent.com/64620506/201598112-d0112af9-0de2-4ec0-979e-2c0e5193165f.png)

- 検索
![FjordBotCamp_CONTRIBUTORS_This-month___FjordBotCamp_CONTRIBUTORS_🔊](https://user-images.githubusercontent.com/64620506/201598053-0c811dd1-02d9-4b71-83e4-5b212cca6b56.png)

## 使用技術
### バックエンド
- Rails
### フロントエンド
- React
### インフラ
- Railway
### 外部API連携
- Github
- Github actions

0,6,12,18時の4回毎日Githubの[リポジトリ](https://github.com/fjordllc/bootcamp)からcontributorとcommitを取得しています。
New Relicからwebサービスに対して、pingを実行することでトリガーとし、contributorとcommitを取得します。

## 環境構築
- clone
```
git clone https://github.com/rosh-1228/fjord-boot-camp-contributors.git
```
## 起動
```
bin/setup
rails s
```
## Lint
- lint
```
bin/lint
```
## Test
- spec(システムテスト)
```
bundle exec rspec spec/
```
