# docker-kaggle

Docker 入門ハンズオンで利用  
Docker で Kaggle 用の環境構築を行うためのサンプルコード

## 必要条件

- docker, docker-compose, make が利用可能であること

※稼働確認は以下の通り

- macOS Catalina: v10.15.7
- Docker Desktop for Mac: v3.1.0
- Docker Engine: v20.10.2
- GNU Make: v3.81

## Docker 基本

Docker の基本的なコマンドを紹介します  
※以降のコマンドは **docker-kaggle ディレクトリ下で実行**するものとします

### docker pull

レジストリ(DockerHub)から Python のイメージをダウンロードする

```sh
docker pull python:latest
```

ダウンロードしたイメージ一覧は以下のコマンドで確認できる

```sh
docker images
```

### docker create

イメージからコンテナを作成する

```sh
docker create -it --name pyc python
# --name: コンテナの名前を指定
# -i: 標準入力を開き続ける
# -t: 疑似端末を割り当てる
```

作成したコンテナの一覧は以下のコマンドで確認できる

```sh
docker ps -a
# -a: 起動状態以外のコンテナも表示する
```

### docker start

コンテナを起動する

```sh
docker start pyc
```

### docker stop

コンテナを停止する

```sh
docker stop pyc
```

### docker attach

起動中のコンテナに入る  
(ローカルの標準入出力・エラー出力を実行中のコンテナと繋げる)

```sh
# docker start pyc で起動しておく
docker attach pyc
```

※コンテナを抜けると、コンテナが停止する(`docker ps -a`で確認)

### docker rm

停止中のコンテナを終了する

```sh
docker rm pyc
```

### docker run

新たにコンテナを作成し、コンテナ内でコマンドを実行する  
(※ローカルに対象のイメージがなければ`pull`も行う)

```sh
docker run -it --name pyc python /bin/bash
# --name: コンテナの名前を指定
# -i: 標準入力を開き続ける
# -t: 疑似端末を割り当てる
```

※コンテナを抜けると、コンテナが停止する(`docker ps -a`で確認)

### docker exec

実行中のコンテナ内でコマンドを実行する

```sh
# docker start pyc で起動しておく
docker exec -it pyc /bin/bash
# -i: 標準入力を開き続ける
# -t: 疑似端末を割り当てる
```

※コンテナを抜けても、コンテナが**停止しない**(`docker ps`で確認)

### オススメの使い方

```sh
docker run -itd --rm --name [コンテナ名] [イメージ名]
docker exec -it [コンテナ名] [実行したいコマンド]
```

メリットは以下の通り

- コンテナを抜けても停止しない(`exec`)
- コンテナを停止したら削除される(`--rm`)

※さらに言うと docker コマンドではなく、1 つのコンテナでも docker-compose コマンドを使う方がオススメ

### bind mount

```sh
docker run -it --rm --name bm-sample --mount type=bind,source=$(pwd),target=/opt python /bin/bash

#------------------
# コンテナ側
#------------------
touch /opt/hoge
exit
```

## Docker Compose による kaggle 開発環境構築

Makefile にて以下のコマンドを用意している

| コマンド | 内容                         |
| -------- | ---------------------------- |
| setup    | 事前準備                     |
| up       | jupyter notebook 起動        |
| build-up | ビルド&起動                  |
| exec     | 起動済みコンテナで bash 起動 |
| down     | コンテナ終了                 |

### 基本的な使い方

```sh
make setup  # dataディレクトリ, .envファイルを作成
make up     # ブラウザでlocalhost:9000にアクセスしてJupyterに接続
make exec   # kaggke API等でデータのダウンロード等も可能
make down   # コンテナ終了
```

### 必要なパッケージを追加

```sh
# jupyter/.docker/requirements.txtを修正
make build-up # 再ビルドしてコンテナを起動
```

## 参考サイト

- [Docker ドキュメント(日本語翻訳)](https://matsuand.github.io/docs.docker.jp.onthefly/)
- [docker で volume をマウントしたときのファイルの owner 問題](https://qiita.com/yohm/items/047b2e68d008ebb0f001)
