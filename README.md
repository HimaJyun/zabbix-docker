# Zabbixを建てるdocker-compose
自分用、使いたい人居ればどうぞ。

## 使い方
最初に必要なファイルと日本語フォントをダウンロードしてくる`prepare.sh`をrootで実行してね。

```
git clone https://github.com/HimaJyun/zabbix-docker.git
cd zabbix-docker

sudo ./prepare.sh
sudo docker-compose up -d
```

## 要調整
docker-compose.ymlで場合によっては調整が必要な所

- mysqlの`innodb-buffer-pool-size`: `2G`に設定、環境に合わせて調整
- webのポート: `127.0.0.1:8051:80`に設定(これは別のWebサーバーから更にプロキシするのを想定した)、必要なら`8080:80`とかに変更

## 含まれません
このdocker-compose.ymlではサーバーしか建てないので監視周りのアレコレ(agentとかjava-gatewayとかproxyとか)は含まれていません。

必要なら別途用意してね。

## バージョン

- MySQL 8 (MariaDB 10.4だとエラー出た……)
- Zabbix 4.0 (LTSを選択してます、別に最新でも良いかも)

## ライセンス
[LICENSE](https://github.com/HimaJyun/zabbix-docker/blob/master/LICENSE)を参照。

`prepare.sh`を実行すると日本語フォントとして[IPAexフォント](https://ipafont.ipa.go.jp/)がダウンロードされます。

IPAexフォントを使用する際には[IPAフォントライセンス](https://ipafont.ipa.go.jp/ipa_font_license_v1-html)に同意する必要があります。

