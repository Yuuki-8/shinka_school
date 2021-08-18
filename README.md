# sinka_reservation

簡易的な予約システムを基にしたSINKA SCHOOLの教材です。
このシステムを基に、エンジニアが知っておくべき最低限の技術を学んでいきましょう。
# Features
* 別途資料に沿って進めていくことで、エンジニアに必要な知識が身につきます。
# Requirement

* ruby 2.7.2
* rails 6
* mysql 8.0.26
* docker
* node v11.5.0
* yarn 1.19.0
# Installation

以下URLからdocker desktopをインストールしてください。

* https://www.docker.com/products/docker-desktop


# Usage

以下コマンドに従って環境構築をしてください。

```bash
git clone リポジトリ名 # リポジトリからコピーしてきます
cd sinka_reservation # コピーしてきたディレクトリに移動します
docker compose build # dockerイメージを作成します
docker compose up -d # コンテナを起動します
docker compose run web rails db:create # dbを作成します
docker compose run web rails db:apply # schemaを基にテーブルを作成します
docker compose run web rails db:apply RAILS_ENV=test # 上記ではdevelopmentにテーブルを作成しますが、こちらではtestに作成します。
docker compose run web rails db:seed # seedファイルに記載してあるデータをinsertします。
```

# Note
環境構築で所々エラーが出ることがあります。想定されるものは以下に記載しておきますので参考にしてください。
* docker compose upでPlease run `yarn install --check-files`が出る（https://qiita.com/ryoji2405/items/1de1f2e9e206382c4aa5）
* Plugin caching_sha2_password could not be loaded...のエラー（https://qiita.com/tomo-IR/items/224d33f14561e759dd16）

# Author

作成情報を列挙する

* 桑原龍樹
* 株式会社BANANA
* tatsuki.kuwahara@banana-877.com

# License